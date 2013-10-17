//
//  APRDetailController2.m
//  APRPrestamos
//
//  Created by Albert  on 27/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//


#import "APRDetailController2.h"

@interface APRDetailController2 ()

@end

@implementation APRDetailController2


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
     self.navigationItem.title = self.pRecibida.nombre;
     self.txtTelefono.text = self.pRecibida.telefono;
     self.txtObjetos.numberOfLines = 0;
    
    NSSet *aChecklistSet = [[NSSet alloc]initWithSet:self.pRecibida.tomaPrestado];
    NSString * temporal = @"";
    self.txtObjetos.text = @"";
    
    for(Objeto * or in aChecklistSet){
        // NSLog(@"Checklist Name: %@", or.nombre);
        temporal = [NSString stringWithFormat:@"%@> %@\n", temporal, or.nombre];
    }
    self.txtObjetos.text = temporal;
    
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
