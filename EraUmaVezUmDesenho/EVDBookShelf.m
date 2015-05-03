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

+ (instancetype)bookShelf
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
        
        NSString *path = [self bookArchivePath];
        _bookShelf = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if (!_bookShelf) {
            _bookShelf = [[NSMutableDictionary alloc] init];
        }
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

-(NSInteger) bookTotal{
    return [self.bookShelf count];
    
}

-(BOOL) saveChanges{
    NSString *path = [self bookArchivePath];
    //Return YES on success
    return [NSKeyedArchiver archiveRootObject:self.bookShelf toFile:path];
}

- (NSString *)bookArchivePath
{
    // Make sure that the first argument is NSDocumentDirectory
    // and not NSDocumentationDirectory
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get the one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"books.archive"];
}

@end

