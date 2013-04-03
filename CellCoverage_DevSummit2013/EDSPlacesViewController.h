// Copyright 2013 ESRI
//
// All rights reserved under the copyright laws of the United States
// and applicable international laws, treaties, and conventions.
//
// You may freely redistribute and use this sample code, with or
// without modification, provided you include the original copyright
// notice and use restrictions.
//
// See the use restrictions at http://help.arcgis.com/en/sdk/10.0/usageRestrictions.htm
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "LoadingView.h"

@interface EDSPlacesViewController : UIViewController

@property (nonatomic, strong) AGSMapView *mapView;

@property (nonatomic, weak) id routeDelegate;
@property (nonatomic, assign) SEL routeAction;
@property (nonatomic, strong) AGSGraphicsLayer *placesLayer;
@property (nonatomic, strong) LoadingView *loadingView;

@end
