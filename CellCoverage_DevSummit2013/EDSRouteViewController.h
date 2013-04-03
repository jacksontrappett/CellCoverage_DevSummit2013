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
#import "ActivityAlertView.h"

@interface EDSRouteViewController : UIViewController

@property (nonatomic, strong) NSArray *directionGraphics;
@property (nonatomic, strong) AGSMapView *mapView;

@property (nonatomic, strong) ActivityAlertView *activityAlertView;
@property (nonatomic, assign) CGRect fromRect;
@property (nonatomic, strong) UIView *presentingView;
@property (nonatomic, strong) UIPopoverController *profilePopoverController;

@end

typedef enum {
    edsNoSignal = 0,
    edsWeakSignal = 1,
    edsStrongSignal = 2
} EDSSignalStrength;