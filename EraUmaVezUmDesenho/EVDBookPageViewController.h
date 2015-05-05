//
//  EVDBookPageViewController.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVDBook.h"
#import "EVDPage.h"

@interface EVDBookPageViewController : UIViewController


@property (nonatomic) EVDBook *currentBook;
@property (nonatomic) EVDPage *currentPage;

@property (nonatomic) NSString *bookKey;

@property (nonatomic) NSInteger bookPageIndex;

@property (weak, nonatomic) IBOutlet UIView  *viewAlertFinalizar;
@property (weak, nonatomic) IBOutlet UIButton *btnFinalizarOk;
@property (weak, nonatomic) IBOutlet UIButton *btnFinalizarCancelar;
@property (weak, nonatomic) IBOutlet UIImageView *imageCheckViewAlert;
@property (weak, nonatomic) IBOutlet UIButton *btnFinalizar;

@property (weak, nonatomic) IBOutlet UIButton *btnEsq;
@property (weak, nonatomic) IBOutlet UIButton *btnDir;

@property (weak, nonatomic) IBOutlet UIView *viewPage;

@property (weak, nonatomic) IBOutlet UIButton *btnMenu;

-(void) setCurrentBook:(EVDBook *)currentBook;

@end
