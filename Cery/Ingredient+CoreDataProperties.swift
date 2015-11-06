//
//  Ingredient+CoreDataProperties.swift
//  Cery
//
//  Created by Alvin Nguyen on 30/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ingredient {

    @NSManaged var name: String?
    @NSManaged var vendor: String?

}
