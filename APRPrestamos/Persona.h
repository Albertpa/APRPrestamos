//
//  Persona.h
//  APRPrestamos
//
//  Created by Albert  on 28/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Objeto;

@interface Persona : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * telefono;
@property (nonatomic, retain) NSSet *tomaPrestado;
@end

@interface Persona (CoreDataGeneratedAccessors)

- (void)addTomaPrestadoObject:(Objeto *)value;
- (void)removeTomaPrestadoObject:(Objeto *)value;
- (void)addTomaPrestado:(NSSet *)values;
- (void)removeTomaPrestado:(NSSet *)values;

@end
