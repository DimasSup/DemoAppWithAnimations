//
//  MainMapView.m
//  DemoApp
//
//  Created by admin on 23.12.15.
//  Copyright © 2015 DimasSup. All rights reserved.
//

#import "MainMapView.h"
#import <MapKit/MapKit.h>
#import "MapNavigationBar.h"
#import "AddressView.h"
#import "CarOrderView.h"

@interface MainMapView()<MKMapViewDelegate,AddressViewDelegate>
{
	MapNavigationBar* _mapNavigationBar;
	AddressView* _addressView;
	CarOrderView* _carOrderView;
	CLGeocoder* _geocoder;
	BOOL _isShowed;
}
@property (retain, nonatomic) IBOutlet MKMapView *mapKitView;
@property (retain, nonatomic) IBOutlet UIImageView *centerPoint;

@end

@implementation MainMapView

-(void)awakeFromNib
{
	[super awakeFromNib];
	
	
	_geocoder = [[CLGeocoder alloc] init];

	
	_mapNavigationBar = [[MapNavigationBar alloc] initWithFrame:CGRectZero];
	_mapNavigationBar.alpha = 0;
	CGRect r = _mapNavigationBar.frame;
	r.origin.y = -_mapNavigationBar.frame.size.height/2;
	_mapNavigationBar.frame = r;
	[self addSubview:_mapNavigationBar];
	[_mapNavigationBar release];
	
	_addressView = [[AddressView alloc] initWithFrame:CGRectZero];
	_addressView.delegate = self;
	r = _addressView.frame;
	r = [self startPositionForAddressLine];
	_addressView.alpha = 0;
	_addressView.hidden = YES;
	_addressView.frame = r;
	[self addSubview:_addressView];
	[_addressView release];
	
	_carOrderView = [[CarOrderView alloc] initWithFrame:CGRectZero];
	_carOrderView.hidden = YES;
	_carOrderView.alpha = 0;
	r = _carOrderView.frame;
	r.origin.y = self.bounds.size.height;
	_carOrderView.frame = r;
	[self addSubview:_carOrderView];
	[_carOrderView release];

}

#pragma mark -

-(void)firstShow
{
	if(_isShowed)
	{
		return;
	}
	_isShowed = YES;
	[self setShowStateNavigationBar:YES animated:YES];
	[self setShowAddressesLine:YES animated:YES];
	
	self.centerPoint.alpha = 0;
	CGRect centerPointFrame = self.centerPoint.frame;
	centerPointFrame.origin.y = self.bounds.size.height/2+centerPointFrame.size.height/2;
	self.centerPoint.frame = centerPointFrame;
	centerPointFrame.origin.y = self.bounds.size.height/2-centerPointFrame.size.height/2;
	self.centerPoint.hidden = NO;
	[UIView animateWithDuration:0.5 animations:^{
		self.centerPoint.frame = centerPointFrame;
		self.centerPoint.alpha = 1;
	}];
}
-(void)setShowCarOrderView:(BOOL)show animated:(BOOL)animated
{
	CGRect endRect = _carOrderView.frame;
	float alpha = 0;
	if(!show)
	{
		endRect.origin.y = self.bounds.size.height;
	}
	else
	{
		endRect.origin.y = self.bounds.size.height - endRect.size.height;
		alpha = 1;
	}
	if(show)
	{
		_carOrderView.hidden = NO;
	}
	
	if(animated)
	{
		
		
		[UIView animateWithDuration:0.3 delay:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
			if(show)
			{
				[_carOrderView showBottomPanel];
			}
			else
			{
				[_carOrderView hideBottomPanel];
			}
			
		} completion:^(BOOL finished) {
			
		}];
		
		[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			_carOrderView.frame = endRect;
			_carOrderView.alpha = alpha;
			
			
		} completion:^(BOOL finished) {
			if(!show)
			{
				_carOrderView.hidden = YES;
			}
			
		}];
	}
	else
	{
		_carOrderView.frame = endRect;
		_carOrderView.alpha = alpha;
		if(show)
		{
			[_carOrderView showBottomPanel];
		}
		else
		{
			[_carOrderView hideBottomPanel];
		}
		if(!show)
		{
			_carOrderView.hidden = YES;
		}
		
	}
	
}
-(void)setShowStateNavigationBar:(BOOL)show animated:(BOOL)animated
{
	CGRect endRect = _mapNavigationBar.frame;
	float alpha = 0;
	if(!show)
	{
		endRect.origin.y = -endRect.size.height/2;
	}
	else
	{
		endRect.origin.y = 0;
		alpha = 1;
	}
	if(show)
	{
		_mapNavigationBar.hidden = NO;
	}
	
	if(animated)
	{
		[UIView animateWithDuration:0.5 animations:^{
			_mapNavigationBar.frame = endRect;
			_mapNavigationBar.alpha = alpha;
			
		} completion:^(BOOL finished) {
			if(!show)
			{
				_mapNavigationBar.hidden = YES;
			}

		}];
	}
	else
	{
		_mapNavigationBar.frame = endRect;
		_mapNavigationBar.alpha = alpha;
		if(!show)
		{
			_mapNavigationBar.hidden = YES;
		}

	}
	
}

