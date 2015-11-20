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
    var recipeIngredient: UILabel!
    var recipeMarket: UILabel!
    var recipe: Recipe!
    var addTextView: UILabel!
    var recipeDelete: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        recipeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height-100))
        recipeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        recipeImageView.clipsToBounds = true
        self.addSubview(recipeImageView)
        
        recipeName = UILabel(frame: CGRect(x: 0, y: frame.size.height-100, width: frame.size.width, height: 50))
        recipeName.backgroundColor = UIColor(red: 288, green: 288, blue: 288, alpha: 1)
        recipeName.textColor = UIColor.blackColor()
        recipeName.textAlignment = NSTextAlignment.Center
        recipeName.font = UIFont.boldSystemFontOfSize(18.00)
        self.addSubview(recipeName)

        recipeIngredient = UILabel(frame: CGRect(x: 40, y: frame.size.height-81, width: frame.size.width-20, height: 56))
        recipeIngredient.textColor = UIColor.blackColor()
        recipeIngredient.textAlignment = NSTextAlignment.Justified
        recipeIngredient.numberOfLines = 0
        // self.addSubview(recipeIngredient)

        recipeMarket = UILabel(frame: CGRect(x: 40, y: frame.size.height-55, width: frame.size.width-20, height: 56))
        recipeMarket.textColor = UIColor.blackColor()
        recipeMarket.textAlignment = NSTextAlignment.Justified
        recipeMarket.numberOfLines = 0
        //self.addSubview(recipeMarket)

        
        // TODO: first cell add
        // addTextView = UILabel(frame: CGRect(x: frame.size.width-50, y: 0, width: 50, height: frame.size.height))
        // addTextView.backgroundColor = UIColor.blackColor()
        // self.addSubview(addTextView)
        
        let ingredientIcon = UILabel(frame: CGRect(x: 15, y: frame.height - 59, width: 100, height: 100))
        ingredientIcon.font = UIFont.fontAwesomeOfSize(14)
        ingredientIcon.text = String.fontAwesomeIconWithCode("fa-cutlery")
        ingredientIcon.sizeToFit()
        // self.addSubview(ingredientIcon)

        let marketIcon = UILabel(frame: CGRect(x: 15, y: frame.height - 34, width: 100, height: 100))
        marketIcon.font = UIFont.fontAwesomeOfSize(14)
        marketIcon.text = String.fontAwesomeIconWithCode("fa-map-marker")
        marketIcon.sizeToFit()
        // self.addSubview(marketIcon)

        recipeDelete = UIButton(frame: CGRect(x: 0, y: frame.height - 50, width: frame.width/2, height: 50))
        recipeDelete.titleLabel?.font = UIFont.fontAwesomeOfSize(20)
        recipeDelete.setTitle(String.fontAwesomeIconWithName(.TrashO), forState: .Normal)
        recipeDelete.setTitleColor(UIColor(red: 218/255, green: 62/255, blue: 82/255, alpha: 1), forState: .Normal)
        // recipeDelete.backgroundColor = UIColor(red: 218/255, green: 62/255, blue: 82/255, alpha: 1)
        // recipeDelete.backgroundColor = UIColor(red: 224/255, green: 82/255, blue: 99/255, alpha: 1)
        // recipeDelete.sizeToFit()
        // recipeDelete.layer.borderWidth = 1.0
        // recipeDelete.layer.borderColor = UIColor.blackColor().CGColor
        // recipeDelete.layer.cornerRadius = 5.0
        let recipeDeleteTopBorder:CALayer = CALayer()
        recipeDeleteTopBorder.frame = CGRectMake(0, 0, recipeDelete.frame.size.width, 1)
        recipeDeleteTopBorder.backgroundColor = UIColor(red: 218/255, green: 62/255, blue: 82/255, alpha: 1).CGColor
        recipeDelete.layer.addSublayer(recipeDeleteTopBorder)
        self.addSubview(recipeDelete)

        let recipeEdit = UIButton(frame: CGRect(x: 0, y: frame.height - 38, width: frame.width/3, height: 38))
        recipeEdit.titleLabel?.font = UIFont.fontAwesomeOfSize(16)
        recipeEdit.setTitle(String.fontAwesomeIconWithName(.PencilSquareO), forState: .Normal)
        recipeEdit.setTitleColor(UIColor(red: 163/255, green: 217/255, blue: 255/255, alpha: 1), forState: .Normal)
        // recipeEdit.backgroundColor = UIColor(red: 163/255, green: 217/255, blue: 255/255, alpha: 1)
        // recipeEdit.backgroundColor = UIColor(red: 105/255, green: 162/255, blue: 176/255, alpha: 1)
        // self.addSubview(recipeEdit)

        let recipeFav = UIButton(frame: CGRect(x: frame.width/2, y: frame.height - 50, width: frame.width/2, height: 50))
        recipeFav.titleLabel?.font = UIFont.fontAwesomeOfSize(20)
        recipeFav.setTitle(String.fontAwesomeIconWithName(.ShoppingCart), forState: .Normal)
        recipeFav.setTitleColor(UIColor(red: 150/255, green: 230/255, blue: 179/255, alpha: 1), forState: .Normal)
        let recipeFavTopBorder:CALayer = CALayer()
        recipeFavTopBorder.frame = CGRectMake(0, 0, recipeFav.frame.size.width, 1)
        recipeFavTopBorder.backgroundColor = UIColor(red: 150/255, green: 230/255, blue: 179/255, alpha: 1).CGColor
        recipeFav.layer.addSublayer(recipeFavTopBorder)

        // recipeFav.backgroundColor = UIColor(red: 150/255, green: 230/255, blue: 179/255, alpha: 1)
        // recipeFav.backgroundColor = UIColor(red: 101/255, green: 145/255, blue: 87/255, alpha: 1)
        self.addSubview(recipeFav)

        
        self.backgroundColor = UIColor.whiteColor()
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
