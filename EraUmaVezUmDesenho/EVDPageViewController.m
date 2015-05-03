//
//  EVDPageViewController.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDPageViewController.h"
#import "EVDUser.h"
#import "EVDSounds.h"
#import "EVDDrawViewController.h"
#import "AppDelegate.h"

@interface EVDPageViewController ()

@property (nonatomic) EVDUser *currentUser;
@property (nonatomic) AppDelegate *delegate;
@property (nonatomic) EVDSounds *buttonSounds;
@property (nonatomic) EVDDrawViewController *drawViewController;

@end

@implementation EVDPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _currentUser = [EVDUser instance];
    _delegate = ( AppDelegate* )[UIApplication sharedApplication].delegate;
    _buttonSounds = [[EVDSounds alloc] init];
    _drawViewController = [[EVDDrawViewController alloc] init];
    _btnColorFan = [[NSMutableArray alloc] init];
    _btnWidthFan = [[NSMutableArray alloc] init];
    
    fetchAudio = NO;
    fetchRecord = NO;
    
    imageNarrate = [UIImage imageNamed:@"Narrar.png"];
    imageNarratePause = [UIImage imageNamed:@"BtnPausar01.png"];
    imagePause = [UIImage imageNamed:@"Pausar.png"];
    imagePlay = [UIImage imageNamed:@"Play.png"];
    imageRecord = [UIImage imageNamed:@"Gravar.png"];
    imageStop = [UIImage imageNamed:@"Stop.png"];
    
    //Se for pai, libera botao de gravação.
    if ([_currentUser currentUser] == 1) {
        [_btnRecordPause setEnabled:YES];
    }
    
    [_btnPlay setEnabled:YES];
    
    [_drawViewController setCurrentPage:_currentPage];
    [_drawView addSubview:[_drawViewController view]];
    
    [self createButtonsLeque];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setCurrentPage:(EVDPage *)currentPage{
    _currentPage = currentPage;
    
    [self bgView].image = [UIImage imageNamed:@"Fundo.png"];
    [self setPageText:[_currentPage pageText] textIndex:[NSString stringWithFormat:@"%ld",[_currentPage pageNumber]+1]];
    
    [_drawViewController setCurrentPage:_currentPage];
    
    [self viewDidLayoutSubviews];
}

-(void) setCurrentBookKey:(NSString *)currentBookKey{
    _currentBookKey = currentBookKey;
}

- (void) setButtonsSettingsForCurrentUser {
    
    if ([_currentUser currentUser] == 0) {
        [_btnStop setEnabled:NO];
        [_btnRecordPause setEnabled:NO];
        [self setImagensButtonsFilho];
    }
    else {
        [_btnRecordPause setEnabled:YES];
        [self setImagensButtonsPai];
        
        for(UIButton *btnCor in self.btnColorFan)
            [btnCor setHidden:YES];
        
        for(UIButton *btnEspessura in self.btnWidthFan)
            [btnEspessura setHidden:YES];
    }
}

-(BOOL) isRecording{
    return _audioRecorder.recording;
}


- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)_record successfully:(BOOL)flag{
    
    [_btnStop setEnabled:NO];
    [_btnPlay setEnabled:YES];
    
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)_player successfully:(BOOL)flag{
    
    [_btnRecordPause setEnabled:YES];
    [_btnRecordPause setBackgroundImage:imageRecord forState:UIControlStateNormal];
    
    [self playPauseConfig];
    
}

- (void) recordPauseConfig {
    if (_btnRecordPause.currentBackgroundImage == imageRecord) {
        [_btnRecordPause setBackgroundImage:imagePause forState:UIControlStateNormal];
        [_imageLabelRecord setImage:[UIImage imageNamed:@"LegendaPausar.png"]];
        
    }
    
    else{
        [_btnRecordPause setBackgroundImage:imageRecord forState:UIControlStateNormal];
        [_imageLabelRecord setImage:[UIImage imageNamed:@"LegendaGravar.png"]];
        
    }
}

