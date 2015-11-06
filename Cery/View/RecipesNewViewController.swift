//
//  RecipesNewViewController.swift
//  Cery
//
//  Created by Alvin Nguyen on 27/10/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit
import CoreData

class RecipesNewViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var RecipeNameTextField: UITextField!
    @IBOutlet weak var IngredientTableView: UITableView!
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var newIngredientButton: UIButton!
    
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var ingredients: [NSManagedObject] = []
    
    var selectedRecipe: NSManagedObject!
    var uploadedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config Recipe image
        var tap = UITapGestureRecognizer(target: self, action: Selector("selectRecipePhoto"))
        RecipeImage.addGestureRecognizer(tap)
        
        // Config Recipe image
        tap = UITapGestureRecognizer(target: self, action: Selector("selectRecipePhoto"))
        RecipeImage.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "New Recipe"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "recipes_navigation"), forBarMetrics: .Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        // fetching and showing available ingredients
        // including new ones just got added
        do {
            let fetchRequest = NSFetchRequest(entityName: "Ingredient")
            let results = try managedContext.executeFetchRequest(fetchRequest)
            ingredients = results as! [NSManagedObject]
            ingredients = ingredients.sort({
                String($0.valueForKey("name")) < String($1.valueForKey("name"))
            })
            IngredientTableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        
        if selectedRecipe != nil {
            // Showing selected ingredient from the managed object
            // selectedIngredientIndex.removeAll()
            let _recipe = selectedRecipe as! Recipe
            self.RecipeNameTextField.text = _recipe.name
            for index in _recipe.ingredients! {
                let indexPath = NSIndexPath(forRow: ingredients.indexOf(index as! NSManagedObject)!, inSection: 0)
                IngredientTableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
                // selectedIngredientIndex.append(indexPath.row)
            }
            if _recipe.photo != nil && uploadedImage == nil {
                self.RecipeImage.image = UIImage.init(data: _recipe.photo!)                
            }
        } else {
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: managedContext)
            selectedRecipe = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Recipe;
        }
        
        // print(selectedIngredientIndex)
        
        // Scroll table view to top
        IngredientTableView.setContentOffset(CGPointZero, animated:true)
    }

    @IBAction func saveNewIngredient(seque: UIStoryboardSegue){
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if (self.isMovingFromParentViewController()) {
            managedContext.refreshObject(selectedRecipe, mergeChanges: false)
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Ingredient Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let ingredient = ingredients[indexPath.row] as! Ingredient
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        let separator = UIView(frame: CGRectMake(0, cell.frame.size.height - 0.5, cell.frame.size.width, 0.5));
        let selectedSeparator = UIView(frame: separator.frame)
        selectedSeparator.backgroundColor = UIColor.lightGrayColor()
        separator.backgroundColor = UIColor.lightGrayColor()
        let bgColorView = UIView(frame: cell.frame)
        bgColorView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        bgColorView.addSubview(selectedSeparator)
        cell.selectedBackgroundView = bgColorView
//        let separator = UIView(frame: CGRectMake(0, cell.frame.size.height + 1, self.view.frame.size.width, 1));
        (cell.contentView.viewWithTag(100) as! UILabel).text = ingredient.name
        (cell.contentView.viewWithTag(101) as! UILabel).text = ingredient.vendor
        cell.addSubview(separator)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRecipe.mutableSetValueForKey("ingredients").addObject(ingredients[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRecipe.mutableSetValueForKey("ingredients").removeObject(ingredients[indexPath.row])
    }
    
    
    func selectRecipePhoto() {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.RecipeImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.uploadedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(false, completion: nil)
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
            
            if selectedRecipe.valueForKey("ingredients")!.count == 0 {
                let alert = UIAlertController(title: "Missing information", message: "Isn't it a bit hard to cook without ingredients?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Oh right", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return false
            }
        }
        
        // by default perform the segue transitio
        return true
    }
    
    func scaleImage(image:UIImage,  toSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(toSize, false, 0.0);
        
        let aspectRatioAwareSize = self.aspectRatioAwareSize(image.size, boxSize: toSize, useLetterBox: false)
        
        
        let leftMargin = (toSize.width - aspectRatioAwareSize.width) * 0.5
        let topMargin = (toSize.height - aspectRatioAwareSize.height) * 0.5
        
        
        image.drawInRect(CGRectMake(leftMargin, topMargin, aspectRatioAwareSize.width , aspectRatioAwareSize.height))
        let retVal = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retVal
    }
    
    func aspectRatioAwareSize(imageSize: CGSize, boxSize: CGSize, useLetterBox: Bool) -> CGSize {
        // aspect ratio aware size
        // http://stackoverflow.com/a/6565988/8047
        let wi = imageSize.width
        let hi = imageSize.height
        let ws = boxSize.width
        let hs = boxSize.height
        
        let ri = wi/hi
        let rs = ws/hs
        
        let retVal : CGSize
        // use the else at your own risk: it seems to work, but I don't know
        // the math
        if (useLetterBox) {
            retVal = rs > ri ? CGSizeMake(wi * hs / hi, hs) : CGSizeMake(ws, hi * ws / wi)
        } else {
            retVal = rs < ri ? CGSizeMake(wi * hs / hi, hs) : CGSizeMake(ws, hi * ws / wi)
        }
        
        return retVal
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveRecipeSegue" {
            selectedRecipe.setValue(self.RecipeNameTextField.text, forKey: "name")

            // set the image
            if self.uploadedImage != nil {
                selectedRecipe.setValue(UIImageJPEGRepresentation(self.scaleImage(self.uploadedImage, toSize: CGSize(width: 600, height: 800)), 1), forKey: "photo")
            }
            
            // Save managed context
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch \(error)")
            }
        }
    }
}
