//
//  EVDUser.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDUser.h"


@implementation EVDUser


+ (instancetype) instance {
    
    static EVDUser *user = nil;
    if (!user) {
        user = [[self alloc] initPrivate];
    }
    return user;
}

- (instancetype) init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use  + [EVDUser]"
                                 userInfo:nil ];
    
}

- (instancetype)initPrivate {
    
    self = [super init];
    if (self) {
        self.currentUser = 0;
    }
    
    return self;
}


@end