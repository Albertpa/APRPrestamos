//
//  APRNewController1.h
//  APRPrestamos
//
//  Created by Albert  on 17/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "modelo.h"
@protocol APRAddViewControllerDelegate

-(void)recargar;
@end

@interface APRNewController1 : UIViewController <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate> 


@property (strong) id<APRAddViewControllerDelegate> delegado;

@property (weak, readonly) NSManagedObjectContext * contexto;

@property (weak, nonatomic) IBOutlet UITextField *txtNombre;

@property (weak, nonatomic) IBOutlet UISwitch *swchA;


@property (strong, nonatomic) IBOutlet UIPickerView *nombresPickerView;
@property (strong, nonatomic) NSMutableArray *nombresArray;
@property (strong, nonatomic) Persona *personaSeleccionada;

- (IBAction)salvar:(id)sender;

- (IBAction)cancelar:(id)sender;



@end
