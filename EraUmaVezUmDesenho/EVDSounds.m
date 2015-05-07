//
//  EVDSounds.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//  http://www.freesfx.co.uk
//

#import "EVDSounds.h"
#import <AVFoundation/AVFoundation.h>

@interface EVDSounds ()

{
    AVAudioPlayer *click;
    AVAudioPlayer *background;
}

@end

@implementation EVDSounds

- (void) playClique:(int)select{
    
    NSString *path, *name;
    NSString *bundle = [[NSBundle mainBundle] resourcePath];
    NSURL *soundUrl;
    
    switch (select) {
        case 0:
            name = @"clickLapisEspessura.mp3";
            break;
        case 1:
            name = @"home.mp3";
            break;
        case 2:
            name = @"home.mp3";
            break;
        case 3:
            name = @"home.mp3";
            break;
        case 4:
            name = @"pageProx.mp3";
            break;
        case 5:
            name = @"finalizar.mp3";
            break;
        case 6:
            name = @"caixaLapis.mp3";
            break;
        case 7:
            name = @"clickLapisEspessura.mp3";
            break;
        case 8:
            name = @"page.mp3";
            break;
    }
    
    path = [NSString stringWithFormat:@"%@/%@", bundle, name];
    
    soundUrl = [NSURL fileURLWithPath:path];
    click = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    click.numberOfLoops = 0;
    [click setVolume:0.1];
    
    if (select == 4) {
        [click setVolume:0.01];
    }
    
    [click play];
}

@end