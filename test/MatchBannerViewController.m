//
//  MatchBannerViewController.m
//  OutScore
//
//  Created by Andrés Pesate on 5/6/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import "MatchBannerViewController.h"
#import "MatchContainerViewController.h"

@interface MatchBannerViewController (){
    UIPageViewController* pageViewController;
    NSArray* pagesArray;
}

@end

@implementation MatchBannerViewController

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
    //For debug porpuse we create an array representing the number of view controllers
    pagesArray = @[@"1", @"2", @"3"];
    [self instatiatePageViewController];
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

#pragma mark - UIPageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((MatchContainerViewController*) viewController).index;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((MatchContainerViewController*) viewController).index;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [pagesArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (MatchContainerViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([pagesArray count] == 0) || (index >= [pagesArray count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    MatchContainerViewController *matchContainerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"matchContainerVC"];
    [matchContainerViewController.view setFrame:CGRectMake(0, 0, 320, 158)];
    matchContainerViewController.index = index;
    
    return matchContainerViewController;
}

- (void)instatiatePageViewController {
    // Create page view controller
    pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageViewController.dataSource = self;
    
    MatchContainerViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    
    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    pageViewController.view.frame = CGRectMake(0, 0, 320, 158);
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController didMoveToParentViewController:self];
}

@end
