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

@class EDSLayersViewController;
@class EDSPlacesViewController;
@class EDSFeaturesViewController;
@class EDSRouteViewController;

@interface EDSViewController : UIViewController

@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) AGSGraphicsLayer *routeLayer;

@property (nonatomic, strong) EDSLayersViewController *layersVC;
@property (nonatomic, strong) EDSPlacesViewController *placesVC;
@property (nonatomic, strong) EDSFeaturesViewController *featuresVC;
@property (nonatomic, strong) EDSRouteViewController *routeVC;

@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) IBOutlet UIButton *layersButton;
@property (nonatomic, strong) IBOutlet UIButton *placesButton;
@property (nonatomic, strong) IBOutlet UIButton *featuresButton;
@property (nonatomic, strong) IBOutlet UIButton *routeButton;

@property (nonatomic, strong) AGSRouteTask *routeTask;
@property (nonatomic, strong) AGSRouteTaskParameters *routeTaskParams;
@property (nonatomic, strong) AGSRouteResult *routeResult;

@property (nonatomic, strong) AGSFeatureLayer *fuelStationsFeatureLayer;
@property (nonatomic, strong) AGSFeatureLayer *coverageFeatureLayer;

@property (nonatomic, retain) AGSQuery *fuelStationQuery;
@property (nonatomic, retain) AGSFeatureSet *featureSet;
@property (nonatomic, strong) NSOperation* featureLayerQueryOperation;
@property (nonatomic, strong) NSOperation* fuelStationQueryOperartion;

@property (nonatomic, strong) LoadingView *placeLoadingView;
@property (nonatomic, strong) LoadingView *routeLoadingView;
@end
