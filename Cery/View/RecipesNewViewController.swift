//
//  RecipesNewViewController.swift
//  Cery
//
//  Created by Alvin Nguyen on 27/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit

class RecipesNewViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {

    @IBOutlet weak var RecipeNameTextField: UITextField!
    @IBOutlet weak var IngredientTableView: UITableView!
    
    var ingredients: [Ingredient] = [
            Ingredient.init(aName: "Onion", aVendor: "Springvale"),
            Ingredient.init(aName: "Oil", aVendor: "Coles"),
            Ingredient.init(aName: "Pasta", aVendor: "Springvale"),
            Ingredient.init(aName: "Tomato", aVendor: "Coles"),
            Ingredient.init(aName: "Vegetable", aVendor: "Springvale"),
            Ingredient.init(aName: "Apple", aVendor: "Springvale"),
            Ingredient.init(aName: "Madarine", aVendor: "Springvale"),
            Ingredient.init(aName: "Eggs", aVendor: "Springvale"),
    ]
    var selectedIngredientIndex: [Int] = []
    var recipeName: String = ""
    var preselectedIngredients: [Ingredient] = []
    var recipeId: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ingredients = ingredients.sort({$0.name < $1.name})
        RecipeNameTextField.text = recipeName
        if preselectedIngredients.count > 0 {
            for ingredient in preselectedIngredients {
                let selectedIndex = ingredients.indexOf({$0.name == ingredient.name && $0.vendor == ingredient.vendor})
                selectedIngredientIndex.append(selectedIndex!)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        for index in selectedIngredientIndex {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            IngredientTableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredients.count
    }
    
    func scrollViewWillBeginDragging(activeScrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Ingredient Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let ingredient = ingredients[indexPath.row]
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        cell.selectedBackgroundView = bgColorView
        (cell.contentView.viewWithTag(100) as! UILabel).text = ingredient.name
        (cell.contentView.viewWithTag(101) as! UILabel).text = ingredient.vendor
        return cell
    }
    
    /**
     Row selected, add background color
     and add the selected index to the array
     
     - parameter tableView:
     - parameter indexPath:
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        //tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        selectedIngredientIndex.append(indexPath.row)
        print(selectedIngredientIndex)
    }
    
    /**
     Row de-selected, remove background color
     and pop the selected index from the array
     
     - parameter tableView:
     - parameter indexPath:
     */
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = .clearColor()
        selectedIngredientIndex = selectedIngredientIndex.filter(){
            $0 != indexPath.row
        }
        print(selectedIngredientIndex)
    }
    
//    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.contentView.backgroundColor = UIColor.orangeColor()
//        cell?.backgroundColor = UIColor.orangeColor()
//    }
//    
//    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.contentView.backgroundColor = UIColor.blackColor()
//        cell?.backgroundColor = UIColor.blackColor()
//    }
    
    /**
     Set the view data coming from clicking
     on recipe view controller table cell
     
     - parameter recipeName:     the origin recipe name
     - parameter ingredientList: the list of recipe's ingredient
     */
    func populateViewData (recipeId: Int, recipeName: String, ingredientList: [Ingredient]) {
        //RecipeNameTextField.text = recipeName
        self.recipeId = recipeId
        self.recipeName = recipeName
        self.preselectedIngredients = ingredientList
    }

    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: RecipeNameTextField.frame.size.height - width, width:  RecipeNameTextField.frame.size.width, height: RecipeNameTextField.frame.size.height)
        border.borderWidth = width
        RecipeNameTextField.layer.addSublayer(border)
        RecipeNameTextField.layer.masksToBounds = true
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        NSLog(identifier)
        if identifier == "saveRecipeSegue" {
            // perform your computation to determine whether segue should occur
            if RecipeNameTextField.text == "" {
                let alert = UIAlertController(title: "Missing information", message: "Please input your receipe's name", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Understood", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return false
            }
        }
        
        // by default perform the segue transitio
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // TODO: since this only has one possible segue, lacking on checking identifier
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let recipesViewController = segue.destinationViewController as! RecipesViewController
        // Generate the ingredient list
        var ingredientList: [Ingredient] = []
        for index in selectedIngredientIndex {
            ingredientList.append(ingredients[index])
        }
        if recipeId != nil {
            recipesViewController.modifyRecipe(recipeId!, name: (RecipeNameTextField.text)!, ingredients: ingredientList);
        } else {
            recipesViewController.addNewRecipe((RecipeNameTextField.text)!, ingredients: ingredientList);
        }
    }
}
