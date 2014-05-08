//
//  MatchInfoViewController.h
//  OutScore
//
//  Created by Andrés Pesate on 5/6/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchInfoContainerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet UIView *messageContainer;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (nonatomic, assign) NSInteger index;

@end