- (void) playPauseConfig {
    
    if ([_currentUser currentUser] == 0) {
        if (_btnPlay.currentBackgroundImage == imageNarrate) {
            [_btnPlay setBackgroundImage:imageNarratePause forState:UIControlStateNormal];
        }
        
        else{
            [_btnPlay setBackgroundImage:imageNarrate forState:UIControlStateNormal];
        }
    }
    else{
        if (_btnPlay.currentBackgroundImage == imagePlay) {
            [_btnPlay setBackgroundImage:imagePause forState:UIControlStateNormal];
            [_imageLabelPlayPause setImage:[UIImage imageNamed:@"LegendaPausar.png"]];
        }
        
        else{
            [_btnPlay setBackgroundImage:imagePlay forState:UIControlStateNormal];
            [_imageLabelPlayPause setImage:[UIImage imageNamed:@"LegendaIniciar.png"]];
            
        }
    }
}


- (IBAction)recordPauseTapped:(id)sender {
    
    //    para a reproducao do audio antes de comecar a gravar
    if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
    
    if (!_audioRecorder.recording) {
        
        [_delegate.background stop];
        
        if (fetchRecord == NO) {
            
            //    definindo a arquivo de aúdio
            NSArray *pathComponents = [NSArray arrayWithObjects:
                                       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                                       [NSString stringWithFormat:@"Book%@PageAudio%ld.m4a", _currentBookKey, [_currentPage pageNumber]], nil ];
        
            NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
            
            //    definindo sessao de audio
            AVAudioSession *session = [[AVAudioSession alloc]init ];
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            
            //    define a configuracao de gravador
            NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc]init];
            
            [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
            [recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
            [recordSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
            
            //Salva o caminho da gravação
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            NSString *namePathRecorder = [NSString stringWithFormat:@"RecorderBook%@Page%ld", _currentBookKey, [_currentPage pageNumber]];
            
            [prefs setURL:outputFileURL forKey:namePathRecorder];
            [prefs synchronize];
            
            //    iniciando e preparando a gravacao
            _audioRecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSettings error:nil];
            _audioRecorder.delegate  = self;
            _audioRecorder.meteringEnabled = YES;
            [_audioRecorder prepareToRecord];
            
            
            [session setActive:YES error:nil];
            fetchRecord = YES;
            
        }
        
        //        Começar a gravacao
        NSTimeInterval time = 120.0; // Dois minutos.
        [_audioRecorder recordForDuration:time];
        [self recordPauseConfig];
        
        
    }
    else {
        [_delegate.background play];
        [_audioRecorder pause];
        [self recordPauseConfig];
        
    }
    
    [_btnStop setEnabled:YES];
    [_btnPlay setEnabled:NO];
}

- (IBAction)stopTapped:(id)sender {
    [_delegate.background play];
    [_audioRecorder stop];
    
    [_btnRecordPause setBackgroundImage:imageRecord forState:UIControlStateNormal];
    [_imageLabelRecord setImage:[UIImage imageNamed:@"LegendaGravar.png"]];
    [_btnStop setEnabled:NO];
    
    fetchAudio = NO;
    fetchRecord = NO;
    
    /* Esse comanda desativa a sessão de aúdio,
     isso era útil por questão de segurança quando não tinhamos música de fundo,
     pois ela encerra inclusive a música de fundo, por isso foi desativada. */
    
    //    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //    [audioSession setActive:NO error:nil];
    
}

- (IBAction)playTapped:(id)sender {
    
    if (!_audioPlayer.playing) {
        if (!_audioRecorder.recording && !fetchAudio) {
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            NSString *namePathRecorer = [NSString stringWithFormat:@"RecorderBook%@Page%ld", _currentBookKey, [_currentPage pageNumber]];
            
            temporaryRecFileURL = [prefs URLForKey:namePathRecorer];
            
            _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:temporaryRecFileURL error:nil];
            [_audioPlayer setDelegate:self];
            [_audioPlayer setVolume:10];
            
            fetchAudio = YES;
        }
        
        [_btnRecordPause setEnabled:NO];
        [_audioPlayer play];
    }
    else {
        [_btnRecordPause setEnabled:YES];
        [_btnRecordPause setBackgroundImage:imageRecord forState:UIControlStateNormal];
        [_audioPlayer pause];
        
    }
    
    if (_btnPlay.currentBackgroundImage == imagePause) {
        [_btnRecordPause setEnabled:YES];
    }
    
    [self playPauseConfig];
}

