//
//  MapNavigationBar.m
//  DemoApp
//
//  Created by admin on 23.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "MapNavigationBar.h"

@interface MapNavigationBar()
@property (retain, nonatomic) IBOutlet UIButton *iconButton;


@end

@implementation MapNavigationBar

-(void)awakeFromNib
{
	[super awakeFromNib];
	[_iconButton setImage:[[_iconButton imageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
	_iconButton.imageView.tintColor = [UIColor colorWithWhite:0.220 alpha:1.000];
}

- (void)dealloc {
	[_iconButton release];
	[super dealloc];
}
@end
