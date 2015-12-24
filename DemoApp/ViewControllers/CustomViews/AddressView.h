//
//  AddressView.h
//  DemoApp
//
//  Created by admin on 24.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "UIViewFromNib.h"

@class AddressView;

@protocol AddressViewDelegate <NSObject>
-(void)addressViewFromClicked:(AddressView*)view;
-(void)addressViewDestinationClicked:(AddressView*)view;

@end

@interface AddressView : UIViewFromNib
@property(nonatomic,assign)id<AddressViewDelegate> delegate;
@property(nonatomic,readonly)BOOL isShowedDestination;

@property (retain, nonatomic) IBOutlet UITextField *txtFromText;
@property (retain, nonatomic) IBOutlet UITextField *txtDestinationText;

-(void)setShowDestinationLine:(BOOL)show animated:(BOOL)animated;


@end
