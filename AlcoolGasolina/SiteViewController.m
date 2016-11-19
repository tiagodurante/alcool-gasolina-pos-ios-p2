//
//  SiteViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "SiteViewController.h"

@interface SiteViewController ()

@end

@implementation SiteViewController

@synthesize website, spin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *urlString = @"http://www.portalaltonia.com.br";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [website loadRequest:request];
    /*
     A partir do Xcode 7, adicionar as seguintes linhas no arquivo Supporting Files/info.plist:
     TAG: App transport security Settings
     SUBTAG: Allow
     SUB-SUBTAG: YES
     */
}

//executando a animação de acordo com a webview
-(void) webViewDidStartLoad:(UIWebView *)webView {
    [spin startAnimating];
}

//parando a animação do spin
-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [spin stopAnimating];
}

//caso de erro no carregamento da pagina
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [spin stopAnimating];
    [self mostrarMensagem:@"Erro" msg:@"Falha no carregamento da página."];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mostrarMensagem:(NSString *)titulo msg:(NSString *)mensagem {
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:titulo message:mensagem delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alerta show];
    alerta = nil;
}

-(IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
