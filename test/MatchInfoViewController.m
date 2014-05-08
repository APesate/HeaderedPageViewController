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
    NSMutableArray* pagesArray;
    
    int activePage;
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
    // Do any additional setup after loading the view.
    activePage = 0;
    pagesArray = [NSMutableArray arrayWithCapacity:3];
    
    for (int i = 0; i < 3; i++) {
        [pagesArray addObject:[self viewControllerAtIndex:i]];
    }
    
    [self instatiatePageViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((MatchInfoContainerViewController*) viewController).index;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [pagesArray objectAtIndex:index];
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
    return [pagesArray objectAtIndex:index];
}

- (MatchInfoContainerViewController *)viewControllerAtIndex:(NSUInteger)index
{
    //    if (([pagesArray count] == 0) || (index >= [pagesArray count])) {
    //        return nil;
    //    }
    
    // Create a new view controller and pass suitable data.
    CGSize screenSize = self.view.frame.size;
    MatchInfoContainerViewController *matchContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchInfoContainerViewController"];
    [matchContainer.view setFrame:CGRectMake(0, 0, 320, screenSize.height - 158)];
    matchContainer.index = index;
    
    return matchContainer;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        activePage = [[[_cardPageViewController viewControllers] firstObject] index];
    }
}

- (void)instatiatePageViewController {
    // Create page view controller
    _cardPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _cardPageViewController.dataSource = self;
    _cardPageViewController.delegate = self;
    
    
    // MatchInfoContainerViewController *startingViewController = [pagesArray firstObject];
    NSArray *viewControllers = pagesArray;
    
    [_cardPageViewController setViewControllers:@[[viewControllers firstObject]]  direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    CGSize screenSize = self.view.frame.size;
    _cardPageViewController.view.frame = CGRectMake(0, 20, 320, screenSize.height - 158);
    
    [self addChildViewController:_cardPageViewController];
    [self.view addSubview:_cardPageViewController.view];
    [_cardPageViewController didMoveToParentViewController:self];
}

- (NSInteger)numberOfPagesInPageViewController {
    return [pagesArray count];
}

- (MatchInfoContainerViewController *)getViewControllerForIndex:(NSInteger)index {
    activePage = index;
    return (MatchInfoContainerViewController *)[pagesArray objectAtIndex:index];
}

- (int)ActivePageIndex {
    return activePage;
}

@end
