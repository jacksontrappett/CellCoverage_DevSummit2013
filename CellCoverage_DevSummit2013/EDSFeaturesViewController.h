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

@interface EDSFeaturesViewController : UIViewController <AGSFeatureLayerEditingDelegate>

@property (nonatomic, copy) NSArray *popups;
@property (nonatomic, strong) AGSFeatureLayer *activeFeatureLayer;
@property (nonatomic, strong) AGSMapView *mapView;
@property (nonatomic, strong) AGSPopupsContainerViewController *popupVC;

@property (nonatomic, strong) LoadingView* loadingView;
@property (nonatomic, strong) AGSSketchGraphicsLayer* sketchLayer;
@property (nonatomic, strong) UIAlertView* alertView;
@property (nonatomic, strong) UIBarButtonItem* sketchCompleteButton;
@property (nonatomic, strong) UIBarButtonItem* clearButton;

@property (nonatomic, strong) id previousMapTouchDelegate;
@property (nonatomic, strong) AGSGraphic *createdFeature;

@end
