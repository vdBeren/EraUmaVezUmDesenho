//
//  EVDPage.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EVDPage : NSObject <NSCoding>

@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSString *pageText;
@property (nonatomic) UIImage *pageDraw;
@property (nonatomic) UIImage *pageDrawBottom;


- (void) encodeWithCoder:(NSCoder *)pageCoder;
- (instancetype) initWithCoder:(NSCoder *)pageDecoder;
- (instancetype) initWithPageNumber:(NSInteger)pageNumber pageText:(NSString *)pageText;

@end
