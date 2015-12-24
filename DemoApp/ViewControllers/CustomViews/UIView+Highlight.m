//
//  UIView+Highlight.m
//  EconomistOwner
//
//  Created by admin on 20.07.15.
//  Copyright (c) 2015 DimasSup. All rights reserved.
//

#import "UIView+Highlight.h"

@implementation UIView (Highlight)
-(void)highlightMe:(UIColor *)toColor
{
	UIColor* sourceColor = [self.backgroundColor retain];
	[UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction animations:^{
		[UIView setAnimationRepeatCount:3];
		self.backgroundColor = toColor;
	} completion:^(BOOL finished) {
		self.backgroundColor =sourceColor;
		[sourceColor release];
	}];
}
@end
