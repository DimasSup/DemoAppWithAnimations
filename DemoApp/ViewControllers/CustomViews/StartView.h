//
//  StartView.h
//  DemoApp
//
//  Created by admin on 23.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StartView;

@protocol StartViewDelegate <NSObject>

-(void)startViewLoadComplete:(StartView*)view;
-(void)startViewFinish:(StartView*)view;
-(void)startViewLastStepShowed:(StartView*)view;
@end

@interface StartView : UIView
@property(nonatomic,assign)IBOutlet id<StartViewDelegate> delegate;
-(void)beginLoad;
@end
