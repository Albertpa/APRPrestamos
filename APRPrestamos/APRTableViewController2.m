//
//  APRTableViewController2.m
//  APRPrestamos
//
//  Created by Albert  on 22/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import "APRTableViewController2.h"
#import "APRDetailController2.h"

@interface APRTableViewController2 ()

@end

@implementation APRTableViewController2

-(NSManagedObjectContext *)contexto{
    APRAppDelegate * app = [[UIApplication sharedApplication] delegate];
    return app.managedObjectContext;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.resultados = [NSMutableArray new];
       
    //inicilizamos el botón de eliminación
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if(tableView == self.tableView){
        return [[self.frController sections] count];
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == self.tableView){
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.frController sections][section];
        return [sectionInfo numberOfObjects];
    }else{
        return self.resultados.count;
    }
}

- (void)configurarCelda:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Persona *p = [self.frController objectAtIndexPath:indexPath];
    cell.textLabel.text = p.nombre;
    NSString *temporal;
    //NSLog(@"cuantos hay:%lu", (unsigned long)[p.tomaPrestado count]);
    
     if( [p.tomaPrestado count] > 0){
        temporal = @"Si pres.";
    }else{
        temporal = @"No pres.";

    }
     
    //NSString *string = [NSString stringWithFormat:@"%@", p.nombre, nil];

    cell.detailTextLabel.text = temporal;
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)configurarCeldaDeBusqueda:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Persona *p = [self.resultados objectAtIndex:indexPath.row];
    
    cell.textLabel.text = p.nombre;
    NSString *string = [NSString stringWithFormat:@"%@", p.nombre, nil];
    cell.detailTextLabel.text = string;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Celda";
    UITableViewCell *cell;
    
    if(tableView == self.tableView){
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [self configurarCelda:cell atIndexPath:indexPath];
        
    }else{
        cell  = [tableView cellForRowAtIndexPath:indexPath];
        if(cell == nil){
            cell = [[UITableViewCell new] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Celda"];
        }
        
        [self configurarCeldaDeBusqueda:cell atIndexPath:indexPath];
        
    }
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.frController.managedObjectContext deleteObject:[self.frController
                                                              objectAtIndexPath:indexPath]];
        NSError *error;
        if (![[self.frController managedObjectContext] save:&error]) {
            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Unresolved error %@, %@, %@", error, [error userInfo],[error localizedDescription]);
        }else{NSLog(@"Eliminar objeto");}
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     //Cuando se selecciona una celda de busqueda...
     if(tableView != self.tableView){
     UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
     APRDetalleViewController * controladordetalle = [storyboard instantiateViewControllerWithIdentifier:@"detalle"];
     
     Objeto *o = [self.resultados objectAtIndex:indexPath.row];
     //Plaza *p = [self.frControllerBusqueda objectAtIndexPath:indexPath];
     //NSLog(@"entra y es%@", p.numPlaza);
     controladordetalle.plazaDetalle = o.nombre;
     
     [self.navigationController pushViewController:controladordetalle animated:YES];
     }
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showDetail2"]){
        
        APRDetailController2 * destino = segue.destinationViewController;
        
        
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        
        Persona *p = [self.frController objectAtIndexPath:indexPath];
        //NSLog(@"entra y es%@", p.numPlaza);
        destino.pRecibida = p;
        
    }
}

#pragma mark - Métodos relacionados con NSFetchedResultsController

- (NSFetchedResultsController *)frController
{
    if (_frController == nil) {
        
        NSFetchRequest *request = [NSFetchRequest new];
        
        NSEntityDescription *entidad = [NSEntityDescription entityForName:@"Persona" inManagedObjectContext:self.contexto];
        
        request.entity = entidad;
        
        
        //recuperar los 10 elementos proximos
        request.fetchBatchSize = 10;
        
        //ordenamos por numero de plaza
        NSArray * descriptorDeOrdenacion = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]];
        
        //asignamos el orden de los elementos al FetchRequest
        [request setSortDescriptors:descriptorDeOrdenacion];
        
        //creamos el FetchRequestController haciendo uso del contexto y del request
        /*
         _frController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.contexto sectionNameKeyPath:nil cacheName:@"Listado"];
         */
        _frController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.contexto sectionNameKeyPath:nil cacheName:nil];
        
        //asignamos el delegado
        _frController.delegate = self;
        
        
        
        NSError *error = nil;
        if (![self.frController performFetch:&error]) {
            NSLog(@"Upps!! parece que hay un error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _frController;
}

//Es llamado cuando se realizarán cambios en el FetchResultController
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

//Es llamado cuando se realiza algún cambio en alguna sección:
//  -Se ha insertado una nueva seccion
//  -Se ha eliminado una sección
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

//Es llamado cuando se realiza algún cambio en algún objeto:
//  -Se ha insertado un nuevo objeto
//  -Se ha eliminado un objeto
//  -Se ha actualizado un objeto
//  -Se ha movido de posición un objeto
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    //self.tableView == self.searchDisplayController.searchResultsTableView
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configurarCelda:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

//Es llamado cuando se se han terminado de realizar los cambios en el FetchResultController
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - Métodos delegados de UISearchBarController


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString{
    
    
    [self.resultados removeAllObjects];
    NSFetchRequest *fetchRequest = [NSFetchRequest alloc];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"nombre contains[cd] %@", searchString, searchString];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"Persona" inManagedObjectContext:self.contexto];
    
    
    //ordenamos por numero de plaza
    NSArray * descriptorDeOrdenacion = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]];
    //asignamos el orden de los elementos al FetchRequest
    [fetchRequest setSortDescriptors:descriptorDeOrdenacion];
    
    
    NSError *error = nil;
    NSArray *results = [self.contexto executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Upps!! parece que hay un error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.resultados addObjectsFromArray:results];
    
    return YES;
    
}
-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
}
- (void)cambiosEnElModelo:(NSNotification *)notification
{
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (IBAction)addPersona:(id)sender{
    UIStoryboard * stb =[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    APRNewController2 * c = [stb instantiateViewControllerWithIdentifier:@"add2"];
    c.delegado = self;
    [self presentViewController:c animated:YES completion:nil];
    
}

#pragma mark - Add View Controller Delegate

-(void) recargar{
    //realmente ya esta salvado en APRNewController, aqui solo recargamos la tabla
    [self.tableView reloadData];
}


@end
