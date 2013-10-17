//
//  APRNewController2.h
//  APRPrestamos
//
//  Created by Albert  on 22/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "modelo.h"

@protocol APRAddViewControllerDelegate2

-(void)recargar;
@end

@interface APRNewController2 : UIViewController <UITextFieldDelegate> 

@property (strong) id<APRAddViewControllerDelegate2> delegado;

@property (weak, readonly) NSManagedObjectContext * contexto;

@property (weak, nonatomic) IBOutlet UITextField *txtNombre;

@property (weak, nonatomic) IBOutlet UITextField *txtTelefono;

- (IBAction)salvar:(id)sender;

- (IBAction)cancelar:(id)sender;

@end
