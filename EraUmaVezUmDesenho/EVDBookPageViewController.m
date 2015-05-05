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
    
    
    [_pageViewController setCurrentBookKey:[_currentBook bookKey]];
    [self addChildViewController:_pageViewController];
    [_viewPage addSubview:[_pageViewController view]];
    
    
    [self setButtonsSettingsForCurrentUser];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_btnDir setAlpha:0.2];
    [_btnEsq setAlpha:0.2];
    
    [self changePage];
    
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _bookPageIndex = 0;
    [_btnDir setHidden:NO];
    [_viewAlertFinalizar setHidden:YES];
    [self changePage];
}

- (void) setCurrentBook:(EVDBook *)currentBook{
    _currentBook = currentBook;
}

- (void) setButtonsSettingsForCurrentUser{
    if ([_currentUser currentUser] == 0) {
        [_btnFinalizar setHidden:YES];
        [_viewAlertFinalizar setHidden:YES];
    }
    
    [_pageViewController setButtonsSettingsForCurrentUser];
}

- (void) changePage{
    
    [_btnFinalizar setHidden:YES];
    
    if (_bookPageIndex == [_currentBook bookPageTotal]-1) {
        [_btnFinalizar setHidden:NO];
        [_btnDir setHidden:YES];
    }
    else if (_bookPageIndex == 0) {
        [_btnEsq setHidden:YES];
    }
    
    _currentPage = [[_currentBook bookPages] objectAtIndex:_bookPageIndex];
    [_pageViewController setCurrentPage:_currentPage];
}

- (IBAction)btnMenu:(id)sender{
    
    [_pageViewController stopPlayer];
    [self.navigationController popViewControllerAnimated:YES];
    [_buttonSounds playClique:1];
    
}

- (IBAction)touchBtnEsq:(id)sender{
    if (_bookPageIndex <= 0 || [_pageViewController isRecording]){
        return;
    }
    
    [_pageViewController stopPlayer];
    [_btnDir setHidden:NO];
    
    _bookPageIndex--;
    
    [self setButtonsSettingsForCurrentUser];
    [self changePage];
    
    [_buttonSounds playClique:4];
    
}

- (IBAction)touchBtnDir:(id)sender{
    if(_bookPageIndex >= [_currentBook bookPageTotal]-1 || [_pageViewController isRecording]){
        return;
    }
    
    [_pageViewController stopPlayer];
    [_btnEsq setHidden:NO];
    
    _bookPageIndex++;
    
    [self setButtonsSettingsForCurrentUser];
    [self changePage];
    [_buttonSounds playClique:4];
}

- (IBAction)btnFinalizar:(id)sender{
    
    [_buttonSounds playClique:5];
    [_viewAlertFinalizar setHidden:NO];
    [_imageCheckViewAlert setHidden:NO];
    
}

- (IBAction)btnFinalizarOk:(id)sender{
    
    [_buttonSounds playClique:1];
    [_imageCheckViewAlert setHidden:NO];
    [_currentBook setBookLocked:YES];
    [self performSelector:@selector(checkOn) withObject:nil afterDelay:0.5];
    
}

- (IBAction)btnFinalizarCancelar:(id)sender{
    [_buttonSounds playClique:5];
    
    [_viewAlertFinalizar setHidden:YES];
}

- (void) checkOn {
    
    [_btnEsq setHidden:YES];
    [_btnDir setHidden:NO];
    
    _bookPageIndex = 0;
    [self changePage];
    [_pageViewController stopPlayer];
    
    [self.navigationController popViewControllerAnimated:YES];
    [_buttonSounds playClique:1];
    
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
