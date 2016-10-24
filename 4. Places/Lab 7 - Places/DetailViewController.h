//
//  DetailViewController.h
//  
//
//  Created by Yoo Jin Lee on 11/6/15.
//
//

#import <UIKit/UIKit.h>

typedef void(^DetailCompletionHandler)();

@interface DetailViewController : UIViewController
@property (weak,nonatomic) NSDictionary *place;
@property (copy,nonatomic) DetailCompletionHandler completionHandler;
@end
