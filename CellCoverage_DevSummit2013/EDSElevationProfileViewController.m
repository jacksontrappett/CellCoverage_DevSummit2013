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
@property (nonatomic, strong) AGSRequestOperation *operation;

- (void)startDownload;

@end

@implementation EDSElevationProfileViewController

-(void)dealloc {

    [self.operation cancel];
    self.operation = nil;
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
    if (self.operation)
        return;
    
    //If there is a source url string, start the download process.
    //
    //The image will load asynchronously, displaying an activity indicator while it's loading
    if (self.imageUrlString.length > 0)
    {
        self.activityIndicator.hidden = NO;

        self.operation = [[AGSRequestOperation alloc] initWithURL:[NSURL URLWithString:self.imageUrlString]];
        self.operation.target = self;
        self.operation.action = @selector(imageRequestOperation:didComplete:);
        self.operation.errorAction = @selector(imageRequestOperation:didFailWithError:);
        [[AGSRequestOperation sharedOperationQueue] addOperation:self.operation];
    }
}

#pragma mark -
#pragma mark Download support (AGSOperation)

- (void)imageRequestOperation:(NSOperation*)op didComplete:(NSData *)data {
    self.activityIndicator.hidden = YES;
    
    //create image
    self.image = [[UIImage alloc] initWithData:data];
    if (!self.image) {
        NSLog(@"Elevation Profile image request succeeded, but no image :-(");
    }
    self.imageView.image = self.image;
    
    // Release the connection now that it's finished and clean up
    self.operation = nil;
}

- (void)imageRequestOperation:(NSOperation*)op didFailWithError:(NSError *)error {

    //hide activity indicator
    self.activityIndicator.hidden = YES;
	self.image = nil;
    self.operation = nil;
    
    NSLog(@"Elevation Profile image request failed because %@", error.localizedDescription);
}

@end