- (void) stopPlayer{
    [_audioPlayer stop];
    if ([_currentUser currentUser] == 0) {
        [_btnPlay setBackgroundImage:imageNarrate forState:UIControlStateNormal];
    }
    else{
        [_btnPlay setBackgroundImage:imagePlay forState:UIControlStateNormal];
    }
    [_btnRecordPause setBackgroundImage:imageRecord forState:UIControlStateNormal];
    
}

- (void) setImagensButtonsPai {
    [_btnRecordPause setBackgroundImage:imageRecord forState:UIControlStateNormal];
    [_btnStop setBackgroundImage:imageStop forState:UIControlStateNormal];
    [_btnPlay setBackgroundImage:imagePlay forState:UIControlStateNormal];
    
    [_btnStop setHidden:NO];
    [_btnRecordPause setHidden:NO];
    [_imageLabelPlayPause setHidden:NO];
    [_imageLabelRecord setHidden:NO];
    [_imageLabelStop setHidden:NO];
}

- (void) setImagensButtonsFilho {
    [_btnPlay setBackgroundImage:imageNarrate forState:UIControlStateNormal];
    [_btnStop setHidden:YES];
    [_btnRecordPause setHidden:YES];
    [_imageLabelPlayPause setHidden:YES];
    [_imageLabelRecord setHidden:YES];
    [_imageLabelStop setHidden:YES];
    
}


- (void) createButtonsLeque {
    
    /*  Criacao dos botoes cor */
    int w = 65, h = 150, margin = 20, distancia = 10, qntdCor = 12, qntdEspessura = 3, wEs = 50, hEs = 50;
    CGRect posSelect;
    UIButton *btnCor;
    
    for (int i = 0; i < qntdCor; i++) {
        
        btnCor = [[UIButton alloc] initWithFrame:CGRectMake(i*(w)+margin+w, self.view.frame.size.height - h/2 - margin + 25, w-20, h+20)];
        
        NSString *imageCor = [NSString stringWithFormat:@"c%d.png", i];
        [btnCor setBackgroundImage:[UIImage imageNamed:imageCor]
                          forState:UIControlStateNormal];
        [btnCor setTag:i];
        [self.btnColorFan addObject:btnCor];
    }
    
    for(UIButton *btnCor in self.btnColorFan){
        [self.view addSubview:btnCor];
        [btnCor addTarget:self action:@selector(btnCor:) forControlEvents:UIControlEventTouchUpInside];
        [btnCor setHidden:YES];
    }
    
    //posUnselect = btnCor.frame; ??
    posSelect = btnCor.frame;
    posSelect.origin.y -= 20;
    
    /* criacao espessura */
    UIButton *btnEspessura;
    
    for (int i = 0; i < qntdEspessura; i++) {
        
        btnEspessura = [[UIButton alloc] initWithFrame:CGRectMake(margin - 15, self.view.frame.size.height - i*(hEs+distancia)-margin-(2*hEs) + 20, wEs, hEs)];
        
        NSString *imageEspessura = [NSString stringWithFormat:@"espessura%d.png", i];
        
        [btnEspessura setBackgroundImage:[UIImage imageNamed:imageEspessura]
                                forState:UIControlStateNormal];
        [btnEspessura setTag:i];
        [self.btnWidthFan addObject:btnEspessura];
    }
    
    for(UIButton *btnEspessura in self.btnWidthFan){
        [self.view addSubview:btnEspessura];
        [btnEspessura addTarget:self action:@selector(btnEspessura:) forControlEvents:UIControlEventTouchUpInside];
        [btnEspessura setHidden:YES];
    }
    
    [self corSelecionada:INTMAX_MAX];
    [self espessuraSelecionada:INTMAX_MAX];
    
}

