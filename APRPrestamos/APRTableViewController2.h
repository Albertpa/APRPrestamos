//
//  APRTableViewController2.h
//  APRPrestamos
//
//  Created by Albert  on 22/08/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APRAppDelegate.h"
#import "APRNewController2.h"
#import "modelo.h"

@interface APRTableViewController2 : UITableViewController<NSFetchedResultsControllerDelegate, UISearchBarDelegate>

@property (weak,readonly) NSManagedObjectContext * contexto;
@property (strong, nonatomic) NSFetchedResultsController *frController;

@property (strong, nonatomic) NSMutableArray * resultados;

- (IBAction)addPersona:(id)sender;

@end
