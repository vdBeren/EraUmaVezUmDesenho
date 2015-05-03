//
//  EVDDrawViewController.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 3/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVDPage.h"

@interface EVDDrawViewController : UIViewController

@property (nonatomic) EVDPage *currentPage;

@property (nonatomic) NSInteger brushWidth;

@property (nonatomic) CGPoint touchLastPoint;
@property (nonatomic) CGPoint touchCurrentPoint;
@property (nonatomic) CGPoint touchLocation;

@property (nonatomic) UIImageView *drawImage;
@property (nonatomic) IBOutlet UIImageView *drawViewTop;
@property (nonatomic) IBOutlet UIImageView *drawViewBottom;


- (void) setDrawingColorRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)alpha;
- (void) setCurrentPage:(EVDPage *)currentPage;

@end
