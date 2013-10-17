//
//  APRNewController1.m
//  APRPrestamos
//
//  Created by Albert  on 17/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import "APRAppDelegate.h"
#import "APRNewController1.h"

@interface APRNewController1 ()

@end

@implementation APRNewController1
@synthesize nombresPickerView;


-(NSManagedObjectContext *)contexto{
    APRAppDelegate * app = [[UIApplication sharedApplication] delegate];
    return app.managedObjectContext;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //picker de nombres
    self.nombresArray= [NSMutableArray new];
    [self obtenerPersonas];
    nombresPickerView.showsSelectionIndicator = TRUE;


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)salvar:(id)sender {
     NSError         * error;
    
    Objeto * o = [NSEntityDescription insertNewObjectForEntityForName:@"Objeto" inManagedObjectContext:self.contexto];
    [o setNombre:self.txtNombre.text];
    
    //Faltan el switch de prestado o no, y si lo esta la persona y la fecha
   
        if(self.swchA.on == YES){
            [o setEstado:@"Si prestado"];
            [o setPrestadoA:self.personaSeleccionada];
             //Implementamos la fecha de prestamo (hoy)
            NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
            [DateFormatter setDateFormat:@"dd-MM-yyyy hh:mm:ss"];
            [o setDiaPrestado:[DateFormatter stringFromDate:[NSDate date]]];
            //NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
            
        }else{
            [o setEstado:@"No prestado"];
            [o setPrestadoA:NULL];
            [o setDiaPrestado:NULL];
        }
    
    [self.contexto save:&error];
    
    
    //llamamos al metodo delegado que recargue la tabla
    [self.delegado recargar];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelar:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) obtenerPersonas{
    
    [self.nombresArray removeAllObjects];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest alloc];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"Persona" inManagedObjectContext:self.contexto];
    
    
    //recuperar los 10 elementos proximos
    fetchRequest.fetchBatchSize = 10;
    
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
    
    [self.nombresArray addObjectsFromArray:results];
    
}

#pragma mark - metodos para el picker de nombres

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.nombresArray count];
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    Persona *p;
    p = [self.nombresArray objectAtIndex:row];
    return p.nombre;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.personaSeleccionada=[self.nombresArray objectAtIndex:row];
    
}

@end
