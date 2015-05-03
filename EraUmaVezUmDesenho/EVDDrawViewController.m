//
//  EVDDrawViewController.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 3/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDDrawViewController.h"
#import "EVDUser.h"


@interface EVDDrawViewController (){
    
    float _r, _g, _b, _alpha;
}

@property (nonatomic) EVDUser *currentUser;
@property (nonatomic) UIImageView *drawView;

@end

@implementation EVDDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _currentUser = [EVDUser instance];
    
    _drawViewTop.image = _currentPage.pageDrawTop;
    _drawViewBottom.image = _currentPage.pageDrawBottom;
    
    // Se for pai, desenha na view de baixo, se for filho, na view de cima.
 
    if ([_currentUser currentUser] == 1) {
        _drawView = _drawViewBottom;
    }
    else{
        _drawView = _drawViewTop;
    }
    
    [self loadImageSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setDrawingColorRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)alpha{
    _r = r;
    _g = g;
    _b = b;
    _alpha = alpha;
}

-(void)setCurrentPage:(EVDPage *)currentPage{
    _currentPage = currentPage;
    _drawViewTop.image = _currentPage.pageDrawTop;
    _drawViewBottom.image = _currentPage.pageDrawBottom;
}

-(void)loadImageSettings{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _drawImage.image = [defaults objectForKey:@"drawImageKey"];
    _drawImage = [[UIImageView alloc] initWithImage:nil];
    _drawImage.frame = _drawView.frame;
    [_drawView addSubview:_drawImage];
    
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    _touchCurrentPoint = [touch locationInView:touch.view];
    _touchLastPoint = [touch locationInView:_drawView];
    
    [self drawInViewCurrentPoint:_touchCurrentPoint lastPoint:_touchLastPoint];
    
    [super touchesBegan: touches withEvent: event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    _touchCurrentPoint = [touch locationInView:_drawView];
    
    [self drawInViewCurrentPoint:_touchCurrentPoint lastPoint:_touchLastPoint];
    
    _touchLastPoint = _touchCurrentPoint;
}


- (void) drawInViewCurrentPoint:(CGPoint)currentPoint lastPoint:(CGPoint)lastPoint{
    
    
    //Contexto da caixa de desenho.
    UIGraphicsBeginImageContext(_drawView.frame.size);
    [_drawImage.image drawInRect:_drawView.bounds];
    
    //Define a forma, tamanho e cor da linha.
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brushWidth);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _r, _g, _b, _alpha);
    
    // Altera o contexto de desenho.
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
    
    //Começa o caminho de desenho.
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    //Move para o ponto de desenho e adiciona linha entre o ultimo e atual ponto.
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    //Desenha o caminho.
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    //Define o tamanho da caixa de desenho.
    [_drawImage setFrame:_drawView.bounds];
    
    //Se for pai, desenha mais opaco
    if ([_currentUser currentUser] == 1) {
        _drawImage.alpha = 0.2;
    }
    else{
        _drawImage.alpha = 0.7;
    }
    _drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [_drawView addSubview:_drawImage];
    
    // Coloca a imagem desenhada no pageDraw da página atual.
    if ([_currentUser currentUser] == 1) {
        _currentPage.pageDrawBottom = _drawImage.image;
    }
    else{
        _currentPage.pageDrawTop = _drawImage.image;
    }
   
    
    //[self.view sendSubviewToBack:drawImage];
    
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
