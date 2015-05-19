//
//  OverlayViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "OverlayViewController.h"

enum{
    OverlayViewControllerOverlayTypeCommonPolyline = 0,
    OverlayViewControllerOverlayTypePolygon,
    OverlayViewControllerOverlayTypeTexturePolyline,
    OverlayViewControllerOverlayTypeArrowPolyline
};

@interface OverlayViewController ()

@property (nonatomic, strong) NSMutableArray *overlaysAboveRoads;

@property (nonatomic, strong) NSMutableArray *overlaysAboveLabels;

@end

@implementation OverlayViewController
@synthesize overlaysAboveRoads  = _overlaysAboveRoads;
@synthesize overlaysAboveLabels = _overlaysAboveLabels;

#pragma mark - MAMapViewDelegate

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        
        circleView.lineWidth    = 5.f;
        circleView.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleView.fillColor    = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
        circleView.lineDash     = YES;
        
        return circleView;
    }
    else if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonView *polygonView = [[MAPolygonView alloc] initWithPolygon:overlay];
        polygonView.lineWidth    = 5.f;
        polygonView.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        polygonView.fillColor    = [UIColor colorWithRed:0.77 green:0.88 blue:0.94 alpha:0.8];
        polygonView.lineJoinType = kMALineJoinMiter;
        
        return polygonView;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];

        if (overlay == self.overlaysAboveLabels[OverlayViewControllerOverlayTypeTexturePolyline])
        {
            polylineView.lineWidth    = 8.f;
            [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"arrowTexture"]];
            
        }
        else if(overlay == self.overlaysAboveLabels[OverlayViewControllerOverlayTypeArrowPolyline])
        {
            polylineView.lineWidth    = 20.f;
            polylineView.lineCapType  = kMALineCapArrow;
        }
        else
        {
            polylineView.lineWidth    = 8.f;
            polylineView.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
            polylineView.lineJoinType = kMALineJoinRound;
            polylineView.lineCapType  = kMALineCapRound;
        }
        
        return polylineView;
    }
    
    return nil;
}

#pragma mark - Initialization

- (void)initOverlays
{
    self.overlaysAboveLabels = [NSMutableArray array];
    self.overlaysAboveRoads = [NSMutableArray array];
    
    /* Circle. */
    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.952136, 116.50095) radius:5000];
    [self.overlaysAboveRoads addObject:circle];
    
    /* Polyline. */
    CLLocationCoordinate2D commonPolylineCoords[5];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    commonPolylineCoords[4].latitude = 39.932136;
    commonPolylineCoords[4].longitude = 116.44095;
    
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:5];
    [self.overlaysAboveLabels insertObject:commonPolyline atIndex:OverlayViewControllerOverlayTypeCommonPolyline];

    /* Polygon. */
    CLLocationCoordinate2D coordinates[4];
    coordinates[0].latitude = 39.810892;
    coordinates[0].longitude = 116.233413;
    
    coordinates[1].latitude = 39.816600;
    coordinates[1].longitude = 116.331842;
    
    coordinates[2].latitude = 39.762187;
    coordinates[2].longitude = 116.357932;
    
    coordinates[3].latitude = 39.733653;
    coordinates[3].longitude = 116.278255;
    
    MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:4];
    [self.overlaysAboveLabels insertObject:polygon atIndex:OverlayViewControllerOverlayTypePolygon];
    
    /* Textured Polyline. */
    CLLocationCoordinate2D texPolylineCoords[3];
    texPolylineCoords[0].latitude = 39.932136;
    texPolylineCoords[0].longitude = 116.44095;
    
    texPolylineCoords[1].latitude = 39.932136;
    texPolylineCoords[1].longitude = 116.50095;
    
    texPolylineCoords[2].latitude = 39.952136;
    texPolylineCoords[2].longitude = 116.50095;
    
    MAPolyline *texPolyline = [MAPolyline polylineWithCoordinates:texPolylineCoords count:3];
    [self.overlaysAboveLabels insertObject:texPolyline atIndex:OverlayViewControllerOverlayTypeTexturePolyline];
    
    /* Arrow Polyline. */
    CLLocationCoordinate2D ArrowPolylineCoords[3];
    ArrowPolylineCoords[0].latitude = 39.793765;
    ArrowPolylineCoords[0].longitude = 116.294653;
    
    ArrowPolylineCoords[1].latitude = 39.831741;
    ArrowPolylineCoords[1].longitude = 116.294653;
    
    ArrowPolylineCoords[2].latitude = 39.832136;
    ArrowPolylineCoords[2].longitude = 116.34095;
    
    MAPolyline *arrowPolyline = [MAPolyline polylineWithCoordinates:ArrowPolylineCoords count:3];
    [self.overlaysAboveLabels insertObject:arrowPolyline atIndex:OverlayViewControllerOverlayTypeArrowPolyline];

    
}

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initOverlays];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapView addOverlays:self.overlaysAboveLabels];
    [self.mapView addOverlays:self.overlaysAboveRoads level:MAOverlayLevelAboveRoads];
}

@end
