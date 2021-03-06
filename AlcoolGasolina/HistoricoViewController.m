//
//  HistoricoViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

//importando views
#import "HistoricoViewController.h"
#import "DetalhesViewController.h"

@interface HistoricoViewController ()

@end

@implementation HistoricoViewController

@synthesize dados, tabela;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/dados.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        dados = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    
    [tabela reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //numero de seções na tableView
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //returna o numero de linhas
    return dados.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //criando uma celular a partir do prototipo criado na tabela
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"Celula"];
    if (celula == nil) {
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Celula"];
    }
    
    @try {
        //verifica se este dado ja está na tabela
        if ([dados objectAtIndex:indexPath.row] != Nil){
            //carregando dicionario com um objeto do array
            NSDictionary *item = [dados objectAtIndex:indexPath.row];
            //titulo no label
            celula.textLabel.text = [self resultado:item];
            //carregando os valores dos combustiveis
            celula.detailTextLabel.text = [NSString stringWithFormat:@"Gasolina: %@. Alcool: %@", [item objectForKey:@"gasolina"], [item objectForKey:@"alcool"]];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        //retornando a celula criada
        return celula;
    }
}

-(NSString *)resultado:(NSDictionary *)item {
    //pegando as informações dos combustiveis do dicionario
    float alcool = [[item objectForKey:@"alcool"] floatValue];
    float gasolina = [[item objectForKey:@"gasolina"] floatValue];
    
    if (alcool == (gasolina * 0.7)) {
        return @"Tanto faz";
    }
    else if (alcool < (gasolina * 0.7)) {
        return @"Alcool é melhor";
    }
    else {
        return @"Gasolina é melhor";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//abrir view detalhes sem fazer nada
/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"telaDetalhe" sender:self];
}*/

//abrir view detalhes junto com alguns parametros
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"telaDetalhe"]) {
        //busca o indice da linha selecinada na tabela
        NSInteger row = [tabela.indexPathForSelectedRow row];
        //carrega o item da tabela em um NSDictionary
        NSDictionary *item = [dados objectAtIndex:row];
        //instanciando a view de destino
        DetalhesViewController *detalhes = segue.destinationViewController;
        detalhes.item = item;
        //desmarcando a linha na tabela
        [tabela deselectRowAtIndexPath:tabela.indexPathForSelectedRow animated:YES];
    }
}

@end
