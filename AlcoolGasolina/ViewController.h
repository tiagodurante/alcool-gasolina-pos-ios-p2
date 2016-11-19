//
//  ViewController.h
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController<UITextFieldDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    NSString *filePath;
    NSMutableArray *dados;
}

@property (strong, nonatomic) IBOutlet UITextField *valorAlcool;
@property (nonatomic, strong) IBOutlet UITextField *valorGasolina;

-(IBAction)calcular:(id)sender;
-(IBAction)compartilhar:(id)sender;

@end

