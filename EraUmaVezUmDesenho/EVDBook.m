//
//  EVDBook.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDBook.h"

@interface EVDBook() <NSCoding>


@end

@implementation EVDBook

- (instancetype)initWithCoder:(NSCoder *)bookDecoder{
    self = [super init];
    if (self) {
        _bookPages = [[NSMutableArray alloc] init];
        
        _bookAuthor = [bookDecoder decodeObjectForKey:@"bookAuthor"];
        _bookCoverURL = [bookDecoder decodeObjectForKey:@"bookCoverURL"];
        _bookDescription = [bookDecoder decodeObjectForKey:@"bookDescription"];
        _bookFantasyName = [bookDecoder decodeObjectForKey:@"bookFantasyName"];
        _bookKey = [bookDecoder decodeObjectForKey:@"bookKey"];
        _bookName = [bookDecoder decodeObjectForKey:@"bookName"];
        _bookPages = [bookDecoder decodeObjectForKey:@"bookPages"];
        _bookPageTotal = [bookDecoder decodeIntegerForKey:@"bookPageTotal"];
        _bookLocked = [bookDecoder decodeBoolForKey:@"bookLocked"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)bookCoder{
    [bookCoder encodeObject:self.bookAuthor forKey:@"bookAuthor"];
    [bookCoder encodeObject:self.bookCoverURL forKey:@"bookCoverURL"];
    [bookCoder encodeObject:self.bookDescription forKey:@"bookDescription"];
    [bookCoder encodeObject:self.bookFantasyName forKey:@"bookFantasyName"];
    [bookCoder encodeObject:self.bookKey forKey:@"bookKey"];
    [bookCoder encodeObject:self.bookName forKey:@"bookName"];
    [bookCoder encodeObject:self.bookPages forKey:@"bookPages"];
    [bookCoder encodeInteger:self.bookPageTotal forKey:@"bookPageTotal"];
    [bookCoder encodeBool:self.bookLocked forKey:@"bookLocked"];
    
}

@end
