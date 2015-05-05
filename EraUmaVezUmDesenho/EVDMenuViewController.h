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

@interface EVDMenuViewController : UIViewController

@property (nonatomic) EVDBook *bookTemp;
@property (nonatomic) EVDBook *bookSelected;

@property (nonatomic) NSMutableArray *bookShelfButtons;

@property (nonatomic) NSString *selectedBookButton;

@property (nonatomic) UIView *viewContent;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewShelf;

@property (nonatomic) UIImageView *imageViewShelf;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCover;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;

@property (weak, nonatomic) IBOutlet UIButton *btnFilho;
@property (weak, nonatomic) IBOutlet UIButton *btnPai;
@property (weak, nonatomic) IBOutlet UIButton *btnAjuda;

@end
