//
//  ViewController.m
//  SenTestingKitIssue
//
//  Created by Stanislaw Pankevich on 8/20/12.
//  Copyright (c) 2012 Stanislaw Pankevich. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)TestRequest:(id)sender {
    [[APIClient sharedClient] getPath:@"timezoneJSON" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"Success: %@", JSON);
                        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error");
    }];
}
@end
