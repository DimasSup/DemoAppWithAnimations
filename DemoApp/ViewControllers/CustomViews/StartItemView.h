//
//  StartItemView.h
//  DemoApp
//
//  Created by admin on 22.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "UIViewFromNib.h"
@class StartItemView;
@protocol StartItemViewDelegate <NSObject>

-(void)startItemViewPreviousClicked:(StartItemView*)item;
-(void)startItemViewNextClicked:(StartItemView*)item;

@end

@interface StartItemView : UIViewFromNib
@property (nonatomic,assign) id<StartItemViewDelegate> delegate;
@property (nonatomic,assign)BOOL showPrevious;
@property (nonatomic,assign)BOOL showNext;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *detailsText;
@property (retain, nonatomic) IBOutlet UILabel *orderText;
@property (retain, nonatomic) IBOutlet UIButton *btnNext;
@property (retain, nonatomic) IBOutlet UIButton *btnPrevious;
- (IBAction)btnNextClicked:(id)sender;
- (IBAction)btnPreviousClicked:(id)sender;

@end
