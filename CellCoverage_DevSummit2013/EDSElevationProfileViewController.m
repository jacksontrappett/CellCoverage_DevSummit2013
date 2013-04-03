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

#import "EDSElevationProfileViewController.h"

@interface EDSElevationProfileViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL isDownloading;
@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;

- (void)startDownload;

@end

@implementation EDSElevationProfileViewController

-(void)dealloc {

    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
    self.isDownloading = NO;
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
    
    if (self.imageUrlString.length > 0) {

        //start loading process...
        [self startDownload];
    }
}

-(void)setImageUrlString:(NSString *)imageUrlString {
    
    _imageUrlString = imageUrlString;
    if (_imageUrlString.length > 0) {
        [self startDownload];
    }
}

//Kick of the download process
- (void)startDownload {
    
    //no need to download again if we are already in the process
    if (self.isDownloading)
        return;
    
    //If there is a source url string, start the download process.
    //
    //The image will load asynchronously, displaying an activity indicator while it's loading
    if (self.imageUrlString.length > 0)
    {
        self.activeDownload = [NSMutableData data];
        
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imageUrlString]];
        self.imageConnection = [NSURLConnection connectionWithRequest:req delegate:self];
        
        self.isDownloading = YES;
        self.activityIndicator.hidden = NO;
    }
}

#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //hide activity indicator
    self.activityIndicator.hidden = YES;

    //create image
    self.image = [[UIImage alloc] initWithData:self.activeDownload];
    self.imageView.image = self.image;
    
    // Release the connection now that it's finished and clean up
    self.imageConnection = nil;
    self.activeDownload = nil;
    self.isDownloading = NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //hide activity indicator
    self.activityIndicator.hidden = YES;
    
	self.image = nil;
	
	// Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
    
    self.isDownloading = NO;
}

@end
