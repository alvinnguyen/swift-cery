//
//  MainMenuController.swift
//  Cery
//
//  Created by Alvin Nguyen on 22/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {

    @IBOutlet weak var recipesTouch: UIImageView!
    @IBOutlet weak var ingredientsTouch: UIImageView!
    @IBOutlet weak var groceryTouch: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap = UITapGestureRecognizer(target: self, action: Selector("routeRecipes"))
        recipesTouch.addGestureRecognizer(tap)
        recipesTouch.userInteractionEnabled = true

        tap = UITapGestureRecognizer(target: self, action: Selector("routeIngredients"))
        ingredientsTouch.addGestureRecognizer(tap)
        ingredientsTouch.userInteractionEnabled = true

        tap = UITapGestureRecognizer(target: self, action: Selector("routeGrocery"))
        groceryTouch.addGestureRecognizer(tap)
        groceryTouch.userInteractionEnabled = true

        
        // Do any additional setup after loading the view.
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
