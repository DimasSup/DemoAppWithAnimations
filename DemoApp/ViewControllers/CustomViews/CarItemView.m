//
//  CarItemView.m
//  DemoApp
//
//  Created by admin on 24.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "CarItemView.h"

@implementation CarItemObject

@end


@interface CarItemView()
@property (retain, nonatomic) IBOutlet UIImageView *carImage;
@property (retain, nonatomic) IBOutlet UILabel *lblStartPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblPricePerKm;
@property (retain, nonatomic) IBOutlet UILabel *lblPricePerHour;
@property (retain, nonatomic) IBOutlet UILabel *lblCarName;
@property (retain, nonatomic) IBOutlet UILabel *lblSeats;
@property (retain, nonatomic) IBOutlet UILabel *lblDriverName;


@end

@implementation CarItemView

-(void)awakeFromNib
{
	[super awakeFromNib];
	self.carImage.clipsToBounds = YES;
	self.carImage.layer.cornerRadius = self.carImage.frame.size.height/2;
}

-(void)reinitializeWithObject:(CarItemObject *)carObject
{
	if(carObject!=_carObject)
	{
		[_carObject release];
		_carObject = [carObject retain];
	}
	self.carImage.image = [UIImage imageNamed:carObject.imageName];
	self.lblDriverName.text = carObject.driverName;
	self.lblCarName.text = carObject.carName;

	
	NSMutableAttributedString* attString = [NSMutableAttributedString new];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSStringFormat(@"%.2f%@",carObject.startPrice,carObject.currencySign) attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Medium" size:16],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.220 alpha:1.000]}] autorelease]];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSLocalizedString(@" Start", @" Start") attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:16],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.294 alpha:1.000]}] autorelease]];
	self.lblStartPrice.attributedText = attString;
	[attString release];
	
	attString = [NSMutableAttributedString new];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSStringFormat(@"%.2f%@",carObject.oneKmPrice,carObject.currencySign) attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:16],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.220 alpha:1.000]}] autorelease]];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSLocalizedString(@" /km", @" /km") attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:16],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.294 alpha:1.000]}] autorelease]];
	self.lblPricePerKm.attributedText = attString;
	[attString release];
	
	attString = [NSMutableAttributedString new];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSStringFormat(@"%.2f%@",carObject.hourPrice,carObject.currencySign) attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:12],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.298 alpha:1.000]}] autorelease]];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSLocalizedString(@" /h", @" /h") attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:12],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.298 alpha:1.000]}] autorelease]];
	self.lblPricePerHour.attributedText = attString;
	[attString release];
	
	attString = [NSMutableAttributedString new];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSStringFormat(@"%i",carObject.seatsCount) attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Medium" size:12],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.510 alpha:1.000]}] autorelease]];
	[attString appendAttributedString:[[[NSAttributedString alloc] initWithString:NSLocalizedString(@" seats", @" seats") attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:12],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.510 alpha:1.000]}] autorelease]];
	self.lblSeats.attributedText = attString;
	[attString release];
	

	
	

}

-(void)dealloc
{
	[_carObject release];
	[_carImage release];

	[_lblStartPrice release];
	[_lblPricePerKm release];
	[_lblPricePerHour release];
	[_lblCarName release];
	[_lblSeats release];
	[_lblDriverName release];
	[super dealloc];
}
@end
