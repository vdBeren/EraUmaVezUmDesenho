//
//  EVDMenuViewController.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 2/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "EVDMenuViewController.h"
#import "EVDUser.h"
#import "EVDSounds.h"
#import "EVDBookShelf.h"
#import "EVDBookPageViewController.h"
#import "EVDHelpViewController.h"

@interface EVDMenuViewController (){
    
    UIImage *shelfTop, *shelfBottom, *shelfMiddle;
    UIButton *auxCheckLocked;
    
}

@property (nonatomic) EVDUser *currentUser;
@property (nonatomic) EVDSounds *buttonsSounds;
@property (nonatomic) NSString *bookKey;
@property (nonatomic) EVDHelpViewController *helpViewController;
@property (nonatomic) EVDBookPageViewController *bookViewController;

@end

@implementation EVDMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _currentUser = [EVDUser instance];
    _buttonsSounds = [[EVDSounds alloc] init];
    _helpViewController = [[EVDHelpViewController alloc] init];
    _bookViewController = [[EVDBookPageViewController alloc] init];
    _bookShelfButtons = [[NSMutableArray alloc] init];
    
    _viewContent = [[UIView alloc] initWithFrame:_scrollViewShelf.bounds];
    _imageViewShelf = [[UIImageView alloc] initWithFrame:_scrollViewShelf.bounds];
    
    [_scrollViewShelf addSubview:_imageViewShelf];
    [_scrollViewShelf addSubview:_viewContent];
    
    shelfTop = [UIImage imageNamed:@"shelfTop.png"];
    shelfMiddle = [UIImage imageNamed:@"shelfMiddle.png"];
    shelfBottom = [UIImage imageNamed:@"shelfBottom.png"];
    
    [self createStandardBooks];
    [self sortShelfButtonArray];
    
    // -- Seleciona o livro 1 de começo.
    _selectedBookButton = [NSString stringWithFormat:@"%ld", (long)0];
    _bookSelected = [[EVDBookShelf bookShelf] bookForKey:_selectedBookButton];
    
    [self enableBtnFilhoPai];
    
    _lblTitle.text = [_bookSelected bookFantasyName];
    _lblDescription.text = [_bookSelected bookDescription];
    _lblAuthor.text = [_bookSelected bookAuthor];
    
    _imageViewCover.image = [UIImage imageNamed:[_bookSelected bookCoverURL]];
    
    //-- FIM
    
    [_btnFilho setEnabled:NO];
    [_btnPai setEnabled:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews{
    
    // Arruma tamanho e posição das labels de informação do livro.
    [_lblDescription sizeToFit];
    
    CGRect descBounds = _lblDescription.frame;
    CGSize authorSize = _lblAuthor.frame.size;
    
    [_lblAuthor setFrame:CGRectMake(descBounds.origin.x, descBounds.origin.y + descBounds.size.height + authorSize.height, authorSize.width, authorSize.height)];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self enableBtnFilhoPai];
    
    
    if ([self.bookSelected bookLocked]) {
        //printf("fechado");
        UIImageView *fechado;
        // (xLocation, yLocation, myCircleWidth, myCircleHeight)
        fechado = [[UIImageView alloc] initWithFrame:CGRectMake(auxCheckLocked.frame.size.width/2, auxCheckLocked.frame.size.height/2, 50, 50)];
        fechado.image = [UIImage imageNamed:@"Check-01.png"];
        [auxCheckLocked addSubview:fechado];
    }
    
    [super viewWillAppear:YES];
}

- (void) createStandardBooks{
    
    // Cria os livros padrão do aplicativo, apenas se jã não existir livros na estante.
    
    if ([[EVDBookShelf bookShelf] bookTotal] <= 0) {
        [self createBookWithBookTotalPages:14 bookName:@"3pq"];
        [self createBookWithBookTotalPages:10 bookName:@"redhood"];
        [self createBookWithBookTotalPages:24 bookName:@"joaoemaria"];
        NSLog(@"Criou livros padroes pela primeira e unica vez!");
    }

    
}

- (IBAction) btnAjuda:(id)sender{
    [_buttonsSounds playClique:1];
    
    [self.navigationController pushViewController:_helpViewController animated:YES];
}

- (IBAction) btnFilho:(id)sender {
    
    [_buttonsSounds playClique:3];
    
    [_currentUser setCurrentUser:0];
    [_bookViewController setCurrentBook:_bookSelected];
    [self.navigationController pushViewController:_bookViewController  animated:YES];

    
}

- (IBAction) btnPai:(id)sender {
    
    [_buttonsSounds playClique:2];
    
    [_currentUser setCurrentUser:1];
    [_bookViewController setCurrentBook:_bookSelected];
    [self.navigationController pushViewController:_bookViewController  animated:YES];

}

- (void) selectedButton:(id)sender{
    auxCheckLocked = sender;
    
    [_buttonsSounds playClique:0];
    
    _selectedBookButton = [NSString stringWithFormat:@"%ld", (long)[sender tag]];
    _bookSelected = [[EVDBookShelf bookShelf] bookForKey:_selectedBookButton];
    
    [self enableBtnFilhoPai];
    
    _lblTitle.text = [_bookSelected bookFantasyName];
    _lblDescription.text = [_bookSelected bookDescription];
    _lblAuthor.text = [_bookSelected bookAuthor];
    
    _imageViewCover.image = [UIImage imageNamed:[_bookSelected bookCoverURL]];
    
}

