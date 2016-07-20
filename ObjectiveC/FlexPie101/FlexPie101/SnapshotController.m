//
//  SnapshotController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SnapshotController.h"
@import XuniFlexPieDynamicKit;
#import "PieChartData.h"

@interface SnapshotController ()
@property (weak, nonatomic) IBOutlet FlexPie *flexPie;

@end

@implementation SnapshotController
- (IBAction)doTakeSnapshot:(id)sender {
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageWithData:[self.flexPie getImage]];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotoAlbum:finishedSavingWithError:contextInfo:), nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
   
    NSMutableArray *pieData = [PieChartData demoData];
    self.flexPie.binding = @"value";
    self.flexPie.bindingName = @"name";
    self.flexPie.itemsSource = pieData;
    self.flexPie.tooltip.isVisible = true;
    
}


-(void)imageSavedToPhotoAlbum:(UIImage *)image finishedSavingWithError: (NSError *)error contextInfo:(void *)contextInfo{
    NSString *message;
    NSString *title;
    if (!error) {
        title = @"Success";
        message = @"Image was saved to Camera Roll succesfully";
    }
    else{
        title = @"Failure";
        message = [error description];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
