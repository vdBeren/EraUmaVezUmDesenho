//
//  EVDPageViewController.h
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "EVDPage.h"

@interface EVDPageViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    
    float r, g, b, alpha;
    NSInteger brushWidth, selectedColor, selectedWidth;
    CGPoint touchLastPoint, touchCurrentPoint, touchLocation;
    UIImage *imageRecord, *imagePause, *imagePlay, *imageStop, *imageNarrate, *imageNarratePause;
    NSURL *temporaryRecFileURL;
    BOOL fetchAudio, fetchRecord;
}

@property (nonatomic) UIImageView *drawImage;

@property (weak, nonatomic) IBOutlet UIButton *btnRecordPause;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnColorBox;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *drawView;
@property (nonatomic) UIImageView *drawBottomView;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabelPlayPause;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabelStop;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabelRecord;

@property (weak, nonatomic) IBOutlet UILabel *lblPageText;
@property (weak, nonatomic) IBOutlet UILabel *lblPageIndex;

@property (nonatomic) NSMutableArray *btnColorFan;
@property (nonatomic) NSMutableArray *btnWidthFan;

@property (nonatomic) AVAudioRecorder *audioRecorder;
@property (nonatomic) AVAudioPlayer *audioPlayer;

@property (nonatomic) EVDPage *currentPage;
@property (nonatomic) NSString* currentBookKey;

-(void) setCurrentPage:(EVDPage *)currentPage;
-(void) setCurrentBookKey:(NSString *)currentBookKey;
-(void) setButtonsSettingsForCurrentUser;
-(void) stopPlayer;
-(BOOL) isRecording;

@end
