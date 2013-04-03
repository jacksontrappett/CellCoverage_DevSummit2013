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

#import "EDSFeaturesViewController.h"

@interface EDSFeaturesViewController () <AGSPopupsContainerDelegate>

@end

@implementation EDSFeaturesViewController

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _popups = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPopups:(NSArray *)popups {
    
    _popups = [popups copy];
    
    //    self.navBar
    self.popupVC = [[AGSPopupsContainerViewController alloc] initWithPopups:self.popups usingNavigationControllerStack:NO];
    self.popupVC.style = AGSPopupsContainerStyleBlack;
    self.popupVC.delegate = self;
    self.clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearButtonPressed:)];
    self.popupVC.doneButton = self.clearButton;
    [self.popupVC.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [self.popupVC.view setFrame:self.view.bounds];
    [self.view addSubview:self.popupVC.view];
    [self.popupVC setPopups:popups];
    
    if (!self.sketchLayer) {
        self.sketchLayer = [[AGSSketchGraphicsLayer alloc] init];
        [self.mapView addMapLayer:self.sketchLayer withName:@"Sketch Layer"];
    }

    if (!self.sketchCompleteButton) {
        self.sketchCompleteButton = [[UIBarButtonItem alloc]initWithTitle:@"Sketch Done" style:UIBarButtonItemStylePlain target:self action:@selector(sketchComplete)];
    }
}

-(void)clearButtonPressed:(id)sender {
    self.popups = [NSArray array];
    [self.popupVC clearAllPopups];
}

-(void)setActiveFeatureLayer:(AGSFeatureLayer *)activeFeatureLayer {
    _activeFeatureLayer = activeFeatureLayer;
    _activeFeatureLayer.editingDelegate = self;
}

#pragma mark - AGSPopupsContainerDelegate

-(void)popupsContainer:(id<AGSPopupsContainer>)popupsContainer didChangeToCurrentPopup:(AGSPopup*)popup {
    
    if (popup && [self.popups count] > 0) {
        AGSPoint *point = popup.graphic.geometry.envelope.center;
        [self.mapView centerAtPoint:point animated:YES];
        
        //show the callout]
        [self.mapView.callout showCalloutAtPoint:point forGraphic:popup.graphic animated:YES];
    } else {
        [self.mapView.callout setHidden:YES];
    }
}
@end
