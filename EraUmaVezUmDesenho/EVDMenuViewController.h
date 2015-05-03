//
//  EVDMenuViewController.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "EVDBook.h"
#import "EVDPage.h"

@interface EVDMenuViewController : UIViewController

@property (nonatomic) EVDBook *bookTemp;
@property (nonatomic) EVDBook *bookSelected;
@property (nonatomic) EVDPage *pageTemp;

@property (nonatomic) NSMutableArray *bookShelfButtons;

@property (nonatomic) NSString *selectedBookButton;

@property (nonatomic) UIView *viewContent;

@property (nonatomic) IBOutlet UIScrollView *scrollViewShelf;

@property (nonatomic) UIImageView *imageViewShelf;
@property (nonatomic) IBOutlet UIImageView *imageViewCover;

@property (nonatomic) IBOutlet UILabel *lblTitle;
@property (nonatomic) IBOutlet UILabel *lblDescription;
@property (nonatomic) IBOutlet UILabel *lblAuthor;

@property (nonatomic) IBOutlet UIButton *btnFilho;
@property (nonatomic) IBOutlet UIButton *btnPai;
@property (nonatomic) IBOutlet UIButton *btnAjuda;

@end
