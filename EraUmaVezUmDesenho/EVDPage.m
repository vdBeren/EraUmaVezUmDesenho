//
//  EVDPage.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVDPage.h"

@interface EVDPage() <NSCoding>


@end


@implementation EVDPage

- (instancetype)initWithCoder:(NSCoder *)pageDecoder{
    self = [super init];
    if (self) {
        _pageText = [pageDecoder decodeObjectForKey:@"pageText"];
        _pageAudioURL = [pageDecoder decodeObjectForKey:@"pageAudioURL"];
        _pageBackgroundURL = [pageDecoder decodeObjectForKey:@"pageBackgroundURL"];
        _pageDraw = [UIImage imageWithData:[pageDecoder decodeObjectForKey:@"pageDraw"]];
        _pageNumber = [pageDecoder decodeIntForKey:@"pageAudioURL"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)pageCoder{
    [pageCoder encodeObject:self.pageText forKey:@"pageText"];
    [pageCoder encodeObject:self.pageAudioURL forKey:@"pageAudioURL"];
    [pageCoder encodeObject:self.pageBackgroundURL forKey:@"pageBackgroundURL"];
    [pageCoder encodeObject:UIImagePNGRepresentation(self.pageDraw) forKey:@"pageDraw"];
    [pageCoder encodeInt:self.pageNumber forKey:@"pageNumber"];
    
    
}


@end