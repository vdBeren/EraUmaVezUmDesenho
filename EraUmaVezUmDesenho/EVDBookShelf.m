//
//  EVDBookShelf.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDBookShelf.h"


@interface EVDBookShelf ()

@property (nonatomic, strong) NSMutableDictionary *bookShelf;

@end


@implementation EVDBookShelf

+ (instancetype)EVDBookShelf
{
    static EVDBookShelf *bookShelf = nil;
    if (!bookShelf) {
        bookShelf = [[self alloc] initPrivate];
    }
    return bookShelf;
}

// No one should call init
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[EVDBookShelf bookShelf]"
                                 userInfo:nil];
    return nil;
}

// Secret designated initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _bookShelf = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setBook:(EVDBook *)book forKey:(NSString *)key{
    self.bookShelf[key] = book;
}


-(EVDBook *)bookForKey:(NSString *)key{
    return self.bookShelf[key];
}


-(void)deleteBookForKey:(NSString *)key{
    if (!key) {
        return;
    }
    [self.bookShelf removeObjectForKey:key];
}

-(unsigned long) bookTotal{
    return [self.bookShelf count];
    
}

@end

