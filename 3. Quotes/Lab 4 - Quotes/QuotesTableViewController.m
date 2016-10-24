//
//  QuotesTableViewController.m
//  TableView
//
//  Created by Yoo Jin Lee on 10/7/15.
//  Copyright (c) 2015 Yoo Jin Lee. All rights reserved.
//

#import "QuotesTableViewController.h"
#import "QuotesModel.h"
#import "AddQuoteViewController.h"

@interface QuotesTableViewController ()
@property (strong, nonatomic) QuotesModel *model;
@end

@implementation QuotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [QuotesModel sharedModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.model numberOfQuotes];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    NSDictionary *quote = [self.model quoteAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat: @"%@", quote[@"quote"]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat: @"%@", quote[@"author"]];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.model removeQuoteAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (IBAction)addButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"AddQuoteViewControllerSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    AddQuoteViewController *addQuoteVC = segue.destinationViewController;
    addQuoteVC.completionHandler = ^(NSString *quote, NSString *author) {
        if(quote!=nil)
        {
            [self.model insertQuote:quote author:author];
            [self.tableView reloadData];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    // Pass the selected object to the new view controller.
}


@end
