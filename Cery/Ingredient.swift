//
//  Ingredient.swift
//  Cery
//
//  Created by Alvin Nguyen on 30/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import Foundation
import CoreData


class Ingredient: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, vendor: String) -> Ingredient {
        let newIngredient = NSEntityDescription.insertNewObjectForEntityForName("Ingredient", inManagedObjectContext: moc) as! Ingredient
        newIngredient.name = name
        newIngredient.vendor = vendor
        return newIngredient
    }
}
