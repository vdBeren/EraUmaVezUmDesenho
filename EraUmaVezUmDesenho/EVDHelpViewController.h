//
//  EVDHelpViewController.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVDHelpViewController : UIViewController

@property (nonatomic) IBOutlet UIScrollView *scrollViewHelpText;
@property (nonatomic) IBOutlet UIScrollView *scrollViewLog;

@property (nonatomic) IBOutlet UISwitch *switchBGMusic;

@property (nonatomic) IBOutlet UILabel *lblHelpText;
@property (nonatomic) IBOutlet UILabel *lblLog;

@end
