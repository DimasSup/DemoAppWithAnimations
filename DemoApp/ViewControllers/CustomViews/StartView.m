//
//  StartView.m
//  DemoApp
//
//  Created by admin on 23.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "StartView.h"
#import "StartItemView.h"
@interface StartView()<StartItemViewDelegate>
{
	NSMutableArray* _items;
	NSMutableArray* _states;
	
	CGRect _startPosition;
	CGRect _normalPosition;
	CGRect _endPosition;
	
	float _startRotation;
	float _normalRotation;
	float _endRotation;
	CGSize _itemSize;
	
	int _currentStep;

	UIButton* _finishButton;
	UIImageView* _logoImageView;
	
	UISwipeGestureRecognizer* _leftGesture;
	UISwipeGestureRecognizer* _rightGesture;
	
}
@end

@implementation StartView

-(instancetype)init
{
	self = [super init];
	if(self)
	{
	
	}
	return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
	}
	return self;
}
-(void)beginLoad
{
	if(_states)
	{
		return;
	}
	_itemSize = CGSizeMake(290, 442);
	_currentStep = -1;
	_states = [NSMutableArray new];
	[_states addObject:@{@"txt":NSLocalizedString(@"Most economy friendly taxi service.", @"Most economy friendly taxi service."),@"color":[UIColor colorWithRed:0.000 green:0.592 blue:0.886 alpha:1.000]}];
	[_states addObject:@{@"txt":NSLocalizedString(@"Therefore a lot cheaper than avarage taxi ride.", @"Therefore a lot cheaper than avarage taxi ride."),@"color":[UIColor colorWithRed:0.420 green:0.722 blue:0.322 alpha:1.000]}];
	[_states addObject:@{@"txt":NSLocalizedString(@"As simple as that. Happy taxiriding.", @"As simple as that. Happy taxiriding."),@"color":[UIColor colorWithRed:0.918 green:0.788 blue:0.000 alpha:1.000]}];
	self.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
	_leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
	_leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
	[self addGestureRecognizer:_leftGesture];
	_leftGesture.enabled = NO;
	[_leftGesture release];
	
	_rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
	_rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
	[self addGestureRecognizer:_rightGesture];
	_rightGesture.enabled = NO;
	[_rightGesture release];

	
	//Delay for best visual exp.
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		[self performSelectorInBackground:@selector(preloadImages) withObject:nil];
	});

}

