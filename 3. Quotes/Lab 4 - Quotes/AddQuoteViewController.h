//
//  AddQuoteViewController.h
//  Lab 5 - Quotes
//
//  Created by Yoo Jin Lee on 10/21/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddQuoteCompletionHandler)(NSString *quote, NSString *author);

@interface AddQuoteViewController : UIViewController

@property (copy,nonatomic) AddQuoteCompletionHandler completionHandler;

@end
