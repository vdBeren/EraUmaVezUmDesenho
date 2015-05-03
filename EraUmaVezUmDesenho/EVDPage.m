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

- (instancetype) initWithPageNumber:(NSInteger)pageNumber pageText:(NSString *)pageText{
    self = [super init];
    if (self) {
        _pageNumber = pageNumber;
        _pageText = pageText;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)pageDecoder{
    self = [super init];
    if (self) {
        _pageText = [pageDecoder decodeObjectForKey:@"pageText"];
        _pageNumber = [pageDecoder decodeIntForKey:@"pageNumber"];
        _pageDraw = [UIImage imageWithData:[pageDecoder decodeObjectForKey:@"pageDraw"]];
        _pageDrawBottom = [UIImage imageWithData:[pageDecoder decodeObjectForKey:@"pageDrawBottom"]];
        
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)pageCoder{
    [pageCoder encodeObject:self.pageText forKey:@"pageText"];
    [pageCoder encodeInteger:self.pageNumber forKey:@"pageNumber"];
    [pageCoder encodeObject:UIImagePNGRepresentation(self.pageDraw) forKey:@"pageDraw"];
    [pageCoder encodeObject:UIImagePNGRepresentation(self.pageDrawBottom) forKey:@"pageDrawBottom"];
    
}


@end