//
//  YouTubeCollectionView.m
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "YouTubeCollectionView.h"
#import "SampleData.h"

@interface YouTubeCollectionView ()
@property NSString *pageToken;
@end

@implementation YouTubeCollectionView

- (id)initWithQuery:(NSString *)query orderBy:(NSString *)orderBy {
    self = [super init];
    if (self) {
        _query     = query;
        _orderBy   = orderBy;
        _pageToken = @"";
    }
    return self;
}

- (bool)hasMoreItems {
    return false;
}

- (NSMutableArray *)itemGetter:(NSNumber *)desiredNumber {
    NSMutableArray<SampleData*>* dataToAppend = [[NSMutableArray alloc]init];
    
    NSString *urlAddress = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=%@&order=%@&maxResults=%@%@&key=%@", [_query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]], _orderBy, desiredNumber, _pageToken.length ? [NSString stringWithFormat:@"&pageToken=%@", _pageToken] : @"", @"AIzaSyDFz8V9U0ccKXQ5oSrcRSoHqpaursqOudo"];

    NSData *dataResult = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlAddress]];
    NSError *error      = nil;
    
    if(dataResult == nil) return nil;
    
    id     object      = [NSJSONSerialization
                 JSONObjectWithData:dataResult
                            options:0
                              error:&error];

    if (error) {
    }

    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *results = object;
        self.pageToken = [results objectForKey:@"nextPageToken"];
        
        NSArray* items = [results objectForKey:@"items"];
        for (NSDictionary* dict in items) {
            NSString* title = [[dict objectForKey:@"snippet"] objectForKey:@"title"];
            NSString* description = [[dict objectForKey:@"snippet"] objectForKey:@"description"];
            
            SampleData* sample = [[SampleData alloc] initWithTitle:title subtitle:description];
            sample.channelTitle = [[dict objectForKey:@"snippet"] objectForKey:@"channelTitle"];
            sample.link = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", [[dict objectForKey:@"id"] objectForKey:@"videoId"]];
            
            sample.thumbnail = [[[[dict objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"default"] objectForKey:@"url"];
            [dataToAppend addObject:sample];
            
        }
    } else {
    }


    return dataToAppend;
}

@end
