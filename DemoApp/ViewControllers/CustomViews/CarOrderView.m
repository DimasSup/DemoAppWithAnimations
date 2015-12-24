//
//  CarOrderView.m
//  DemoApp
//
//  Created by admin on 24.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "CarOrderView.h"
#import "CarItemView.h"
#import "SelectCarTypeView.h"
@interface CarOrderView()
{
	NSMutableArray* _carItems;
	NSUInteger _currentItemIndex;
	CarItemView* _currentItemView;
}
@property (retain, nonatomic) IBOutlet UIView *reviewCarRoot;
@property (retain, nonatomic) IBOutlet UIView *carReviewVisible;
@property (retain, nonatomic) IBOutlet UIView *carReviewBackground;
@property (retain, nonatomic) IBOutlet UIView *carReviewContentView;

@property (retain, nonatomic) IBOutlet UIButton *btnSelectCar;
@property (retain, nonatomic) IBOutlet UIButton *btnRefresh;

@property (retain, nonatomic) IBOutlet UIView *bottomPanel;
@property (retain, nonatomic) IBOutlet UIView *bottomOrderView;

@end

@implementation CarOrderView

-(void)awakeFromNib
{
	[super awakeFromNib];
	_currentItemIndex = NSNotFound;
	_carItems = [NSMutableArray new];
	
	for (int i = 0; i<3; i++)
	{
		CarItemObject* obj = [CarItemObject new];
		obj.imageName = NSStringFormat(@"car%i",i+1);
		obj.carName = @"Random car, 2015";
		obj.driverName = NSStringFormat(@"Random Driver %i",i+1);
		obj.hourPrice = 8.0+i*2.15;
		obj.startPrice = 3.25+0.55*i;
		obj.oneKmPrice = 0.55+0.12*i;
		obj.seatsCount = 2+i;
		obj.currencySign = @"$";
		[_carItems addObject:obj];
		[obj release];
	}
	
	
	self.btnSelectCar.layer.cornerRadius = 16;
	self.carReviewVisible.layer.cornerRadius = self.carReviewBackground.layer.cornerRadius = self.bottomPanel.layer.cornerRadius = self.bottomOrderView.layer.cornerRadius = 5;
	
	
	self.carReviewVisible.layer.shadowOffset = CGSizeMake(0, 0);
	self.carReviewVisible.layer.shadowRadius = 3;
	self.carReviewVisible.layer.shadowColor = [UIColor colorWithWhite:0.000 alpha:0.500].CGColor;
	self.carReviewVisible.layer.shadowOpacity = 0.5;
	[self hideBottomPanel];
	
	UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
	gesture.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.carReviewContentView addGestureRecognizer:gesture];
	[gesture release];
	
	gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
	gesture.direction = UISwipeGestureRecognizerDirectionRight;
	[self.carReviewContentView addGestureRecognizer:gesture];
	[gesture release];
	[self showCarForIndex:0];
}

-(void)swipeRight
{
	if(_currentItemIndex>0)
	{
		NSUInteger newItemIndex =_currentItemIndex-1;
		[self showCarForIndex:newItemIndex];
	}
	
}

-(void)swipeLeft
{
	if(_currentItemIndex<_carItems.count-1)
	{
		NSUInteger newItemIndex = _currentItemIndex+1;
		[self showCarForIndex:newItemIndex];
	}
}

-(void)showCarForIndex:(NSUInteger)index
{
	if(index == _currentItemIndex)
	{
		return;
	}
	
	CarItemView* newItem = [self newItemView:_carItems[index]];
	int direction = index>_currentItemIndex?-1:1;
	_currentItemIndex = index;
	if(_currentItemIndex==NSNotFound)
	{
		_currentItemView = newItem;
		[self.carReviewContentView addSubview:newItem];
		[newItem release];
		return;
	}
	else
	{
		newItem.alpha = 0;
		CGRect oldResultFrame = _currentItemView.frame;
		oldResultFrame.origin.x = self.carReviewContentView.bounds.size.width * direction;
		
		
		CGRect newFrame = newItem.frame;
		newFrame.origin.x = self.carReviewContentView.bounds.size.width*(-1*direction);
		newItem.frame = newFrame;
		[self.carReviewContentView addSubview:newItem];
		newFrame.origin.x = 0;
		UIView* oldItem = _currentItemView;
		_currentItemView = newItem;
		[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
			oldItem.frame = oldResultFrame;
			oldItem.alpha = 0;
			newItem.frame = newFrame;
			newItem.alpha = 1;
		} completion:^(BOOL finished) {
			[oldItem removeFromSuperview];
			[oldItem release];
		}];
		
	}


	
}

-(CarItemView*)newItemView:(CarItemObject*)obj
{
	CarItemView* view = [[CarItemView alloc] initWithFrame:self.carReviewContentView.bounds];
	[view reinitializeWithObject:obj];
	return view;
}

- (IBAction)btnSelectCarClicked:(UIButton*)sender {
	UIWindow* wind = [[UIApplication sharedApplication].windows firstObject];
	__block SelectCarTypeView* view = [[SelectCarTypeView alloc] initWithFrame:wind.bounds];
	view.lastItemPoint = [sender.superview convertPoint:sender.frame.origin toView:wind];
	view.alpha = 0;
	[wind addSubview:view];
	
	[UIView animateWithDuration:0.5 animations:^{
		view.alpha = 1;
	} completion:^(BOOL finished) {
		[view release];
	}];
	

	
}


-(void)showBottomPanel
{
	self.bottomPanel.alpha = 1;
	CGRect r = self.bottomPanel.frame;
	r.origin.y = self.bounds.size.height - r.size.height+self.bottomPanel.layer.cornerRadius;
	self.bottomPanel.frame = r;
}

-(void)hideBottomPanel
{
	self.bottomPanel.alpha = 0;
	CGRect r = self.bottomPanel.frame;
	r.origin.y = self.bounds.size.height - r.size.height/2;
	self.bottomPanel.frame = r;
}

- (void)dealloc {
	[_reviewCarRoot release];
	[_carReviewVisible release];
	[_carReviewBackground release];
	[_carReviewContentView release];
	[_btnSelectCar release];
	[_btnRefresh release];
	[_bottomPanel release];
	[_bottomOrderView release];
	[_carItems release];
	[_currentItemView release];
	[super dealloc];
}
@end
