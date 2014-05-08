//
//  MatchInfoPageViewController.m
//  OutScore
//
//  Created by Andrés Pesate on 5/6/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import "MatchInfoViewController.h"
#import "MatchInfoContainerViewController.h"

@interface MatchInfoViewController (){
    NSArray* pagesArray;
    int activePageIndex;
}

@end

@implementation MatchInfoViewController

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
    activePageIndex = 0;
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
    NSUInteger index = ((MatchInfoContainerViewController*) viewController).index;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((MatchInfoContainerViewController*) viewController).index;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [pagesArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (MatchInfoContainerViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([pagesArray count] == 0) || (index >= [pagesArray count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    CGSize screenSize = self.view.frame.size;
    MatchInfoContainerViewController *matchContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchInfoContainerViewController"];
    [matchContainer.view setFrame:CGRectMake(0, 0, 320, screenSize.height - 158)];
    matchContainer.index = index;
    activePageIndex = index;
    
    return matchContainer;
}

- (void)instatiatePageViewController {
    // Create page view controller
    _cardPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _cardPageViewController.dataSource = self;
    _cardPageViewController.delegate = self;
    
    
    MatchInfoContainerViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    
    [_cardPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    CGSize screenSize = self.view.frame.size;
    _cardPageViewController.view.frame = CGRectMake(0, 20, 320, screenSize.height - 158);
    
    [self addChildViewController:_cardPageViewController];
    [self.view addSubview:_cardPageViewController.view];
    [_cardPageViewController didMoveToParentViewController:self];
}

- (NSInteger)currentPageIndex{
    return activePageIndex;
}

@end
