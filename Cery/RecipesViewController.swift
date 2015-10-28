//
//  RecipesViewController.swift
//  Cery
//
//  Created by Alvin Nguyen on 23/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.barTintColor = UIColor.greenColor()

        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 50.0/255, green: 150.0/255, blue: 65.0/255, alpha: 1.0)
        self.title = "Recipes"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "recipes_navigation"), forBarMetrics: .Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNewRecipe(seque: UIStoryboardSegue){
        
    }
    
    /**
     Adding new recipe into the array
     
     - parameter name:        recipe name
     - parameter ingredients: array of ingredients
     */
    func addNewRecipe(name: String, ingredients: [Ingredient]) {
        recipes.append(Recipe(name: name, ingredients: ingredients));
        self.tableView.reloadData()
    }
    
    func modifyRecipe(recipeId: Int, name: String, ingredients: [Ingredient]) {
        recipes[recipeId] = Recipe(name: name, ingredients: ingredients);
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Recipe Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        cell.detailTextLabel?.text = String(recipe.ingredients.count)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            recipes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "recipeEdit" {
            let recipeNewViewController = segue.destinationViewController as! RecipesNewViewController
            let selectedIndex = self.tableView.indexPathForSelectedRow?.row
            let recipe = recipes[selectedIndex!]
            recipeNewViewController.populateViewData(selectedIndex!, recipeName: recipe.name, ingredientList: recipe.ingredients)
        }
    }

}
