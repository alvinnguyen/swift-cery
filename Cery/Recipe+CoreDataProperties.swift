//
//  Recipe+CoreDataProperties.swift
//  Cery
//
//  Created by Alvin Nguyen on 1/11/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recipe {

    @NSManaged var photo: NSData?
    @NSManaged var name: String?
    @NSManaged var ingredients: NSSet?

}
