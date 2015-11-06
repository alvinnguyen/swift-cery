//
//  IngredientNewViewController.swift
//  Cery
//
//  Created by Alvin Nguyen on 1/11/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit
import CoreData

class IngredientNewViewController: UIViewController {

    @IBOutlet weak var ingredientSellerTextField: UITextField!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(animated: Bool) {
        self.title = "New Ingredient"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "ingredients_navigation"), forBarMetrics: .Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: ingredientNameTextField.frame.size.height - width, width:  ingredientNameTextField.frame.size.width, height: ingredientNameTextField.frame.size.height)
        border.borderWidth = width
        ingredientNameTextField.layer.addSublayer(border)
        ingredientNameTextField.layer.masksToBounds = true
        let border2 = CALayer()
        border2.borderColor = UIColor.darkGrayColor().CGColor
        border2.frame = CGRect(x: 0, y: ingredientSellerTextField.frame.size.height - width, width:  ingredientSellerTextField.frame.size.width, height: ingredientSellerTextField.frame.size.height)
        border2.borderWidth = width
        ingredientSellerTextField.layer.addSublayer(border2)
        ingredientSellerTextField.layer.masksToBounds = true
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveIngredientSegue" {
            let entity = NSEntityDescription.entityForName("Ingredient", inManagedObjectContext: managedContext)
            let ingredient = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            ingredient.setValue(ingredientNameTextField.text, forKey: "name")
            ingredient.setValue(ingredientSellerTextField.text, forKey: "vendor")

            // Save managed context
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch \(error)")
            }
        }
    }

}
