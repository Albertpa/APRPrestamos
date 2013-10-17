//
//  APRDetailController1.m
//  APRPrestamos
//
//  Created by Albert  on 26/07/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import "APRAppDelegate.h"
#import "APRDetailController1.h"

@interface APRDetailController1 ()

@end


@implementation APRDetailController1
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
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = self.obRecibido.nombre;
    NSLog(@"Estado:%@", self.obRecibido.estado);
    NSLog(@"Prestado a:%@", self.obRecibido.prestadoA.nombre);
    NSLog(@"Fecha prestado:%@", self.obRecibido.diaPrestado);

    if([self.obRecibido.estado isEqualToString:@"No prestado"]){
        self.swchA.on = NO;
        self.myLabel.text = [NSString stringWithFormat:@"%@ %@", self.myLabel.text, @"No disponible"];
        
    }else{
        self.swchA.on = YES;
        self.myLabel.text = [NSString stringWithFormat:@"%@ %@", self.myLabel.text, self.obRecibido.diaPrestado];
    }
        
        
    //picker de nombres
    self.nombresArray= [NSMutableArray new];
    [self obtenerPersonas];
    nombresPickerView.showsSelectionIndicator = TRUE;


}

-(void)viewDidAppear:(BOOL)animated{
    //seleccionamos a la persona y la recuperamos si estamos editando
    
    if(self.obRecibido.prestadoA != NULL){
        NSInteger Aindex=[self.nombresArray indexOfObject:self.obRecibido.prestadoA];
        NSLog(@" %d",Aindex);    
        [nombresPickerView selectRow:Aindex inComponent:0 animated:YES];
        self.personaSeleccionada=[self.nombresArray objectAtIndex:Aindex];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cambiar:(id)sender {
    NSError         * error;
    NSLog(@"Guarda cambios");
    
    if (sender == self.swchA) {
        if(self.swchA.on == YES){
            [self.obRecibido setEstado:@"Si prestado"];
            
            //Implementamos la fecha de prestamo (hoy)
            NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
            [DateFormatter setDateFormat:@"dd-MM-yyyy hh:mm:ss"];
            [self.obRecibido setDiaPrestado:[DateFormatter stringFromDate:[NSDate date]]];
            
            if(self.personaSeleccionada != NULL){
                //Implementamos la relacion con la persona seleccionada
                NSLog(@"Persona seleccionada:%@", self.personaSeleccionada);
                [self.obRecibido setPrestadoA:self.personaSeleccionada];
                
                
                //NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
            }
            self.myLabel.text = [NSString stringWithFormat:@"%@ %@", @"Fecha: ", self.obRecibido.diaPrestado];
        }else{
            [self.obRecibido setEstado:@"No prestado"];
            [self.obRecibido setPrestadoA:NULL];
            [self.obRecibido setDiaPrestado:NULL];
            self.myLabel.text = [NSString stringWithFormat:@"%@ %@", @"Fecha: ", @"No disponible"];
        }
        //guardamos los datos modificados
        [self.contexto save:&error];
    }
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
    //simulamos que se ha modificado el switch para llamar a cambiar
    [self cambiar:self.swchA];
}



@end
