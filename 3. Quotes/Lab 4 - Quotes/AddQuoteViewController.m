//
//  AddQuoteViewController.m
//  Lab 5 - Quotes
//
//  Created by Yoo Jin Lee on 10/21/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import "AddQuoteViewController.h"

@interface AddQuoteViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *quoteTextView;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


@end

@implementation AddQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.cancelButton;
    self.navigationItem.rightBarButtonItem = self.saveButton;
    self.saveButton.enabled = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.quoteTextView becomeFirstResponder];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([self.quoteTextView isFirstResponder] && [touch view] != self.quoteTextView){
        [self.quoteTextView resignFirstResponder];
    }
    if ([self.authorTextField isFirstResponder] && [touch view] != self.authorTextField){
        [self.authorTextField resignFirstResponder];
    }

    [super touchesBegan:touches withEvent:event];
}


- (BOOL) textFieldShouldReturn:(UITextField *) textField {
    
    [textField resignFirstResponder];
    
    if(self.completionHandler)
    {
        self.completionHandler(self.quoteTextView.text, self.authorTextField.text);
    }
    
    self.quoteTextView.text = nil;
    self.authorTextField.text = nil;
    
    return YES;
}
- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}

- (void) enableSaveButtonForQuote: (NSString *) quoteText author: (NSString *) authorText {
    
    self.saveButton.enabled = (quoteText.length > 0 && authorText.length > 0);
}

- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self enableSaveButtonForQuote:self.quoteTextView.text author:changedString];
    
    return YES;
}


- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    
    NSString *changedString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    [self enableSaveButtonForQuote:changedString author:self.authorTextField.text];
    
    return YES;
}

- (IBAction)saveButtonTapped:(id)sender {
    
    [self.quoteTextView resignFirstResponder];
    [self.authorTextField resignFirstResponder];
    
    if(self.completionHandler)
    {
        self.completionHandler(self.quoteTextView.text, self.authorTextField.text);
    }
    
    self.quoteTextView.text = nil;
    self.authorTextField.text = nil;
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    [self.quoteTextView resignFirstResponder];
    [self.authorTextField resignFirstResponder];
    
    if(self.completionHandler)
    {
        self.completionHandler(nil, nil);
    }
    
    self.quoteTextView.text = nil;
    self.authorTextField.text = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
