//
//  DetailViewController.m
//  
//
//  Created by Yoo Jin Lee on 11/6/15.
//
//

#import "DetailViewController.h"

@interface DetailViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *placeWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [self.place valueForKey:@"name"];
    NSURL *url= [NSURL URLWithString: [self.place valueForKey:@"website"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.placeWebView loadRequest: request];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.placeWebView.frame = self.view.frame;
    [self.placeWebView setScalesPageToFit:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
}

- (void) webView: (UIWebView *) webView didFailLoadWithError:(NSError *)error{
    [self.activityIndicator stopAnimating];
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
