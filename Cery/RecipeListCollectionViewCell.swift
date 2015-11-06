//
//  RecipeListCollectionViewCell.swift
//  Cery
//
//  Created by Alvin Nguyen on 4/11/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit

class RecipeListCollectionViewCell: UICollectionViewCell {
    
    var recipeImageView: UIImageView!
    var recipeName: UILabel!
    var recipe: Recipe!
    var addTextView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        recipeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        recipeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        recipeImageView.clipsToBounds = true
        self.addSubview(recipeImageView)
        
        recipeName = UILabel(frame: CGRect(x: 0, y: frame.size.height-50, width: frame.size.width, height: 50))
        recipeName.backgroundColor = UIColor(red: 288, green: 288, blue: 288, alpha: 1)
        recipeName.textColor = UIColor.blackColor()
        recipeName.textAlignment = NSTextAlignment.Center
        self.addSubview(recipeName)
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        print("run")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override var bounds : CGRect {
//        didSet {
//            // Fix autolayout constraints broken in Xcode 6 GM + iOS 7.1
//            self.contentView.frame = bounds
//        }
//    }
}
