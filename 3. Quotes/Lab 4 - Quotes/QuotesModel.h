//
//  QuotesModel.h
//  Lab 3 - Quotes
//
//  Created by Yoo Jin Lee on 9/24/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuotesModel : NSObject

//public methods

//class method
+ (instancetype) sharedModel;

//instance methods
- (NSDictionary *) randomQuote;
- (NSUInteger) numberOfQuotes;
- (NSDictionary *) quoteAtIndex: (NSUInteger) index;
- (void) removeQuoteAtIndex: (NSUInteger) index;
- (void) insertQuote: (NSString *) quote
              author: (NSString *) author;
- (void) insertQuote: (NSDictionary *) quote;
- (void) insertQuote: (NSString *) quote
              author: (NSString *) author
             atIndex: (NSUInteger) index;
- (void) insertQuote: (NSDictionary *) quote
             atIndex: (NSUInteger) index;
- (NSDictionary *) nextQuote;
- (NSDictionary *) prevQuote;

@end
