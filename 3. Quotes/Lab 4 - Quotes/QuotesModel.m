//
//  QuotesModel.m
//  Lab 3 - Quotes
//
//  Created by Yoo Jin Lee on 9/24/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import "QuotesModel.h"

static NSString *const kQuotesPlist = @"Quotes.plist";

// Class Extension
@interface QuotesModel ()
@property (strong, nonatomic) NSMutableArray *quotes;
@property (nonatomic) NSInteger currentLocation;
@property (strong,nonatomic) NSString *filepath;
@end

@implementation QuotesModel

+ (instancetype) sharedModel
{
    static QuotesModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    
    return _sharedModel;
}

- (void) save
{
    [self.quotes writeToFile:self.filepath atomically:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDirectory = [paths objectAtIndex:0];
        
        self.filepath = [docDirectory stringByAppendingPathComponent:kQuotesPlist];
        self.quotes = [NSMutableArray arrayWithContentsOfFile:self.filepath];
        
        if(!self.quotes) {
            
            self.quotes = [[NSMutableArray alloc] initWithObjects:nil];
        }
        
        /* Old Lazy Method
        //initialize our properties
        NSDictionary *quote1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Harry Potter and the Chamber of Secrets",@"author",@"It is our choices, Harry, that show what we truly are, far more than our abilities",@"quote", nil];
        NSDictionary *quote2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Harry Potter and the Sorcerer's Stone",@"author",@"It takes a great deal of bravery to stand up to our enemies, but just as much to stand up to our friends",@"quote", nil];
        NSDictionary *quote3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Harry Potter and the Chamber of Secrets",@"author",@"His eyes are as green as fresh pickled toad, his hair is as dark as a blackboard. I wish he was mine, he's really divine, The hero who conquered the Dark Lord.",@"quote", nil];
         NSDictionary *quote4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Harry Potter and the Order of the Phoenix",@"author",@"We've all got both light and dark inside us. What matters is the part we choose to act on. That's who we really are.",@"quote", nil];
         NSDictionary *quote5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Harry Potter and the Goblet of Fire",@"author",@"It matters not what someone is born, but what they grow to be.",@"quote", nil];
        
        _quotes = [[NSMutableArray alloc] initWithObjects: quote1, quote2, quote3, quote4, quote5, nil];
        */
        
        self.currentLocation = 0;
        
    }
    return self;
}

- (NSDictionary *) randomQuote{
    if(self.quotes.count>0){
        NSInteger index = random() % [self numberOfQuotes];
        self.currentLocation = index;
        return  self.quotes[index];
    } else{
        NSDictionary *noQuotes = [[NSDictionary alloc] initWithObjectsAndKeys:@"No Quotes Available!",@"quote",@"Please Add",@"author", nil];
        self.currentLocation = 0;
        return noQuotes;
    }
}

- (NSUInteger) numberOfQuotes{
    return [self.quotes count];
}

- (NSDictionary *) quoteAtIndex: (NSUInteger) index{
    if(index < self.quotes.count){
        self.currentLocation = index;
        return [self.quotes objectAtIndex:index];
    }
    else {
        NSDictionary *noQuotes = [[NSDictionary alloc] initWithObjectsAndKeys:@"No Quotes Available!",@"quote",@"Please Add",@"author", nil];
        self.currentLocation = 0;
        return noQuotes;
    }
}

- (void) removeQuoteAtIndex: (NSUInteger) index{
    if(index < self.quotes.count){
        [self.quotes removeObjectAtIndex:index];
    }
    [self save];
}

- (void) insertQuote: (NSString *) quote
              author: (NSString *) author{
    NSDictionary *temp = [[NSDictionary alloc] initWithObjectsAndKeys:author,@"author",quote,@"quote", nil];
    NSInteger index = [self.quotes count];
    [self.quotes insertObject:temp atIndex:index];
    [self save];
}

- (void) insertQuote: (NSDictionary *) quote{
    NSInteger index = [self.quotes count];
    [self.quotes insertObject:quote atIndex:index];
    [self save];
}

- (void) insertQuote: (NSString *) quote
              author: (NSString *) author
             atIndex: (NSUInteger) index{
    if(index <= self.quotes.count){
        NSDictionary *temp = [[NSDictionary alloc] initWithObjectsAndKeys:author,@"author",quote,@"quote", nil];
        [self.quotes insertObject:temp atIndex:index];
        [self save];
    }
}

- (void) insertQuote: (NSDictionary *) quote
             atIndex: (NSUInteger) index{
    if(index <= self.quotes.count){
        [self.quotes insertObject:quote atIndex:index];
        [self save];
    }
}

- (NSDictionary *) nextQuote{
    NSInteger next = self.currentLocation+1;
    if(next==self.quotes.count){
        next = 0;
    }
    self.currentLocation = next;
    return [self quoteAtIndex:next];
}

- (NSDictionary *) prevQuote{
    NSInteger prev = self.currentLocation-1;
    if(prev==-1){
        prev = self.quotes.count-1;
    }
    self.currentLocation = prev;
    return [self quoteAtIndex:prev];
}

@end
