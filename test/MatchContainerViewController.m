//
//  MatchContainerViewController.m
//  OutScore
//
//  Created by Andrés Pesate on 5/5/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import "MatchContainerViewController.h"

@interface MatchContainerViewController ()
- (IBAction)sendChallenge:(UIButton *)sender;

@end

@implementation MatchContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendChallenge:(UIButton *)sender {
}
@end
