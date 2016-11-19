//
//  HistoricoViewController.h
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoricoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tabela;
@property (strong, nonatomic) NSArray *dados;

-(IBAction)voltar:(id)sender;

@end
