//
//  DetailsViewController.m
//  IndexTableWithSearchBar
//
//  Created by sri Divya on 12/10/16.
//  Copyright © 2016 MyCompanyName. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize nameLabel;
@synthesize detailsLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setDetailsLabel:nil];
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
    nameLabel.text = self.foodTitle;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
