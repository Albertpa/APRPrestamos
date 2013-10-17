//
//  APRAppDelegate.m
//  APRPrestamos
//
//  Created by Albert  on 11/07/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import "APRAppDelegate.h"

@implementation APRAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //de la siguiente manera se ejecuta solo la primera vez como se ha enseñado en el curso,
    sleep(4);
    [self firstExec];
    //salva dentro del fichero de datos con saveContext, para que se guarden una vez generados
    [self saveContext];
    [self mostrarDatos];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"APRPrestamos" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"APRPrestamos.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Inicio de métodos propios

-(BOOL)firstExec{
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //Creamos la ruta del fichero de configuración
    NSString *plist = [[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"config.plist"];
    
    NSFileManager *fileManager = [NSFileManager new];
    
    //Preguntamos si el fichero esiste o no
    if (![fileManager fileExistsAtPath: plist])
    {
        //Creamos un diccionario para guardar las opciones de configuración
        NSMutableDictionary *config = [NSMutableDictionary new];
        
        //Asignamos la configuración inicial
        [config setValue:[NSNumber numberWithBool:NO] forKey:@"primeraEjecucion"];
        [config setValue:[NSNumber numberWithBool:NO] forKey:@"config1"];
        [config setValue:[NSNumber numberWithBool:NO] forKey:@"config2"];
        [config setValue:[NSNumber numberWithBool:NO] forKey:@"config3"];
        
        //Guardamos el diccionario en el archivo config.plist
        NSLog(@"Configuración: %@", config);
        [config writeToFile:plist atomically: YES];
        
        //Llamamos a los métodos de iniciación
        [self llenarModelo];
        
        
        //Es la primera ejecución del programa
        return YES;
    }
    
    //Imprimimos la configuración
    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:plist];
    NSLog(@"Configuración: %@", config);
    
    //No es la primera ejecución del programa
    return NO;
}

-(void)llenarModelo{
    
    int         x;
    int         y;
    Objeto      * objetoNuevo;
    Persona     * personaNueva;
    
    NSLog(@"Llenamos el modelo.");
 
    NSArray * nomObjetos = [NSArray arrayWithObjects: @"Queen: Greatest Hits",@"Game of Thrones",@"Spiderman #1 ",@"Back to the Future", nil];
    NSArray * nomPersonas = [NSArray arrayWithObjects: @"--No disponible--", @"Carlos",@"Marta",@"Luis",@"Carla", nil];
    NSArray * telPersonas = [NSArray arrayWithObjects: @"0000", @"1234", @"5678", @"9101", @"11213", nil];
    
    //Añadimos los objetos
    for(y = 0; y< nomObjetos.count; y++){
        
           objetoNuevo = [NSEntityDescription insertNewObjectForEntityForName:@"Objeto" inManagedObjectContext:self.managedObjectContext];
                  
            objetoNuevo.nombre =[nomObjetos objectAtIndex:y];
        
            objetoNuevo.estado = @"No prestado";
            /*
             usuario.nombre = [mujeres objectAtIndex:x];
             usuario.sexo = @"Mujer";
             usuario.edad =  18 + arc4random_uniform(30);
             usuario.a = arc4random_uniform(2);
             usuario.b = arc4random_uniform(2);
             usuario.estadoCivil = [estadoCivil objectAtIndex:arc4random_uniform(3)];
             usuario.foto = [albumMujeres objectAtIndex:x];
             */
        
    }
    
    //añadimos las personas
    for (x = 0; x< nomPersonas.count; x++) {
        
        personaNueva = [NSEntityDescription insertNewObjectForEntityForName:@"Persona" inManagedObjectContext:self.managedObjectContext];
        personaNueva.nombre =[nomPersonas objectAtIndex:x];
        
        personaNueva.telefono = [telPersonas objectAtIndex:x];
        personaNueva.tomaPrestado = NULL;
    }
    
    [self saveContext];
    
}

-(void) mostrarDatos{
    
    NSFetchRequest * busquedaObjetos = [ [NSFetchRequest alloc] initWithEntityName:@"Objeto"];
    
    //Aqui, se puede ordenar
    NSArray * descriptorDeOrdenacion = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]];
    
    //Recorremos
    NSArray * objetosActuales = [self.managedObjectContext executeFetchRequest:busquedaObjetos error:nil];
    objetosActuales = [objetosActuales sortedArrayUsingDescriptors:descriptorDeOrdenacion];
    
    for (Objeto * o in objetosActuales) {
        NSLog(@"======= %@ =======", o.nombre);
        
    }
    //mostramos por consola
    
    NSFetchRequest * busquedaPersonas = [ [NSFetchRequest alloc] initWithEntityName:@"Persona"];
    
    //Recorremos
    NSArray * personasActuales = [self.managedObjectContext executeFetchRequest:busquedaPersonas error:nil];
    personasActuales = [personasActuales sortedArrayUsingDescriptors:descriptorDeOrdenacion];
    
    for (Persona * p in personasActuales) {
        NSLog(@"======= %@ ===== %@ ==========", p.nombre, p.telefono);
        
    }
    //mostramos por consola
    
    
}



@end
