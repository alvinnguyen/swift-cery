//
//  Recipe.swift
//  Cery
//
//  Created by Alvin Nguyen on 27/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var name: String
    var ingredients: [Ingredient]
    
    init(name: String, ingredients: [Ingredient]){
        self.name = name
        self.ingredients = ingredients
    }
}