-(void)preloadImages
{
	NSMutableArray* images = [NSMutableArray new];
	for (int i = 1; i<=3; i++)
	{
		UIImage* image =[UIImage imageNamed:NSStringFormat(@"startscreen%i",i)];
		[images addObject:image];
		
	}
	[self performSelectorOnMainThread:@selector(createItems:) withObject:images waitUntilDone:YES];
	[images release];
}
-(void)createItems:(NSArray*)images
{
	_leftGesture.enabled = YES;
	_rightGesture.enabled = YES;
	_startRotation = 0.5;
	_endRotation = -0.5;
	_normalRotation = 0;
	
	_startPosition = CGRectMake(self.bounds.size.width +_itemSize.width/2, self.bounds.size.height - _itemSize.height, _itemSize.width, _itemSize.height);
	_normalPosition = CGRectMake(self.bounds.size.width/2 - _itemSize.width/2, self.bounds.size.height - _itemSize.height+6, _itemSize.width, _itemSize.height);
	_endPosition = CGRectMake(-_itemSize.width - _itemSize.width/2, self.bounds.size.height - _itemSize.height, _itemSize.width, _itemSize.height);
	
	
	
	_logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_shape"]];
	_logoImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
	CGRect r = CGRectZero;
	r.size = _logoImageView.image.size;
	r.origin.x = self.bounds.size.width/2 - r.size.width/2;
	r.origin.y = _normalPosition.origin.y;
	_logoImageView.frame = r;
	_logoImageView.alpha = 0;
	[self addSubview:_logoImageView];
	[_logoImageView release];
	r.origin.y = 40;
	
	[UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_logoImageView.frame = r;
		_logoImageView.alpha = 1;
	} completion:^(BOOL finished) {
		
	}];
	
	
	_items = [NSMutableArray new];
	for (int  i = 0; i<images.count; i++)
	{
		StartItemView* item = [[StartItemView alloc] initWithFrame:CGRectZero];
		item.delegate = self;
		item.showNext = (i!=(images.count-1));
		item.showPrevious = (i!=(images.count-1)) && i!=0;
		item.frame = _startPosition;
		item.alpha = 0;
		item.detailsText.text = _states[i][@"txt"];
		item.orderText.text = NSStringFormat(@"%i",i+1);
		item.imageView.image = images[i];
		[_items addObject:item];
		[self addSubview:item];
		item.transform = CGAffineTransformMakeRotation(_startRotation);
		[item release];
		
	}
	

	CGSize buttonSize = CGSizeMake(170, 48);
	_finishButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - buttonSize.width/2, self.frame.size.height-30 - buttonSize.height, buttonSize.width, buttonSize.height)];
	[_finishButton.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
	[_finishButton setTitle:NSLocalizedString(@"Let's crab a cab", @"Let's crab a cab") forState:UIControlStateNormal];
	[_finishButton.titleLabel setFont:[UIFont fontWithName:@"Roboto" size:18]];
	[_finishButton addTarget:self action:@selector(onFinishClicked:) forControlEvents:UIControlEventTouchUpInside];
	_finishButton.hidden = YES;
	_finishButton.backgroundColor = [UIColor whiteColor];
	_finishButton.layer.cornerRadius = buttonSize.height/2;
	[_finishButton setTitleColor:[UIColor colorWithWhite:0.231 alpha:1.000] forState:UIControlStateNormal];
	_finishButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
	_finishButton.alpha = 0;
	[self addSubview:_finishButton];
	[_finishButton release];
	
	
	
	
	[self showStep:0];
	if(self.delegate && [self.delegate respondsToSelector:@selector(startViewLoadComplete:)])
	{
		[self.delegate startViewLoadComplete:self];
	}
}
#pragma mark - navigation
-(void)showStep:(int)step
{
	
	if(_currentStep>=0)
	{
		StartItemView* item = _items[_currentStep];
		CGRect endRect = _currentStep>step?_startPosition:_endPosition;
		float rotation = _currentStep>step?_startRotation:_endRotation;
		[UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
			
			item.frame = endRect;
			
			item.transform = CGAffineTransformMakeRotation(rotation);
			item.alpha = 0;
		} completion:^(BOOL finished) {
			
		}];
		
	}
	StartItemView* item = _items[step];
	CGRect endRect = _normalPosition;

	[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		item.transform = CGAffineTransformIdentity;
		
		item.alpha = 1;
		item.frame = endRect;
		
		
		self.backgroundColor = _states[step][@"color"];
	} completion:^(BOOL finished) {
		
	}];
	if(step == _items.count-1)
	{
		if(self.delegate && [self.delegate respondsToSelector:@selector(startViewLastStepShowed:)])
		{
			[self.delegate startViewLastStepShowed:self];
		}
		_finishButton.hidden = NO;
		[UIView animateWithDuration:0.5 delay:1.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
			_finishButton.alpha=1;
		} completion:^(BOOL finished) {
			
		}];
	}
	_currentStep = step;
}
#pragma mark - actions
-(void)swipeLeft:(UIGestureRecognizer*)gesture
{
	[self startItemViewNextClicked:nil];
	
}
-(void)swipeRight:(UIGestureRecognizer*)gestur
{
	if (_currentStep!=_items.count-1)
	{
		[self startItemViewPreviousClicked:nil];
	}
}

- (void)startItemViewPreviousClicked:(StartItemView *)item
{
	int step =MAX(0,_currentStep-1);
	if(step!=_currentStep)
	{
		[self showStep:step];
	}
}
- (void)startItemViewNextClicked:(StartItemView *)item
{
	int step =MIN(_items.count-1,_currentStep+1);
	if(step!=_currentStep)
	{
		[self showStep:step];
	}
}
-(void)onFinishClicked:(UIButton*)button
{
	[UIView animateWithDuration:2 animations:^{
		[_finishButton setTransform:CGAffineTransformMakeScale(4, 4)];
	}];
	if(self.delegate && [self.delegate respondsToSelector:@selector(startViewFinish:)])
	{
		[self.delegate startViewFinish:self];
	}
}
#pragma mark -
-(void)dealloc
{
	[_items release];
	[_states release];
	[super dealloc];
}

@end
