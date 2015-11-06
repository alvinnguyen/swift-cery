//
//  Ingredient.swift
//  Cery
//
//  Created by Alvin Nguyen on 27/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit

class IngredientModel: NSObject {
    var name: String
    var vendor: String
    
    init(aName: String, aVendor: String) {
        name = aName
        vendor = aVendor
    }
}