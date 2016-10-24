//
//  ViewController.m
//  Lab 1 - X or Y
//
//  Created by Yoo Jin Lee on 9/4/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
    @property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pikachuButtonClicked:(id)sender {
    if(self.nameTextField.text && self.nameTextField.text.length > 0){
        NSString *name = self.nameTextField.text;
        NSString *message = [NSString stringWithFormat:@"%@, Pika-Pika, Pikachu!", name];
        self.messageLabel.text = message;
    }
    else {
        self.messageLabel.text = @"Please enter your name!";
    }
}

- (IBAction)squirtleButtonClicked:(id)sender {
    if(self.nameTextField.text && self.nameTextField.text.length > 0){
        NSString *name = self.nameTextField.text;
        NSString *message = [NSString stringWithFormat:@"%@, Squirrel + Turtle = Squirtle!!!", name];
        self.messageLabel.text = message;
    }
    else {
        self.messageLabel.text = @"Please enter your name!";
    }
}


- (IBAction)dismissKeyboard:(id)sender {
    [self.nameTextField resignFirstResponder];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([self.nameTextField isFirstResponder] && [touch view] != self.nameTextField)
    {
        [self.nameTextField resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}


@end
