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
        _pageDraw = [UIImage imageWithData:[pageDecoder decodeObjectForKey:@"pageDraw"]];
        _pageNumber = [pageDecoder decodeIntForKey:@"pageNumber"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)pageCoder{
    [pageCoder encodeObject:self.pageText forKey:@"pageText"];
    [pageCoder encodeObject:UIImagePNGRepresentation(self.pageDraw) forKey:@"pageDraw"];
    [pageCoder encodeInteger:self.pageNumber forKey:@"pageNumber"];
    
    
}


@end