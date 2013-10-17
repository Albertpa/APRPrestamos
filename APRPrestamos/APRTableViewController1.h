//
//  APRViewController1.h
//  APRPrestamos
//
//  Created by Albert  on 21/07/13.
//  Copyright (c) 2013 Albert Pages. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APRAppDelegate.h"
#import "APRNewController1.h"
#import "modelo.h"

@interface APRTableViewController1 : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, APRAddViewControllerDelegate>

@property (weak,readonly) NSManagedObjectContext * contexto;
@property (strong, nonatomic) NSFetchedResultsController *frController;

@property (strong, nonatomic) NSMutableArray * resultados;

- (IBAction)addObjeto:(id)sender;

@end