-(void)setShowAddressesLine:(BOOL)show animated:(BOOL)animated
{
	CGRect endRect;
	float alpha = 0;
	if(!show)
	{
		endRect = [self startPositionForAddressLine];
	}
	else
	{
		endRect = [self endPositionForAddressLine];
		alpha = 1;
	}
	if(show)
	{
		_addressView.hidden = NO;
	}
		
	if(animated)
	{

		[UIView animateWithDuration:0.5 animations:^{
			_addressView.frame = endRect;
			_addressView.alpha = alpha;
		} completion:^(BOOL finished) {
			if(!show)
			{
				_addressView.hidden = YES;
			}
		}];
	}
	else
	{
		_addressView.frame = endRect;
		_addressView.alpha = alpha;
		if(!show)
		{
			_addressView.hidden = YES;
		}
	}
	
}
#pragma mark - 
-(void)addressViewFromClicked:(AddressView *)view
{
	CGRect rect = view.frame;
	rect.size.height = 95;
	rect.origin.y = self.bounds.size.height/2 - rect.size.height - 50;
	rect.origin.x = self.bounds.size.width/2 - rect.size.width/2;
	[UIView animateWithDuration:0.5 animations:^{
		view.frame = rect;
	} completion:^(BOOL finished) {
		
	}];
}

#pragma mark - 
-(void)layoutSubviews
{
	[super layoutSubviews];
	CGRect rect = _addressView.frame;
	rect.origin.y = self.bounds.size.height/2 - rect.size.height - 50;
	rect.origin.x = self.bounds.size.width/2 - rect.size.width/2;
	_addressView.frame = rect;
}
-(CGRect)startPositionForAddressLine
{
	CGRect rect = _addressView.frame;
	rect.origin.y = self.bounds.size.height/2 - rect.size.height - 80;
	rect.origin.x = self.bounds.size.width/2 - rect.size.width/2;
	return rect;
}
-(CGRect)endPositionForAddressLine
{
	CGRect rect = _addressView.frame;
	rect.origin.y = self.bounds.size.height/2 - rect.size.height - 50;
	rect.origin.x = self.bounds.size.width/2 - rect.size.width/2;
	return rect;
}
#pragma mark - delegate address view
-(void)addressViewDestinationClicked:(AddressView *)view
{
	[self setShowCarOrderView:YES animated:YES];
}
#pragma mark -
-(void)showUI
{
	if(!_isShowed)
		return;
	[self setShowStateNavigationBar:YES animated:YES];
	[self setShowAddressesLine:YES animated:YES];
	
}
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showUI) object:nil];
	[self setShowStateNavigationBar:NO animated:YES];
	[self setShowAddressesLine:NO animated:YES];
	
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	[self performSelector:@selector(showUI) withObject:nil afterDelay:1];
	
	CLLocationCoordinate2D coo = [_mapKitView convertPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) toCoordinateFromView:self];
	CLLocation* l = [[CLLocation alloc] initWithLatitude:coo.latitude longitude:coo.longitude];
	[_geocoder reverseGeocodeLocation:l completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
		CLPlacemark* mark = [placemarks firstObject];
		NSString* val = @"";
		if(mark.thoroughfare.length)
		{
			val = NSStringFormat(@"%@ %@",mark.thoroughfare.length?mark.thoroughfare:@"",mark.subThoroughfare.length?mark.subThoroughfare:@"");
		}
		else if(mark.locality.length)
		{
			val = NSStringFormat(@"%@ %@",mark.locality.length?mark.locality:@"",mark.subLocality.length?mark.subLocality:@"");
		}
		else if(mark.country.length)
		{
			val =mark.country;

		}
		val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if(_addressView.isShowedDestination)
		{
			_addressView.txtDestinationText.text = val;
		}
		else
		{
			_addressView.txtFromText.text = val;
		}
		
	}];
	[l release];
}

#pragma mark -


- (void)dealloc {
	
	[_geocoder release];
	[_mapKitView release];
	[_centerPoint release];
	[super dealloc];
}
@end
