//
//  StartsViewController.m
//  DemoApp
//
//  Created by admin on 22.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "StartsViewController.h"
#import "StartView.h"
#import "AnimatedIconView.h"
#import "MainMapView.h"

@interface StartsViewController ()<StartViewDelegate>
{
	StartView* _startView;
	AnimatedIconView* _iconView;
	MainMapView* _mapView;
}
@end

@implementation StartsViewController
-(BOOL)prefersStatusBarHidden
{
	return YES;
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	

	_startView = [[StartView alloc] initWithFrame:self.view.bounds];
	_startView.delegate = self;
	[self.view addSubview:_startView];
	_startView.alpha = 0;
	[_startView beginLoad];
	
	_iconView = [[AnimatedIconView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-42/2, self.view.bounds.size.height/2 - 66/2, 42, 66)];
	_iconView.autoresizingMask = UIViewAutoresizingNone;
	[self.view addSubview:_iconView];
	[_iconView release];
	
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[_iconView animateMe];
	
}
#pragma mark - 
-(void)prepareMaps
{
	_mapView =[[MainMapView alloc] initWithFrame:self.view.bounds];
	_mapView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
	_mapView.hidden = YES;
	_mapView.alpha = 0;
	[self.view addSubview:_mapView];
	[_mapView release];
}
#pragma mark - delegate start view
-(void)startViewLoadComplete:(StartView *)view
{
	_startView.alpha = 1;
	[UIView animateWithDuration:0.5 animations:^{
		_iconView.alpha = 0;
		
	}];
}
-(void)startViewFinish:(StartView *)view
{
	_mapView.hidden = NO;
	[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		view.alpha = 0;
		_mapView.alpha = 1;
	} completion:^(BOOL finished) {
		[_mapView firstShow];
	}];
}
-(void)startViewLastStepShowed:(StartView *)view
{
	[self prepareMaps];
}
#pragma mark -
-(void)dealloc
{
	[super dealloc];
}

@end
