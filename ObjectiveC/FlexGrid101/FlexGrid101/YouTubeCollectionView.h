//
//  YouTubeCollectionView.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

@interface YouTubeCollectionView : XuniCursorCollectionView

@property (readonly) NSString* query;
@property (readonly) NSString* orderBy;
-(id)initWithQuery:(NSString*)query orderBy:(NSString*)orderBy;

@end
