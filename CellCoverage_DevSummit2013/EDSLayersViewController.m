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

#import "EDSLayersViewController.h"

@interface EDSLayersViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation EDSLayersViewController

-(void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(commandDidChange:) name:@"EDSCommandChangedNotification" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commandDidChange:(id)sender {
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //show all layers in map except for the top layer (the labels)
    return [self.mapView.mapLayers count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    //display layers top to bottom, so invert layer index (remove top layer)
    NSInteger layerIndex = (self.mapView.mapLayers.count - 1) - indexPath.row;
    
    if (layerIndex == 0) {
        cell.textLabel.textColor = [AGSColor grayColor];
    }
    else {
        cell.textLabel.textColor = [AGSColor blackColor];
    }
    
    // Set up the cell...
    AGSLayer *layer = [self.mapView.mapLayers objectAtIndex:layerIndex];
    cell.accessoryType = layer.visible ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    NSString *title = layer.name;
    if (layerIndex == 0) {
        title = @"Basemap";
    }
    else if ([title rangeOfString:@"World_Light_Gray_Reference"].location != NSNotFound) {
        title = @"Labels";
    }
    cell.textLabel.text = title;
    
    if ([layer isKindOfClass:[AGSGraphicsLayer class]]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%u Features", ((AGSGraphicsLayer *)layer).graphicsCount];
    }
    else {
        cell.detailTextLabel.text = nil;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //don't allow selection last row (remember we're not showing top layer
    if (indexPath.row < self.mapView.mapLayers.count - 1) {
        //layers are displayed top to bottom, so invert layer index
        NSInteger layerIndex = (self.mapView.mapLayers.count - 1) - indexPath.row;
        
        AGSLayer *layer = [self.mapView.mapLayers objectAtIndex:layerIndex];
        layer.visible = !layer.visible;
        [self.tableView reloadData];
    }
}

@end
