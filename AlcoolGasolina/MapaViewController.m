//
//  MapaViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "MapaViewController.h"

@interface MapaViewController ()

@end

@implementation MapaViewController

@synthesize mapa, locManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) limparPinos {
    //removendo todos os pinos do mapa
    [mapa removeAnnotations:mapa.annotations];
}

-(IBAction)alfa:(id)sender {
    [self limparPinos];
    
    //marcando uma localização a partir da sua coordenada
    MKPointAnnotation *pino = [[MKPointAnnotation alloc] init];
    pino.coordinate = CLLocationCoordinate2DMake(-23.759554, -53.313904);
    pino.title = @"Faculdade Alfa";
    pino.subtitle = @"O que estou fazendo aqui????";
    [mapa addAnnotation:pino];
    
    //Dando zoom no pino que foi fixo anteriormente
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(pino.coordinate, zoom);
    [mapa setRegion:region animated:YES];
}

@end
