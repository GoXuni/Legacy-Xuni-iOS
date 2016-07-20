//
//  OnDemandController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "OnDemandController.h"
#import "CustomerData.h"
#import "YouTubeCollectionView.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

@interface OnDemandController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;
@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSelect;

@end


@implementation OnDemandController

- (IBAction)startSearching:(id)sender {
    [self.textInput resignFirstResponder];
    [self updateSearch];
}

- (IBAction)searchModeChanged:(id)sender {
    [self updateSearch];
}

-(void) updateSearch
{
    NSArray* selArray = @[@"relevance",@"date",@"viewCount",@"rating",@"title"];

    YouTubeCollectionView* cv = [[YouTubeCollectionView alloc] initWithQuery:self.textInput.text orderBy:[selArray objectAtIndex:self.sortSelect.selectedSegmentIndex]];
    self.flex.collectionView = cv;
    
    
    [cv loadMoreItems:@(50) completion:^{
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly = true;
    
    self.flex.autoGenerateColumns = false;
    
    GridColumn *thumbnail = [[GridColumn alloc] init];
    thumbnail.binding = @"thumbnail";
    thumbnail.width = 150;
    [self.flex.columns addObject:thumbnail];
    
    GridColumn *title = [[GridColumn alloc] init];
    title.binding = @"title";
    title.wordWrap = true;
    [self.flex.columns addObject:title];
    
    GridColumn *channel = [[GridColumn alloc] init];
    channel.binding = @"channelTitle";
    channel.wordWrap = true;
    [self.flex.columns addObject:channel];
    
    [self.flex.flexGridLoadedRows addHandler:^(XuniEventContainer<XuniEventArgs *> *eventContainer) {
        for(int i = 0; i <self.flex.rows.count; i++)
        {
            GridRow* row = [self.flex.rows objectAtIndex:i];
            row.height = 75;
        }
    } forObject:self];
    
    [self.flex.flexGridFormatItem addHandler:^(XuniEventContainer<GridFormatItemEventArgs *> *eventContainer) {
        
        GridColumn* col = self.flex.columns[eventContainer.eventArgs.col];
        if([col.binding isEqualToString:@"thumbnail"] && eventContainer.eventArgs.panel == self.flex.cells)
        {
            NSString* url = (NSString*)[self.flex getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:false];
            NSData* imgdata = [dic objectForKey:url];
            if(imgdata == nil)
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    NSData* imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [dic setObject:imgdata forKey:url];
                        [self.flex invalidate];
                    });
                });
                
                eventContainer.eventArgs.cancel = true;
                return;
            }
            
            UIImage  *image = [UIImage imageWithData:imgdata];
            CGRect   r      = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
            
            CGSize imageSize = image.size;
            CGSize viewSize = r.size;
            
            float hfactor = imageSize.width / viewSize.width;
            float vfactor = imageSize.height / viewSize.height;
            
            float factor = fmax(hfactor, vfactor);
            
            float newWidth = imageSize.width / factor;
            float newHeight = imageSize.height / factor;
            
            CGRect newRect = CGRectMake(r.origin.x+(r.size.width-newWidth)/2,r.origin.y+(r.size.height-newHeight)/2, newWidth, newHeight);
            
            [image drawInRect:newRect];
            
            eventContainer.eventArgs.cancel = true;
        }

    } forObject:self];
    
   
    [self updateSearch];
}


@end
