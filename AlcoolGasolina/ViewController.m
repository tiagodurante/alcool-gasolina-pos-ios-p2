//
//  ViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize valorAlcool, valorGasolina;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/dados.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        dados = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    else {
        dados = [[NSMutableArray alloc] init];
    }
}

-(IBAction)calcular:(id)sender {
    // _valorAlcool.text
    // self.valorAlcool.text
    
    float alcool = valorAlcool.text.floatValue;
    float gasolina = [valorGasolina.text floatValue];
    
    if (alcool == (gasolina * 0.7)) {
        [self mostrarMensagem:@"Pós Alfa" msg:@"Tanto faz"];
    }
    else if (alcool < (gasolina * 0.7)) {
        [self mostrarMensagem:@"Pós Alfa" msg:@"Alcool é melhor"];
    }
    else {
        [self mostrarMensagem:@"Pós Alfa" msg:@"Gasolina é melhor"];
    }
}

-(void)mostrarMensagem:(NSString *)titulo msg:(NSString *)mensagem {
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:titulo message:mensagem delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alerta show];
    alerta = nil;
}

-(IBAction)compartilhar:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Compartilhar" delegate:self cancelButtonTitle:@"Voltar" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"E-mail", nil];

    [popup showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: { [self compartilharSocial:@"F"]; } break;
        case 1: { [self compartilharSocial:@"T"]; } break;
        case 2: { [self compartilharEmail]; } break;
        default: break;
    }
}

-(void)compartilharSocial:(NSString *)tipo {
    if ([tipo isEqual:@"F"]) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] == false) {
            [self mostrarMensagem:@"Pós Alfa" msg:@"Facebook não configurado ou não disponível"];
            return;
        }
    }
    else {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] == false) {
            [self mostrarMensagem:@"Pós Alfa" msg:@"Twitter não configurado ou não disponível"];
            return;
        }
    }
    
    NSString *texto = [self retornarMensagem];
    
    if ([tipo isEqual:@"T"])
        texto = [texto substringWithRange:NSMakeRange(0, 140)];
    
    SLComposeViewController *controlador;
    if ([tipo isEqual:@"F"]) {
        controlador = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    }
    else {
        controlador = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    }

    SLComposeViewControllerCompletionHandler controleFim = ^(SLComposeViewControllerResult result) {
        [controlador dismissViewControllerAnimated:YES completion:nil];
    };
    
    controlador.completionHandler = controleFim;
    [controlador setInitialText:texto];
    [controlador addURL:[NSURL URLWithString:@"http://www.faculdadealfaumuarama.com.br/"]];
    //[controlador addImage:[UIImage imageNamed:@"Logo.png"]];
    
    [self presentViewController:controlador animated:YES completion:nil];
}

-(void)compartilharEmail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
        
        email.mailComposeDelegate = self;
        
        [email setSubject:@"Alcool ou gasolina?"];
        [email setMessageBody:[self retornarMensagem] isHTML:YES];
        [email setToRecipients:[NSArray arrayWithObjects:@"contato@melhoresradios.com.br", @"marcosdiasvendramini@yahoo.com.br", nil]];
        
        //NSData *anexo = [UIImagePNGRepresentation([UIImage imageNamed:@"Logo.png"])];
        //[email addAttachmentData:anexo mimeType:@"image/png" fileName:@"Logo.png"];
        
        [self presentViewController:email animated:YES completion:nil];
    }
    else {
        [self mostrarMensagem:@"Pós Alfa" msg:@"Não é possível enviar e-mail"];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)retornarMensagem {
    float alcool = [valorAlcool.text floatValue];
    float gasolina = [valorGasolina.text floatValue];
    
    NSString *retorno = [NSString stringWithFormat:@"Valor do alcool: %f. Valor da gasolina: %f", alcool, gasolina];
    return retorno;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)gravar:(id)sender {
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          valorAlcool.text, @"alcool",
                          valorGasolina.text, @"gasolina",
                          nil];

    [dados addObject:item];
    [dados writeToFile:filePath atomically:YES];
    
    [self listarDados];
}

-(void)listarDados {
    for (NSDictionary *item in dados) {
        NSLog(@"Alcool: %@. Gasolina: %@",
              [item objectForKey:@"alcool"],
              [item objectForKey:@"gasolina"]
              );
    }
    NSLog(@"*************************************************");
}

@end
