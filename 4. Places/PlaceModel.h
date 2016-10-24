//
//  PlaceModel.h
//  Lab 7 - Places
//
//  Created by Yoo Jin Lee on 11/6/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject

//public methods

//class method
+ (instancetype) sharedModel;

//instance methods
- (NSUInteger) numberOfPlaces;
- (NSDictionary *) placeAtIndex: (NSUInteger) index;

@end
