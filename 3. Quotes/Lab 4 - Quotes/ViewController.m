//
//  ViewController.m
//  Lab 3 - Quotes
//
//  Created by Yoo Jin Lee on 9/24/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "QuotesModel.h"

@interface ViewController ()
@property(strong, nonatomic) QuotesModel *myQuotes;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property(strong, nonatomic) AVAudioPlayer *pikaPlayer;
@property(strong, nonatomic) AVAudioPlayer *tonePlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myQuotes = [QuotesModel sharedModel];

    //Played for Shake Gesture & Single Tap
    NSString *toneFilePath = [NSString stringWithFormat:@"%@/tone.mp3",[[NSBundle mainBundle] resourcePath]];
    NSURL *toneFileURL = [NSURL fileURLWithPath:toneFilePath];
    
    //Played for Swipe Gesture (Left & Right)
    NSString *pikaFilePath = [NSString stringWithFormat:@"%@/pika.wav",[[NSBundle mainBundle] resourcePath]];
    NSURL *pikaFileURL = [NSURL fileURLWithPath:pikaFilePath];

    NSError *error;
    self.pikaPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:pikaFileURL error:&error];
    [self.pikaPlayer prepareToPlay];

    self.tonePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:toneFileURL error:&error];
    [self.tonePlayer prepareToPlay];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    #if TARGET_IPHONE_SIMULATOR
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    #endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake){
        //Played in displayRandomQuote
        [self displayRandomQuote];
    }
}

- (void) fadeInQuote:(NSString *) quote
              author:(NSString *) author {

    self.quoteLabel.text = quote;
    self.authorLabel.text = author;
    if(self.quoteLabel.textColor == UIColor.whiteColor){
        self.quoteLabel.textColor = [UIColor colorWithRed:165.0f/255.0f green:243.0f/255.0f blue:255.0f/255.0f alpha:1.0];
        self.authorLabel.textColor = [UIColor colorWithRed:165.0f/255.0f green:243.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    } else {
        self.quoteLabel.textColor = UIColor.whiteColor;
        self.authorLabel.textColor = UIColor.whiteColor;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (void) showQuote:(NSString *) quote
            author:(NSString *) author {
    [UIView animateWithDuration:1.0
    animations:^{
        self.quoteLabel.alpha = 0;
        self.authorLabel.alpha = 0;
    }
    completion:^(BOOL finished){
        [self fadeInQuote:quote author:author];
    }];
}

- (void) displayRandomQuote {
    //display a random quote
    NSDictionary *temp = [self.myQuotes randomQuote];
    [self.tonePlayer play];
    [self showQuote:[temp objectForKey:@"quote"] author:[temp objectForKey:@"author"]];
}

- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer
{
    [self displayRandomQuote];
}

- (void) swipeLeft:(UISwipeGestureRecognizer *) recognizer
{
    //display previous quote in array
    NSDictionary *temp = [self.myQuotes prevQuote];
    [self.pikaPlayer play];
    [self showQuote:[temp objectForKey:@"quote"] author:[temp objectForKey:@"author"]];
}

- (void) swipeRight:(UISwipeGestureRecognizer *) recognizer
{
    //display next quote in array
    NSDictionary *temp = [self.myQuotes nextQuote];
    [self.pikaPlayer play];
    [self showQuote:[temp objectForKey:@"quote"] author:[temp objectForKey:@"author"]];
}

@end
