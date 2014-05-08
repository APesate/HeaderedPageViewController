//
//  MatchInfoPageViewController.h
//  OutScore
//
//  Created by Andrés Pesate on 5/6/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MatchInfoContainerViewController;

@interface MatchInfoViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController* cardPageViewController;

/*!
 @brief Method to get the index of the active view controller
 @return (int) index of the active view controller
 */
- (int)ActivePageIndex;

/*!
 @brief Method to get the view controller at a given index
 @param (NSInteger) index - position in the view controllers array
 @return (MatchInfoContainerViewController *) - view controller at the given index.
 */
- (MatchInfoContainerViewController *)getViewControllerForIndex:(NSInteger)index;

/*!
 @brief Method to get the number of ViewControllers in the UIPageViewController
 @return (NSInteger) - number of ViewControllers in the PageViewController.
 */
- (NSInteger)numberOfPagesInPageViewController;
@end
