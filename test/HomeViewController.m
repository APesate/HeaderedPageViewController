//
//  ViewController.m
//  test
//
//  Created by Andrés Pesate on 5/7/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

//
//  HomeViewController.m
//  OutScore
//
//  Created by Andrés Pesate on 4/21/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import "HomeViewController.h"
#import "MatchInfoViewController.h"
#import "MatchBannerViewController.h"

@interface HomeViewController (){
    MatchInfoViewController* cardsViewController;
    MatchBannerViewController* matchBannerViewController;
    
    UIScrollView* bannerScrollView;
}

@end

@implementation HomeViewController

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
    CGSize screenSize = self.view.frame.size;
    [super viewDidLoad];
    
    //Create the BannerViewController
    matchBannerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchBannerViewController"];
    [matchBannerViewController.view setFrame:CGRectMake(0, 64, matchBannerViewController.view.frame.size.width, matchBannerViewController.view.frame.size.height)];
    
    //Create the InfoViewController
    cardsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchInfoViewController"];
    [cardsViewController.view setFrame:CGRectMake(0, 158 + 74, cardsViewController.view.frame.size.width, screenSize.height*0.8)];
    
    [self.view addSubview:matchBannerViewController.view];
    [self.view addSubview:cardsViewController.view];
    
    //Assing the pageViewController in MatchInfoViewController scrollView delegate to HomeViewController in order to use the scrollViewDidScroll delegate method
    for (UIView *view in cardsViewController.cardPageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setDelegate:self];
        }
    }
    
    //Create the scrollView
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 218, 320, 34)];
    [bannerScrollView setContentSize:CGSizeMake(320 * 3, 34)];
    [bannerScrollView setScrollEnabled:YES];
    [bannerScrollView setShowsHorizontalScrollIndicator:YES];
    [bannerScrollView setShowsVerticalScrollIndicator:NO];
    [bannerScrollView setBounces:NO];
    [bannerScrollView setContentOffset:CGPointMake(0, 0)];
    [bannerScrollView setPagingEnabled:YES];
    
    //For debug porpuse we add 3 labels and a colored view
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*3, 34)];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(138, 10, 60, 21)];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"Label"];
    
    UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(458, 10, 60, 21)];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setText:@"Label2"];
    
    UILabel* label3 = [[UILabel alloc] initWithFrame:CGRectMake(458 + 320, 10, 60, 21)];
    [label3 setTextColor:[UIColor whiteColor]];
    [label3 setText:@"Label3"];
    
    [bannerScrollView addSubview:view];
    [bannerScrollView addSubview:label];
    [bannerScrollView addSubview:label2];
    [bannerScrollView addSubview:label3];
    
    [self.view addSubview:bannerScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat percentage = scrollView.contentOffset.x / scrollView.contentSize.width;
    
    if ((int)scrollView.contentOffset.x != 320) {
        CGPoint offset = CGPointMake((bannerScrollView.contentSize.width * percentage), 0);
        [bannerScrollView setContentOffset:offset animated:YES];
        NSLog(@"x: %f", offset.x);
    }
}


@end