//
//  StartItemView.m
//  DemoApp
//
//  Created by admin on 22.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "StartItemView.h"

@implementation StartItemView
@synthesize showNext = _showNext;
@synthesize showPrevious = _showPrevious;
-(void)awakeFromNib
{
	[super awakeFromNib];
	self.clipsToBounds = NO;
	self.backgroundColor = [UIColor clearColor];
	self.layer.shadowColor = [UIColor colorWithWhite:0.000 alpha:0.500].CGColor;
	self.layer.shadowOffset = CGSizeMake(1, 2);
	self.layer.shadowRadius = 5;
	self.layer.shadowOpacity= 0.5;
	self.imageView.clipsToBounds = YES;
	self.layer.cornerRadius = self.imageView.layer.cornerRadius = 6;

}
-(void)setShowPrevious:(BOOL)showPrevious
{
	_showPrevious = showPrevious;
	_btnPrevious.hidden = !showPrevious;
}
-(void)setShowNext:(BOOL)showNext
{
	_showNext = showNext;
	_btnNext.hidden = !showNext;
}

#pragma mark - actions
- (IBAction)btnNextClicked:(id)sender
{
	if(self.delegate && [self.delegate respondsToSelector:@selector(startItemViewNextClicked:)])
	{
		[self.delegate startItemViewNextClicked:self];
	}
}


- (IBAction)btnPreviousClicked:(id)sender {
	if(self.delegate && [self.delegate respondsToSelector:@selector(startItemViewPreviousClicked:)])
	{
		[self.delegate startItemViewPreviousClicked:self];
	}
}

#pragma mark -

- (void)dealloc {
    [_imageView release];
    [_detailsText release];
    [_orderText release];
	[_btnNext release];
	[_btnPrevious release];
    [super dealloc];
}

@end
