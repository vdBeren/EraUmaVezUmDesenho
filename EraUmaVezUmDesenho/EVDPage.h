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
@property (nonatomic) NSString* pageText;
@property (nonatomic) NSString* pageAudioURL;
@property (nonatomic) NSString* pageBackgroundURL;
@property (nonatomic) UIImage* pageDraw;


- (void) encodeWithCoder:(NSCoder *)pageCoder;
- (instancetype) initWithCoder:(NSCoder *)pageDecoder;

@end
