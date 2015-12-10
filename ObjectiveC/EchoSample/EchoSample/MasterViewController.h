//
//  MasterViewController.h
//  EchoSample
//
//  Created by kelley.ricker on 11/10/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController
@property NSArray* sampleKeys;
@property NSMutableDictionary *sampleList;
@property NSMutableDictionary *sampleImages;
@property NSMutableDictionary *sampleDescriptions;

@end

