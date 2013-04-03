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

#import "EDSRouteViewController.h"
#import "EDSRouteViewController+Elevation.h"
#import "EDSElevationProfileViewController.h"

//
// Notes on the Elevation Server Object Extension, which was produced
// by Esri's Applications Prototype Lab, can be found here:
//
// http://blogs.esri.com/esri/apl/2010/10/07/elevation-server-object-extension/
//
#define kElevationProfileRest @"http://sampleserver4.arcgisonline.com/ArcGIS/rest/services/Elevation/ESRI_Elevation_World/MapServer/exts/ElevationsSOE/ElevationLayers/1"

@implementation EDSRouteViewController (Elevation)

- (void)displayElevationProfile:(AGSGraphic *)graphic  fromRect:(CGRect)fromRect inView:(UIView *)presentingView {

    self.fromRect = fromRect;
    self.presentingView = presentingView;
    
    //
    //create our parameter dictionary and add required parameters
    //
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"json", @"f", nil];
    [queryParams setValue:[graphic.geometry encodeToJSON] forKey:@"InputPolyline"];
    [queryParams setValue:[NSNumber numberWithLong:600] forKey:@"ImageWidth"];
    [queryParams setValue:[NSNumber numberWithLong:250] forKey:@"ImageHeight"];
    [queryParams setValue:[NSNumber numberWithBool:YES] forKey:@"DisplaySegments"];
    [queryParams setValue:@"0xFFFFFF" forKey:@"BackgroundColorHex"];

    //
    // create json request
    //
    AGSJSONRequestOperation *jrop = [[AGSJSONRequestOperation alloc] initWithURL:[NSURL URLWithString:kElevationProfileRest]
                                                                        resource:@"GetElevationProfile"
                                                                 queryParameters:queryParams];
    jrop.target = self;
    jrop.action = @selector(loadOperation:didDecode:);
    jrop.errorAction = @selector(loadOperation:didFailWithError:);
    [[AGSRequestOperation sharedOperationQueue] addOperation:jrop];
}

- (void)loadOperation:(NSOperation*)op didDecode:(NSDictionary *)json {

    //This is the format of the result json...
    /*
    {
        length2D = "535492.70821820386";
        length3D = "535567.86350523354";
        processTime = "0.969";
        profileImageUrl = "http://sampleserver4.arcgisonline.com/arcgisoutput/_ags_profile_d003da11-1e75-4f53-8916-4d78154b1e4f.png";
    }
    */
    
    //
    //create the elevation profile view controller and display the image
    //
    EDSElevationProfileViewController *profileVC = [[EDSElevationProfileViewController alloc] initWithNibName:@"EDSElevationProfileViewController" bundle:nil];
    profileVC.imageUrlString = [json objectForKey:@"profileImageUrl"];
    self.profilePopoverController = [[UIPopoverController alloc] initWithContentViewController:profileVC];
    [self.profilePopoverController setPopoverContentSize:CGSizeMake(600.0, 250.0)];
    [self.profilePopoverController presentPopoverFromRect:self.fromRect inView:self.presentingView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (void)loadOperation:(NSOperation*)op didFailWithError:(NSError *)error {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Elevation Profile Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
