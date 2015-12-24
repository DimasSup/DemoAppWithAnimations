//
//  AnimatedIconView.m
//  DemoApp
//
//  Created by admin on 22.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "AnimatedIconView.h"


@implementation AnimatedIconView {

	CAGradientLayer* _gradientLayer;
}



- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.clipsToBounds = YES;
		_gradientLayer =[[CAGradientLayer alloc] init];
		[_gradientLayer setStartPoint:CGPointMake(0.5, 0)];
		[_gradientLayer setEndPoint:CGPointMake(0.3, 1)];

		_gradientLayer.frame = CGRectMake(0,0, frame.size.width, frame.size.height);
		[self.layer addSublayer:_gradientLayer];
		[_gradientLayer release];
		
		// Create colors using hues in +5 increments
		NSMutableArray *colors = [NSMutableArray new];
		for (NSInteger hue = 150; hue <= 200; hue += 10) {
			
			UIColor *color;

			color = [UIColor colorWithHue:1.0 * hue / 360.0
							   saturation:0.7
							   brightness:0.8
									alpha:1.0];
			[colors addObject:(id)[color CGColor]];
		}
		NSInteger c = colors.count;
		for (NSUInteger  i = c-1; i>0; i--)
		{
			[colors addObject:colors[i]];
		}
		[_gradientLayer setColors:[NSArray arrayWithArray:colors]];
		[colors release];
		CAShapeLayer* maskLayer = [[CAShapeLayer alloc] init];
		maskLayer.frame = self.bounds;
		
		UIBezierPath* path = [[UIBezierPath alloc] init];
		[path moveToPoint:CGPointMake(self.bounds.size.width/2+self.bounds.size.width*0.05, 0)];
		[path addLineToPoint:CGPointMake(0, self.bounds.size.height/2+self.bounds.size.height*0.1)];
		[path addLineToPoint:CGPointMake(self.bounds.size.width/2-self.bounds.size.width*0.05, path.currentPoint.y)];
		[path addLineToPoint:CGPointMake(self.bounds.size.width/2-self.bounds.size.width*0.05,self.bounds.size.height)];
		[path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height/2-self.bounds.size.height*0.1)];
		[path addLineToPoint:CGPointMake(self.bounds.size.width/2+self.bounds.size.width*0.05, path.currentPoint.y)];
		[path addLineToPoint:CGPointMake(self.bounds.size.width/2+self.bounds.size.width*0.05, 0)];
		[path fill];
		
		maskLayer.path = [path CGPath];
		[path release];
		[self.layer setMask:maskLayer];
		[maskLayer release];
	}
	return self;
}


-(void)animateMe
{
	[self performAnimation];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self animateColors];
}

- (void)performAnimation {
	// Move the last color in the array to the front
	// shifting all the other colors.
	NSMutableArray *mutable = [[_gradientLayer colors] mutableCopy];
	id lastColor = [[mutable lastObject] retain];
	[mutable removeLastObject];
	[mutable insertObject:lastColor atIndex:0];
	[lastColor release];
	NSArray *shiftedColors = [NSArray arrayWithArray:mutable];
	[mutable release];
 
	// Update the colors on the model layer
	[_gradientLayer setColors:shiftedColors];
 
	// Create an animation to slowly move the gradient left to right.
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"colors"];
//	animation.fromValue = [_gradientLayer valueForKey:@"colors"];
	[animation setToValue:shiftedColors];
	[animation setDuration:0.05];
	[animation setRemovedOnCompletion:YES];
//	[animation setFillMode:kCAFillModeForwards];
	[animation setDelegate:self];
	[_gradientLayer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
	[self performAnimation];
}


-(void)dealloc
{
	[super dealloc];
}
@end
