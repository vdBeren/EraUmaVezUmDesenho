//
//  EVDHelpViewController.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDHelpViewController.h"
#import "EVDSounds.h"
#import "AppDelegate.h"

@interface EVDHelpViewController ()

@property (nonatomic) EVDSounds *buttonsSounds;
@property (nonatomic) AppDelegate *delegate;

@end

@implementation EVDHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _scrollViewHelpText.contentSize = _lblHelpText.frame.size;
    _scrollViewLog.contentSize = _lblLog.frame.size;
    
    _buttonsSounds = [[EVDSounds alloc] init];
    _delegate = ( AppDelegate* )[UIApplication sharedApplication].delegate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnHome:(id)sender{
    [_buttonsSounds playClique:1];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)switchBGMusic:(id)sender {
    
    if(_switchBGMusic.on) {
        [_delegate.background play];
    }
    else {
        [_delegate.background stop];
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
