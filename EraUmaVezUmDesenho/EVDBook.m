//
//  EVDBook.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDBook.h"
#import "EVDPage.h"

@interface EVDBook() <NSCoding>

@property (nonatomic) EVDPage *pageTemp;

@end

@implementation EVDBook

- (instancetype)initWithTxtFileAndKey:(NSString *)bookKey bookName:(NSString *)bookName{
    self = [super init];
    
    if (self) {
        _bookKey = bookKey;
        _bookName = bookName;
        _bookLocked = NO;
        [self getBookInformationFromTxt];
        
    }
    
    return self;
}

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

- (void) getBookInformationFromTxt{
    
    _bookCoverURL = [NSString stringWithFormat:@"%@Cover", _bookName];
    
    NSString *descriptionPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@TXT", _bookName]
                                                                ofType:@"txt"];
    
    NSString *descriptionContent = [NSString stringWithContentsOfFile:descriptionPath
                                                             encoding:NSUTF8StringEncoding
                                                                error:nil];
    
    int lineCount = 0, pageCount = 0;
    for (NSString *line in [descriptionContent componentsSeparatedByString:@"\n"]) {
        switch (lineCount) {
            case 0:
                _bookFantasyName = line;
                break;
            case 1:
                _bookDescription = line;
                break;
            case 2:
                _bookAuthor = line;
                break;
            case 3:
                if ([line isEqualToString:@"YES"]) {
                    _bookUseImagesAsPages = YES;
                }
                else{
                    _bookUseImagesAsPages = NO;
                }
                break;
            case 4:
                _bookPageTotal = [line integerValue];
                break;
            default:
                _pageTemp = [[EVDPage alloc] initWithPageNumber:pageCount pageText:line];
                [_bookPages addObject:_pageTemp];
                pageCount++;
        }
        
        lineCount++;
    }
}



@end
