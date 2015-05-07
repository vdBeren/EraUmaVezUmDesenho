//
//  EVDSettings.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 4/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//  https://www.mobiledev.nl/how-to-save-and-load-user-preferences-nsuserdefaults-in-objective-c/
//

#import <Foundation/Foundation.h>

@interface EVDSettings : NSObject

@property (nonatomic) NSString* settingsPlayBackgroundMusic;


+(NSString*)getStringForKey:(NSString*)key;
+(NSInteger)getIntForkey:(NSString*)key;
+(BOOL)getBoolForKey:(NSString*)key;

+(void)setStringForKey:(NSString*)key value:(NSString*)value;
+(void)setIntForKey:(NSString*)key value:(NSInteger)value;
+(void)setBoolForKey:(NSString*)key value:(BOOL)value;


@end