- (void) enableBtnFilhoPai{
    if ([self.bookSelected bookLocked]) {
        [_btnFilho setEnabled:YES];
        [_btnPai setEnabled:NO];
    }
    else {
        [_btnPai setEnabled:YES];
        [_btnFilho setEnabled:NO];
    }
}

- (void) createBookWithBookTotalPages:(NSInteger)bookTotalPages bookName:(NSString*)bookName{
    
    NSString *key = [NSString stringWithFormat:@"%lu", [EVDBookShelf bookShelf].bookTotal];
    
    //NSLog(@"KEY >> %@", key);
    
    _bookTemp = [[EVDBook alloc] initWithTxtFileAndKey:key bookName:bookName];
    
    [[EVDBookShelf bookShelf] setBook:_bookTemp forKey:_bookTemp.bookKey];
    
}

- (void) sortShelfButtonArray{
    
    UIButton *btnBook;
    
    NSString *coverUrl;
    
    int tagCount = 0;
    int colunas = 3, w = 125, h = 125, marginX = 32, marginY = 32; // Configs dos botões de livro.
    NSInteger bookTotal = [EVDBookShelf bookShelf].bookTotal;
    NSInteger linhas = bookTotal/3;
    
    
    CGSize shelfImageSize, auxSize;
    CGFloat shelfTopMaxHeight = 40, shelfMiddleMaxHeight = 150, shelfBottomMaxHeight = 200; // Tamanho maximo de altura de cada divisao.
    shelfImageSize.width = _imageViewShelf.frame.size.width; // Largura da scroll view. Não mude isso.
    shelfImageSize.height = shelfTopMaxHeight;
    _imageViewShelf.image = shelfTop;
    
    if (linhas % 3 != 0) {
        linhas++;
    }
    
    
    for(int i = 0; i <= linhas; i++){
        if (i > 3 || i == 0) {
            
            CGRect originalSize = _viewContent.bounds;
            CGRect newSize = CGRectMake(originalSize.origin.x, originalSize.origin.y, originalSize.size.width, originalSize.size.height + h);
            
            //[_viewContent setBackgroundColor:[UIColor redColor]];
            
            _scrollViewShelf.contentSize = CGSizeMake(newSize.size.width, newSize.size.height);
            [_viewContent setFrame:newSize];
            
        }
        
        // DESENHAR ESTANTE
        auxSize.height = shelfImageSize.height;
        shelfImageSize.height += shelfMiddleMaxHeight;
        
        //Se ultima linha, prepara desenho da divisao de baixo.
        if (i == linhas) {
            UIGraphicsBeginImageContext(CGSizeMake(shelfImageSize.width, shelfImageSize.height + shelfBottomMaxHeight));
        }
        else{
            UIGraphicsBeginImageContext(shelfImageSize);
        }
        
        
        // Copia a imagem atual para a tela de draw.
        [_imageViewShelf.image drawInRect:CGRectMake(0, 0, shelfImageSize.width, auxSize.height)];
        
        //Aplica a proxima imagem na tela de draw, logo abaixo a anterior.
        [shelfMiddle drawInRect:CGRectMake(0, auxSize.height, shelfImageSize.width, shelfMiddleMaxHeight)];
        
        
        if (i == linhas) {
            auxSize.height += shelfMiddleMaxHeight;
            [shelfBottom drawInRect:CGRectMake(0, auxSize.height, shelfImageSize.width, shelfBottomMaxHeight)];
        }
        
        //Atualiza a imagem.
        _imageViewShelf.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        //Atualiza o tamanho da imagem.
        [_imageViewShelf setFrame:CGRectMake(_imageViewShelf.frame.origin.x, _imageViewShelf.frame.origin.y, shelfImageSize.width, shelfImageSize.height)];
        
        
        for (int j = 0; j < colunas && bookTotal > 0; j++) {
            
            bookTotal--;
            
            int spaceY = i*h+marginY;
            
            if (i > 0) {
                spaceY = i*h+(marginY);
            }
            
            btnBook = [[UIButton alloc] initWithFrame:CGRectMake(j*w+(marginX*j+marginX), spaceY, w-marginX, h-marginX)];
            
            btnBook.tag = tagCount;
            tagCount++;
            
            coverUrl = [[[EVDBookShelf bookShelf]bookForKey:[NSString stringWithFormat:@"%d", j]]bookCoverURL];
            
            //[btnBook setTitle:@"BUTTON" forState:UIControlStateNormal];
            [btnBook setBackgroundImage: [UIImage imageNamed:coverUrl]
                               forState:UIControlStateNormal];
            [_bookShelfButtons addObject:btnBook];
            
            if (j == 0)
                auxCheckLocked = btnBook;
        }
    }
    
    for(UIButton *btnBook in _bookShelfButtons){
        [_viewContent addSubview:btnBook];
        
        [btnBook addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
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
