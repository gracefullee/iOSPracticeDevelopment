//
//  CollectionViewCell.m
//  Lab 7 - Places
//
//  Created by Yoo Jin Lee on 11/6/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@end

@implementation CollectionViewCell

- (void) setPlace:(NSDictionary *) place{
    NSString *imageFileName = [place valueForKey: @"image"];
    self.placeImageView.image = [UIImage imageNamed: imageFileName];
    self.placeLabel.text = [place valueForKey:@"name"];
}

@end
