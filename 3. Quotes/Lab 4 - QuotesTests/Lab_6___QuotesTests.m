//
//  Lab_6___QuotesTests.m
//  Lab 6 - QuotesTests
//
//  Created by Yoo Jin Lee on 9/24/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "QuotesModel.h"

@interface Lab_6___QuotesTests : XCTestCase

@property(strong,nonatomic) QuotesModel *testModel;

@end

@implementation Lab_6___QuotesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testModel = [[QuotesModel alloc] init];
}

- (void)test {
    //testing that array was created with correct number of quotes
    NSUInteger num = 5; //init method for QuotesModel creates 5 quotes
    NSUInteger numQuotes = [self.testModel numberOfQuotes];
    XCTAssertEqual(num, numQuotes);
    
    //testing that I can insert a new quote (insertQuote)
    [self.testModel insertQuote:@"To be or not to be." author:@"Shakespeare" atIndex:3];
    XCTAssertEqual(num + 1, [self.testModel numberOfQuotes]);
    
    //testing that I can remove a quote
    [self.testModel removeQuoteAtIndex:0];
    XCTAssertEqual(num, [self.testModel numberOfQuotes]);
    
    //testing that I can insert a quote w/out index or author
    NSDictionary *temp = [[NSDictionary alloc] initWithObjectsAndKeys:@"Fred and George",@"author",@"Mischief Managed",@"quote", nil];
    [self.testModel insertQuote:temp];
    XCTAssertEqual(num + 1,[self.testModel numberOfQuotes]);
    
    //testing that I can insert a quote w/out author
    [self.testModel insertQuote:temp atIndex:2];
    XCTAssertEqual(num + 2, [self.testModel numberOfQuotes]);
    
    //testing that I can insert a quote w/ author, no index
    [self.testModel insertQuote:@"If you want to know what a man's like, take a good look at how he treats his inferiors, not his equals" author:@"Sirius Black"];
    XCTAssertEqual(num + 3, [self.testModel numberOfQuotes]);
    
    //testing remove at invalid integer
    [self.testModel removeQuoteAtIndex:8];
    XCTAssertEqual(num + 3, [self.testModel numberOfQuotes]);
    
    //testing insert at invalid integer
    [self.testModel insertQuote:temp atIndex:9];
    XCTAssertEqual(num + 3, [self.testModel numberOfQuotes]);
    
    //testing insert at invalid integer w/ author parameter
    [self.testModel insertQuote:@"If you want to know what a man's like, take a good look at how he treats his inferiors, not his equals" author:@"Sirius Black" atIndex:9];
    XCTAssertEqual(num + 3, [self.testModel numberOfQuotes]);

    
    //Listing out all quotes currently in the array
    NSDictionary *quote;
    for(NSUInteger i=0; i<[self.testModel numberOfQuotes]; i++){
        quote = [self.testModel quoteAtIndex:i];
        NSLog(@"quote = %@, author = %@", quote[@"quote"], quote[@"author"]);
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
