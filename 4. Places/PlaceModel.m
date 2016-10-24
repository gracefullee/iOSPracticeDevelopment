//
//  PlaceModel.m
//  Lab 7 - Places
//
//  Created by Yoo Jin Lee on 11/6/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import "PlaceModel.h"

@interface PlaceModel ()
@property (strong, nonatomic) NSMutableArray *places;
@end

@implementation PlaceModel

+(instancetype) sharedModel
{
    static PlaceModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    
    return _sharedModel;
}

- (instancetype) init
{
    self = [super init];
    
    if(self){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Places" ofType:@"plist"];
        _places = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    
    return self;
}

- (NSUInteger) numberOfPlaces
{
    return [self.places count];
}

- (NSDictionary *) placeAtIndex: (NSUInteger) index
{
    if(index < self.places.count){
        return [self.places objectAtIndex:index];
    }
    else{
        return nil;
    }
}

@end
