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
#import "HeaderContainer.h"

#define kSCROLLVIEW_PAGE_SIZE 160
#define kSCROLLVIEW_HEADER_PADDING 138

@interface HomeViewController (){
    MatchInfoViewController* cardsViewController;
    MatchBannerViewController* matchBannerViewController;
    
    UIScrollView* headerScrollView;
    NSMutableArray* headerLabels;
    int finalOffset;
    
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
    headerLabels = [NSMutableArray arrayWithCapacity:3];
    
    matchBannerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchBannerViewController"];
    [matchBannerViewController.view setFrame:CGRectMake(0, 64, matchBannerViewController.view.frame.size.width, matchBannerViewController.view.frame.size.height)];
    
    cardsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchInfoViewController"];
    [cardsViewController.view setFrame:CGRectMake(0, 158 + 74, cardsViewController.view.frame.size.width, screenSize.height*0.8)];
    
    [self.view addSubview:matchBannerViewController.view];
    [self.view addSubview:cardsViewController.view];
    
    for (UIView *view in cardsViewController.cardPageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setDelegate:self];
        }
    }
    
    HeaderContainer* headerContainer = [[HeaderContainer alloc] initWithFrame:CGRectMake(0, 218, 320, 34)];
    
    headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCROLLVIEW_PAGE_SIZE, 34)];
    [headerScrollView setContentSize:CGSizeMake(kSCROLLVIEW_PAGE_SIZE * [cardsViewController numberOfPagesInPageViewController], 34)];
    [headerScrollView setScrollEnabled:YES];
    [headerScrollView setShowsHorizontalScrollIndicator:YES];
    [headerScrollView setShowsVerticalScrollIndicator:NO];
    [headerScrollView setBounces:NO];
    [headerScrollView setContentOffset:CGPointMake(0, 0)];
    [headerScrollView setPagingEnabled:YES];
    [headerScrollView setDelegate:self];
    [headerScrollView setClipsToBounds:NO];
    
    //For debug purpose only
    for (int i = 0; i < 3; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((kSCROLLVIEW_PAGE_SIZE * i) + kSCROLLVIEW_HEADER_PADDING, 10, 60, 21)];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:[NSString stringWithFormat:@"Label%i", i]];
        
        if (i > 0) {
            [label setAlpha:0.5f];
        }
        
        [headerScrollView addSubview:label];
        [headerLabels addObject:label];
    }
    
    [headerContainer setScrollView:headerScrollView];
    [headerContainer addSubview:headerScrollView];
    [self.view addSubview:headerContainer];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:headerScrollView]) {
        UIPageViewControllerNavigationDirection direction;
        
        if ([cardsViewController ActivePageIndex] < (finalOffset/kSCROLLVIEW_PAGE_SIZE)) {
            direction = UIPageViewControllerNavigationDirectionForward;
        } else {
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        [[cardsViewController cardPageViewController] setViewControllers:@[[cardsViewController getViewControllerForIndex:(finalOffset/kSCROLLVIEW_PAGE_SIZE)]] direction:direction animated:YES completion:nil];
        
    } else {
        [headerScrollView setContentOffset:CGPointMake(kSCROLLVIEW_PAGE_SIZE * [cardsViewController ActivePageIndex], 0) animated:YES];
    }
    
    [headerLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:0.5f animations:^{
            if (idx == [cardsViewController ActivePageIndex]) {
                [obj setAlpha:1.0f];
            } else {
                [obj setAlpha:0.5f];
            }
        }];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:headerScrollView]) {
        finalOffset = scrollView.contentOffset.x;
    }
}

@end