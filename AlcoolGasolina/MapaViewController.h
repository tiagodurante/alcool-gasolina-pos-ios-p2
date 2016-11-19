//
//  MapaViewController.h
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapaViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) IBOutlet CLLocationManager *locManager;

-(IBAction)voltar:(id)sender;

@end
