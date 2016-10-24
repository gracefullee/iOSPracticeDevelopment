//
//  ViewController.m
//  Lab 2 - Story
//
//  Created by Yoo Jin Lee on 9/21/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *houseSegControl;
@property (weak, nonatomic) IBOutlet UISlider *ageSlider;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UIStepper *gradeStepper;
@property (weak, nonatomic) IBOutlet UISwitch *happyEndingSwitch;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) NSString *message;
@end

@implementation ViewController

- (IBAction)sliderChanged:(id)sender {
    int numberAsInt = (int) (self.ageSlider.value + 0.5f);
    NSString *newLabel = [[NSString alloc] initWithFormat:@"%d", numberAsInt];
    self.ageLabel.text = newLabel;
}

- (IBAction)gradeChanged:(id)sender {
    int stepperNum = (int) self.gradeStepper.value;
    NSString *newLabel = [[NSString alloc] initWithFormat: @"%d", stepperNum];
    self.gradeLabel.text = newLabel;
    
}

- (IBAction)segControlClicked:(id)sender {
    int clickedSegment = (int) [sender selectedSegmentIndex];
    if(clickedSegment==0)
    {
        self.optionView.hidden = YES;
    }
    else{
        self.optionView.hidden = NO;
    }
    
}

- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([self.nameTextField isFirstResponder] && [touch view] != self.nameTextField){
        [self.nameTextField resignFirstResponder];
    }
    if ([self.numberTextField isFirstResponder] && [touch view] != self.numberTextField){
        [self.numberTextField resignFirstResponder];
    }
    if ([self.cityTextField isFirstResponder] && [touch view] != self.cityTextField)
    {
        [self.cityTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)createStoryButtonClicked:(id)sender {
   
    //Check if all text fields are filled out
    if(self.nameTextField.text.length==0 || self.numberTextField.text.length==0 || self.cityTextField.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Fields" message:@"Please fill out all fields: name, number, and city." delegate: self cancelButtonTitle:@"Yes, Master" otherButtonTitles:nil];
        [alert show];    }
    
    else{
        void (^createStory)(void) = ^{
            NSString *name = self.nameTextField.text;
            NSString *number = self.numberTextField.text;
            NSString *city = self.cityTextField.text;
       
            NSString *house;
            int clickedSegment = (int) [self.houseSegControl selectedSegmentIndex];

            switch (clickedSegment){
                case 0:
                    house = @"Gryffindor";
                    break;
                case 1:
                    house = @"Hufflepuff";
                    break;
                case 2:
                    house = @"Ravenclaw";
                    break;
                case 3:
                    house = @"Slytherin";
                    break;
                
            }
        
            int age = (int) (self.ageSlider.value + 0.5f);
            int grade = (int) (self.gradeStepper.value);
            BOOL happyEnding = self.happyEndingSwitch.isOn;
            if(happyEnding){
                NSString *story = [NSString stringWithFormat:@"%@ became the headmaster at Hogwarts School of Witchcraft and Wizardry at the age of %d, originally from %@ and sorted into %@. In %dth year at Hogwarts, %@ spells were learned and mastered - a historical record. %@ remains as one of the most well-known wizard of all time.",name,age,city,house,grade,number,name];
                self.message = story;
            } else{
                NSString *story = [NSString stringWithFormat:@"%@ got expelled from Hogwarts School of Witchcraft and Wizardry at the age of %d, from a fight that occured in %@ hous in %dth year. %@ moved back to %@ and turned to Death Eaters, killing %@ people in Godric's Hollow.",name,age,house,grade,name,city,number];
                self.message = story;
            }
        
        };
    
        //Action Sheet
        UIView *senderView = (UIView *)sender;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you ready for your story?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Magic!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            createStory();
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Daily Prophet" message:self.message delegate: self cancelButtonTitle:@"Mischief Managed" otherButtonTitles:nil];
            [alert show];
        }];
    
        [alertController addAction:yesAction];
        [self presentViewController:alertController animated:YES completion:nil];
    
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    
        if(popover){
        popover.sourceView = senderView;
        popover.sourceRect = senderView.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.optionView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
