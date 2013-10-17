//
//  APRDetailController1.h
//  APRPrestamos
//
//  Created by Albert  on 26/07/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "modelo.h"

@interface APRDetailController1 : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, readonly) NSManagedObjectContext * contexto;
@property Objeto *obRecibido;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property (weak, nonatomic) IBOutlet UISwitch *swchA;

@property (strong, nonatomic) IBOutlet UIPickerView *nombresPickerView;
@property (strong, nonatomic) NSMutableArray *nombresArray;
@property (strong, nonatomic) Persona *personaSeleccionada;


- (IBAction)cambiar:(id)sender;

@end
