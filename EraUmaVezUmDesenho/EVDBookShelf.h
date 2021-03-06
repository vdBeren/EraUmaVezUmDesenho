//
//  BookShelf.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVDBook.h"

@interface EVDBookShelf : NSObject

+ (instancetype)bookShelf;

- (void)setBook:(EVDBook *)book forKey:(NSString *)key;
- (EVDBook *)bookForKey:(NSString *)key;
- (void)deleteBookForKey:(NSString *)key;
- (NSInteger) bookTotal;
- (BOOL) saveChanges;

@end