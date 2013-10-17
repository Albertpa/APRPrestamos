//
//  APRDetailController2.h
//  APRPrestamos
//
//  Created by Albert  on 27/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "modelo.h"

@interface APRDetailController2 : UIViewController

@property Persona *pRecibida;

@property (weak, nonatomic) IBOutlet UILabel *txtTelefono;

@property (weak, nonatomic) IBOutlet UILabel *txtObjetos;

@property (strong, nonatomic) NSMutableArray *nombresArray;


@end
