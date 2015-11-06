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
    
    @IBOutlet weak var receipeButton: UIButton!

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
        let topBorder:CALayer = CALayer()
        topBorder.frame = CGRectMake(0, 0, (receipeButton.frame.size.width/2), 1)
        topBorder.backgroundColor = UIColor(white: 1.0, alpha: 0.7).CGColor
        let bottomBorder:CALayer = CALayer()
        bottomBorder.frame = CGRectMake(0, receipeButton.frame.size.height, (receipeButton.frame.size.width/2), 1)
        bottomBorder.backgroundColor = UIColor(white: 1.0, alpha: 0.7).CGColor
        receipeButton.layer.addSublayer(topBorder)
        receipeButton.layer.addSublayer(bottomBorder)
        
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
