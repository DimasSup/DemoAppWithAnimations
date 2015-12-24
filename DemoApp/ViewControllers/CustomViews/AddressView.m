//
//  AddressView.m
//  DemoApp
//
//  Created by admin on 24.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "AddressView.h"
#import "UIView+Highlight.h"

@interface AddressView()
@property (retain, nonatomic) IBOutlet UIView *fromAddressLine;
@property (retain, nonatomic) IBOutlet UIView *fromAddressSubView;
@property (retain, nonatomic) IBOutlet UIView *destinationAddressLine;
@property (retain, nonatomic) IBOutlet UIView *destinationAddressSubLine;

@property (retain, nonatomic) IBOutlet UIImageView *fromPointImage;
@property (retain, nonatomic) IBOutlet UIImageView *destinationPointImage;

@property (retain, nonatomic) IBOutlet UIButton *btnFromConfirm;
@property (retain, nonatomic) IBOutlet UIButton *btnDestinationConfirm;


@property (retain, nonatomic) IBOutlet UIView *connectionLine;

@property(nonatomic,assign)BOOL isShowedDestination;
@end

@implementation AddressView

-(void)awakeFromNib
{
	[super awakeFromNib];
	self.fromAddressLine.layer.borderWidth = self.destinationAddressLine.layer.borderWidth = 1;
	self.fromAddressLine.layer.borderColor = self.destinationAddressLine.layer.borderColor = [UIColor colorWithWhite:0.894 alpha:1.000].CGColor;
	self.fromAddressSubView.layer.cornerRadius = self.destinationAddressSubLine.layer.cornerRadius =self.fromAddressLine.layer.cornerRadius = self.destinationAddressLine.layer.cornerRadius = 5;
	
	self.fromAddressLine.layer.shadowOffset = self.destinationAddressLine.layer.shadowOffset = CGSizeMake(2, 2);
	self.fromAddressLine.layer.shadowRadius = self.destinationAddressLine.layer.shadowRadius = 2;
	self.fromAddressLine.layer.shadowColor = self.destinationAddressLine.layer.shadowColor = [UIColor colorWithWhite:0.000 alpha:0.100].CGColor;
	self.fromAddressLine.layer.shadowOpacity = self.destinationAddressLine.layer.shadowOpacity = 0.5;
	
	
	self.connectionLine.layer.cornerRadius = 1;
	
	[self setShowDestinationLine:NO animated:NO];
}
#pragma mark - actions
- (IBAction)btnFromConfirmClicked:(id)sender
{
	if(self.txtFromText.text.length == 0)
	{
		[self.txtFromText highlightMe:[UIColor colorWithRed:1.000 green:0.420 blue:0.299 alpha:1.000]];
		return;
	}
	[self setShowDestinationLine:YES animated:YES];
	if(self.delegate && [self.delegate respondsToSelector:@selector(addressViewFromClicked:)])
	{
		[self.delegate addressViewFromClicked:self];
	}
}
- (IBAction)btnDestinationClicked:(id)sender
{
	if(self.txtDestinationText.text.length == 0)
	{
		[self.txtDestinationText highlightMe:[UIColor colorWithRed:1.000 green:0.420 blue:0.299 alpha:1.000]];
		return;
	}
	self.destinationPointImage.image = [UIImage imageNamed:@"check_icon"];
	
	[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_btnDestinationConfirm.alpha = 0;
		
	} completion:^(BOOL finished) {
		_btnDestinationConfirm.hidden = YES;
	}];
	
	if(self.delegate && [self.delegate respondsToSelector:@selector(addressViewDestinationClicked:)])
	{
		[self.delegate addressViewDestinationClicked:self];
	}
}
#pragma mark -
-(void)setShowDestinationLine:(BOOL)show animated:(BOOL)animated
{
	self.fromPointImage.image = show?[UIImage imageNamed:@"check_icon"]:[UIImage imageNamed:@"small_point"];
	if(animated)
	{
		float alpha = show?0:1;
		
		[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			_btnFromConfirm.alpha = alpha;
			
		} completion:^(BOOL finished) {
			_btnFromConfirm.hidden = show;
			float alpha = show?1:0;
			[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				_destinationAddressLine.alpha = alpha;
				_connectionLine.alpha = alpha;
			} completion:^(BOOL finished) {
				
			}];
		}];
	}
	else
	{
		float alpha = show?1:0;
		
		_btnFromConfirm.alpha = 1- alpha;
		_btnFromConfirm.hidden = show;
		
		_destinationAddressLine.alpha = alpha;
		_connectionLine.alpha = alpha;
	}
	
	self.isShowedDestination = show;
}

#pragma mark -

- (void)dealloc {
	[_fromAddressLine release];
	[_destinationAddressLine release];
	[_connectionLine release];
	[_fromPointImage release];
	[_destinationPointImage release];
	[_btnFromConfirm release];
	[_fromAddressSubView release];
	[_destinationAddressSubLine release];
	[_btnDestinationConfirm release];
	[_txtFromText release];
	[_txtDestinationText release];
	[super dealloc];
}
@end
