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
    
    [self darZoom:pino];
}

-(void)darZoom:(MKPointAnnotation *)pino {
    //Dando zoom no pino que foi fixo anteriormente
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(pino.coordinate, zoom);
    [mapa setRegion:region animated:YES];
}

-(IBAction)tipo:(id)sender {
    switch (mapa.mapType) {
        case MKMapTypeStandard:
            [mapa setMapType:MKMapTypeSatellite];
            break;
            
        case MKMapTypeSatellite:
            [mapa setMapType:MKMapTypeHybrid];
            break;
            
        case MKMapTypeHybrid:
            [mapa setMapType:MKMapTypeStandard];
            break;
        default:            
            break;
    }
}

-(IBAction)ondeEstou:(id)sender {
    //verificando se o gps está ativado
    if ([CLLocationManager locationServicesEnabled]) {
        //verificando se existe uma instancia de CCLocationManager
        if (!locManager) {
            locManager = [[CLLocationManager alloc] init];
            locManager.delegate = self;
        }
        //inicializando a atualizaçao da minha localização
        [locManager startUpdatingLocation];
    }
}

//metodo que recebe a posição do gps e fica atualizando de acordo com o usuario
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //pegando minha ultima localização
    CLLocation *minhaLocalizacao = [locations lastObject];
    //criando um pino de localização automatica do GPS
    MKPointAnnotation *pino = [[MKPointAnnotation alloc] init];
    //adicionando localização ao pino
    pino.coordinate = minhaLocalizacao.coordinate;
    pino.title = @"Estou aqui!";
    pino.subtitle = [NSString stringWithFormat:@"To perdido :( [LAT: %f, LOG: %f]", minhaLocalizacao.coordinate.latitude, minhaLocalizacao.coordinate.longitude];
    
    //adicionando pino ao mapa;
    [mapa addAnnotation:pino];
    //parando de buscar a localização após fixar o pino
    [locManager stopUpdatingLocation];
    
    [self darZoom:pino];
}

@end
