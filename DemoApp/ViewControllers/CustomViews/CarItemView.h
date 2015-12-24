//
//  CarItemView.h
//  DemoApp
//
//  Created by admin on 24.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "UIViewFromNib.h"

@interface CarItemObject : NSObject
@property(nonatomic,retain)NSString* imageName;
@property(nonatomic,retain)NSString* currencySign;
@property(nonatomic)float startPrice;
@property(nonatomic)float oneKmPrice;
@property(nonatomic)float hourPrice;
@property(nonatomic,retain)NSString* carName;
@property(nonatomic)int seatsCount;
@property(nonatomic,retain)NSString* driverName;
@end

@interface CarItemView : UIViewFromNib
@property(nonatomic,readonly)CarItemObject* carObject;
-(void)reinitializeWithObject:(CarItemObject*)carObject;
@end
