//
//  Objeto.h
//  APRPrestamos
//
//  Created by Albert  on 28/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Persona;

@interface Objeto : NSManagedObject

@property (nonatomic, retain) NSString * diaPrestado;
@property (nonatomic, retain) NSString * estado;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) Persona *prestadoA;

@end
