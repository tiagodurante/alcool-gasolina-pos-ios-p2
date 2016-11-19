//
//  DetalhesViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "DetalhesViewController.h"

@interface DetalhesViewController ()

@end

@implementation DetalhesViewController

@synthesize item, lbAlcool, lbGasolina;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //carrega as informações nos labels da view
    if (item) {
        lbAlcool.text = [item objectForKey:@"gasolina"];
        lbAlcool.text = [item objectForKey:@"alcool"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
