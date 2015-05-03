//
//  EVDBook.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EVDBook : NSObject <NSCoding>

@property (nonatomic) NSMutableArray* bookPages;

@property (nonatomic) NSInteger bookPageTotal;

@property (nonatomic) NSString* bookName;
@property (nonatomic) NSString* bookKey;

@property (nonatomic) NSString* bookFantasyName;
@property (nonatomic) NSString* bookDescription;
@property (nonatomic) NSString* bookAuthor;
@property (nonatomic) NSString* bookCoverURL;

@property (nonatomic) BOOL bookLocked;
@property (nonatomic) BOOL bookUseImagesAsPages;

- (void) encodeWithCoder:(NSCoder *)bookCoder;
- (instancetype) initWithCoder:(NSCoder *)bookDecoder;
- (instancetype) initWithTxtFileAndKey:(NSString *)bookKey bookName:(NSString *)bookName;

@end
