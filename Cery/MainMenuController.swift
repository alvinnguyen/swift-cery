//
//  MainMenuController.swift
//  Cery
//
//  Created by Alvin Nguyen on 22/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit
import CoreData

class MainMenuController: UIViewController {
    
    let screenSize:CGRect = UIScreen.mainScreen().bounds

    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap = UITapGestureRecognizer(target: self, action: Selector("routeRecipes"))
//        recipesTouch.addGestureRecognizer(tap)
//        recipesTouch.userInteractionEnabled = true
//
//        tap = UITapGestureRecognizer(target: self, action: Selector("routeIngredients"))
//        ingredientsTouch.addGestureRecognizer(tap)
//        ingredientsTouch.userInteractionEnabled = true
//
//        tap = UITapGestureRecognizer(target: self, action: Selector("routeGrocery"))
//        groceryTouch.addGestureRecognizer(tap)
//        groceryTouch.userInteractionEnabled = true
        
        // Do any additional setup after loading the view.
        
        let recipeLegacyButton = UIButton(frame: CGRect(x: 20, y: screenSize.height-20-50, width: screenSize.width-40, height: 50));
        recipeLegacyButton.backgroundColor = UIColor.clearColor()
        recipeLegacyButton.setTitle("Recipe Table View", forState: .Normal)
        recipeLegacyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let topBorder:CALayer = CALayer()
        topBorder.frame = CGRectMake(0, 0, recipeLegacyButton.frame.size.width, 1)
        topBorder.backgroundColor = UIColor(white: 1.0, alpha: 0.7).CGColor
        let bottomBorder:CALayer = CALayer()
        bottomBorder.frame = CGRectMake(0, recipeLegacyButton.frame.size.height, (recipeLegacyButton.frame.size.width), 1)
        bottomBorder.backgroundColor = UIColor(white: 1.0, alpha: 0.7).CGColor
        recipeLegacyButton.layer.addSublayer(topBorder)
        recipeLegacyButton.layer.addSublayer(bottomBorder)
        recipeLegacyButton.addTarget(self, action: "routeRecipes", forControlEvents: .TouchUpInside)
        self.view.addSubview(recipeLegacyButton)
        
        let recipeButton = UIButton(frame: CGRect(x: 20, y: screenSize.height-20-50-20-50, width: screenSize.width-40, height: 50));
        recipeButton.backgroundColor = UIColor.clearColor()
        recipeButton.setTitle("Recipe Card View", forState: .Normal)
        recipeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let topBorder2:CALayer = CALayer()
        topBorder2.frame = CGRectMake(0, 0, recipeLegacyButton.frame.size.width, 1)
        topBorder2.backgroundColor = UIColor(white: 1.0, alpha: 0.7).CGColor
        let bottomBorder2:CALayer = CALayer()
        bottomBorder2.frame = CGRectMake(0, recipeLegacyButton.frame.size.height, (recipeLegacyButton.frame.size.width), 1)
        bottomBorder2.backgroundColor = UIColor(white: 1.0, alpha: 0.7).CGColor
        recipeButton.layer.addSublayer(topBorder2)
        recipeButton.layer.addSublayer(bottomBorder2)
        recipeButton.addTarget(self, action: "routeRecipesCollection", forControlEvents: .TouchUpInside)
        self.view.addSubview(recipeButton)
        
        // Load dummy data
        // self.loadDummyData()
    }
    
    func loadDummyData() {
        // Let's fetch
        do {
            let fetchRequest = NSFetchRequest(entityName: "Ingredient")
            let results = try managedContext.executeFetchRequest(fetchRequest)
            if results.count == 0 {
                Ingredient.createInManagedObjectContext(managedContext, name: "Onion", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Oil", vendor: "Coles")
                Ingredient.createInManagedObjectContext(managedContext, name: "Pasta", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Tomato", vendor: "Coles")
                Ingredient.createInManagedObjectContext(managedContext, name: "Vegetable", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Apple", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Mandarine", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Eggs", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Salt", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Chicken Stock", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Beef", vendor: "Springvale")
                Ingredient.createInManagedObjectContext(managedContext, name: "Fish", vendor: "Springvale")
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: animated)        
    }

    func routeRecipesCollection() {
        let recipeListViewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("RecipesListViewControllerIdentifier") as? RecipeListViewController
        self.navigationController?.pushViewController(recipeListViewControllerObject!, animated: true)
    }
    
    func routeRecipes() {
        let mapViewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("RecipesViewControllerIdentifier") as? RecipesViewController
        self.navigationController?.pushViewController(mapViewControllerObject!, animated: true)
    }

    func routeIngredients() {
        let mapViewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("IngredientsViewControllerIdentifier") as? IngredientsViewController
        self.navigationController?.pushViewController(mapViewControllerObject!, animated: true)
    }

    func routeGrocery() {
        let mapViewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("GroceryViewControllerIdentifier") as? GroceryViewController
        self.navigationController?.pushViewController(mapViewControllerObject!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
