//
//  MatchContainerViewController.h
//  OutScore
//
//  Created by Andrés Pesate on 5/5/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *homeTeamImage;
@property (weak, nonatomic) IBOutlet UIImageView *visitTeamImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitTeamLabel;
@property (weak, nonatomic) IBOutlet UIButton *challengeButton;
@property (nonatomic, assign) NSInteger index;

//@property (nonatomic, strong) SC_Match* matchInfo;


@end
