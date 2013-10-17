//
//  APRNewController2.m
//  APRPrestamos
//
//  Created by Albert  on 22/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import "APRNewController2.h"
#import "APRAppDelegate.h"

@interface APRNewController2 ()

@end

@implementation APRNewController2

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)salvar:(id)sender {
    NSError         * error;
    
    Persona * p = [NSEntityDescription insertNewObjectForEntityForName:@"Persona" inManagedObjectContext:self.contexto];
    [p setNombre:self.txtNombre.text];
    [p setTelefono:self.txtTelefono.text];
    [p setTomaPrestado:NULL];
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


@end
