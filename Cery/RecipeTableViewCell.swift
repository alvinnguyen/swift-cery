//
//  RecipeTableViewCell.swift
//  Cery
//
//  Created by Alvin Nguyen on 1/11/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {


    @IBOutlet weak var recipeImageView: UIImageView!    
    @IBOutlet weak var recipeNameTextLabel: UILabel!
    @IBOutlet weak var ingredientDescriptionTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutMargins = UIEdgeInsetsZero //or UIEdgeInsetsMake(top, left, bottom, right)
        //self.separatorInset = UIEdgeInsetsZero //if you also want to adjust separatorInset
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
