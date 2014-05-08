//
//  MatchInfoPageViewController.h
//  OutScore
//
//  Created by Andrés Pesate on 5/6/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchInfoViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController* cardPageViewController;

@end