- (IBAction)btnColorBox:(id)sender{
    
    [self.buttonSounds playClique:6];
    
    if (![_btnColorBox isSelected]) {
        [[self btnColorBox] setAlpha:0.4];
        for(UIButton *btnCor in _btnColorFan){
            [btnCor setHidden:NO];
        }
        for(UIButton *btnEspessura in _btnWidthFan){
            [btnEspessura setHidden:NO];
        }
        
        [_btnColorBox setSelected:YES];
    }
    
    else{
        [[self btnColorBox] setAlpha:1];
        for(UIButton *btnCor in _btnColorFan){
            [btnCor setHidden:YES];
        }
        for(UIButton *btnEspessura in _btnWidthFan){
            [btnEspessura setHidden:YES];
        }
        
        [_btnColorBox setSelected:NO];
    }
}

- (void)btnCor:(id)sender{
    
    [_buttonSounds playClique:7];
    
    [self corSelecionada:[sender tag]];
    selectedColor = [sender tag];
    
    int w = 65, h = 150, margin = 20, qntdCor = 12;
    
    UIButton *btnAux = sender;
    btnAux.frame = CGRectMake([sender tag]*(w)+margin+w, self.view.frame.size.height - h/2 - margin - 40 + 30, w-20, h+20);
    
    for (int i = 0; i < qntdCor; i++) {
        if (i != [sender tag]) {
            btnAux = [_btnColorFan objectAtIndex:i];
            btnAux.frame = CGRectMake(i*(w)+margin+w, self.view.frame.size.height - h/2 - margin + 25, w-20, h+20);
        }
    }
}

- (void)corSelecionada:(NSInteger)selecao {
    
    alpha = 1.0;
    switch (selecao) {
        case 0: // vermelho
            r = 193.0/255; g = 25.0/255; b = 55.0/255;
            break;
        case 1:// rosa
            r = 191.0/255; g = 39.0/255; b = 135.0/255;
            break;
        case 2:// roxo
            r = 101.0/255; g = 55.0/255; b = 137.0/255;
            break;
        case 3:// azul escuro
            r = 43.0/255; g = 61.0/255; b = 141.0/255;
            break;
        case 4:// azul claro
            r = 80.0/255; g = 170.0/255; b = 213.0/255;
            break;
        case 5:// verde claro
            r = 52.0/255; g = 158.0/255; b = 141.0/255;
            break;
        case 6:// verde escuro
            r = 84.0/255; g = 159.0/255; b = 72.0/255;
            break;
        case 7:// amarelo
            r = 213.0/255; g = 208.0/255; b = 41.0/255;
            break;
        case 8:// laranja
            r = 208.0/255; g = 125.0/255; b = 21.0/255;
            break;
        case 9: // marrom
            r = 84.0/255; g = 48.0/255; b = 19.0/255;
            break;
        case 10: // branco
            r = 1.0; g = 1.0; b = 1.0;
            break;
        default: // preto
            r = 11.0/255; g = 12.0/255; b = 12.0/255;
    }
    
    [_drawViewController setDrawingColorRed:r Green:g Blue:b Alpha:alpha];
    
}


- (void)btnEspessura:(id)sender{
    
    [self.buttonSounds playClique:7];
    [self espessuraSelecionada:[sender tag]];
    selectedWidth = [sender tag];
    
}

- (void)espessuraSelecionada:(NSInteger)selecao {
    
    switch (selecao) {
        case 0:
            brushWidth = 8;
            break;
        case 1:
            brushWidth = 12;
            break;
        case 2:
            brushWidth = 18;
            break;
        default:
            brushWidth = 12;
    }
    [_drawViewController setBrushWidth:brushWidth];
}



- (void)viewDidLayoutSubviews{
    [_lblPageText sizeToFit];
    [_lblPageIndex sizeToFit];
}

- (void) setPageText:(NSString*)text textIndex:(NSString*)textIndex{
    [_lblPageText setHidden:NO];
    _lblPageText.text = text;
    
    [_lblPageIndex setHidden:NO];
    _lblPageIndex.text = textIndex;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
