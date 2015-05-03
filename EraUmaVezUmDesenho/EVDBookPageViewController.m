//
//  EVDBookPageViewController.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDBookPageViewController.h"
#import "EVDPageViewController.h"
#import "EVDSounds.h"
#import "EVDUser.h"


@interface EVDBookPageViewController ()

@property (nonatomic) EVDUser *currentUser;
@property (nonatomic) EVDSounds *buttonSounds;
@property (nonatomic) EVDPageViewController *pageViewController;

@end

@implementation EVDBookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _currentUser = [EVDUser instance];
    _buttonSounds = [[EVDSounds alloc] init];
    _pageViewController = [[EVDPageViewController alloc] init];
    
    [_btnEsq setHidden:YES];
    
    _bookPageIndex = 0;
    
    [_viewAlertFinalizar setHidden:YES];
    [_btnFinalizar setHidden:YES];
    
    
    [_pageViewController setCurrentBookKey:_bookKey];
    [self changePage];
    [_viewPage addSubview:[_pageViewController view]];
    
    [self setButtonsSettingsForCurrentUser];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated {
    [_btnDir setAlpha:0.2];
    [_btnEsq setAlpha:0.2];
    
    [super viewWillAppear:YES];
    
}

- (void) setCurrentBook:(EVDBook *)currentBook{
    _currentBook = currentBook;
}

- (void) setButtonsSettingsForCurrentUser{
    if ([self.currentUser currentUser] == 0) {
        [_btnFinalizar setHidden:YES];
        [_viewAlertFinalizar setHidden:YES];
    }

    
    [_pageViewController setButtonsSettingsForCurrentUser];
}

- (void) changePage{
    _currentPage = [[_currentBook bookPages] objectAtIndex:_bookPageIndex];
    [_pageViewController setCurrentPage:_currentPage];
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
