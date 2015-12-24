//
//  SelectCarTypeView.m
//  DemoApp
//
//  Created by admin on 24.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "SelectCarTypeView.h"

@interface SelectCarTypeView()
{
	NSArray* _buttons;
	UIVisualEffectView* _blurView;
}
@end

@implementation SelectCarTypeView

-(void)createView
{
	if(_blurView)
	{
		return;
	}
	self.backgroundColor = [UIColor clearColor];
	
	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
	_blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	_blurView.frame = self.bounds;
	_blurView.alpha = 0.7;
	_blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview:_blurView];
	[_blurView release];
	
	UITapGestureRecognizer* tapAnywhere = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhere:)];
	[self addGestureRecognizer:tapAnywhere];
	[tapAnywhere release];
	NSArray* titles = @[NSLocalizedString(@"ALL CARS", @"ALL CARS"),NSLocalizedString(@"ELECTRIC", @"ELECTRIC"),NSLocalizedString(@"HYBRID", @"HYBRID"),NSLocalizedString(@"LPG", @"LPG")];
	for (int i = 0; i<titles.count; i++)
	{
		UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(_lastItemPoint.x, self.lastItemPoint.y - i*(34+5) , 96, 34)];
		button.layer.cornerRadius = 16;
		[button setTitle:titles[i] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		button.backgroundColor = [UIColor colorWithRed:0.231 green:0.745 blue:1.000 alpha:1.000];
		[button.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:17]];
		[button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
		[button release];
	}
	
}
-(void)btnClicked:(UIButton*)button
{
	[self removeFromSuperview];
}
-(void)tapAnywhere:(UIGestureRecognizer*)gesture
{
	[self removeFromSuperview];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
	[super willMoveToSuperview:newSuperview];
	[self createView];
}
@end
