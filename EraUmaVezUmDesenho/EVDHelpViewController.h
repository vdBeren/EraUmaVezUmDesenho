//
//  EVDHelpViewController.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVDHelpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewHelpText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewLog;

@property (weak, nonatomic) IBOutlet UISwitch *switchBGMusic;

@property (weak, nonatomic) IBOutlet UILabel *lblHelpText;
@property (weak, nonatomic) IBOutlet UILabel *lblLog;


@end
