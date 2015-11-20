//
//  RecipeListViewController.swift
//  Cery
//
//  Created by Alvin Nguyen on 3/11/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift

class RecipeListViewController: UIViewController {
    
    var screenSize:CGRect = UIScreen.mainScreen().bounds
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var collectionView: UICollectionView!
    var recipes = [NSManagedObject]()
    var cachedImage = [UIImage]()
    var currentOffset: CGFloat!
    
    private struct Storyboard {
        static let CellIdentifier = "Recipe Cell"
    }
    
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTapped")

        
        // Screen and layout
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        print([screenWidth, screenHeight])
        
        self.view.clipsToBounds = true

        // Setup background image
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "main_storyboard_background")
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .ScaleAspectFill
        self.view.addSubview(backgroundImageView)
        
        // Setup blur view over the background image
        let effect: UIBlurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(frame: self.view.frame)
        blurEffectView.effect = effect
        self.view.addSubview(blurEffectView)
        
        // Setup collection view
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .Horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = screenWidth*0.025
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: screenWidth*0.075, bottom: 0, right: screenWidth*0.075)
        
        // TODO: Left most card
        // self.collectionView = UICollectionView(frame: CGRect(x: -self.screenWidth*0.85, y: 30, width: screenWidth+self.screenWidth*0.85, height: screenHeight-30), collectionViewLayout: collectionViewLayout)

        self.loadCoreData()
        // Setup collection view cell and view
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: self.screenWidth, height: screenHeight-30), collectionViewLayout: collectionViewLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.decelerationRate = 0.8
        self.collectionView.registerClass(RecipeListCollectionViewCell.self, forCellWithReuseIdentifier: Storyboard.CellIdentifier)
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        // transparent navigation bar
        self.title = "My Recipe"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func loadCoreData() {
        // fetching and showing available recipes
        do {
            print("fetching recipes")
            let fetchRequest = NSFetchRequest(entityName: "Recipe")
            let results = try managedContext.executeFetchRequest(fetchRequest)
            recipes = results as! [NSManagedObject]
            cachedImage.removeAll()
            for recipe in recipes {
                cachedImage.append(UIImage(data: (recipe as! Recipe).photo!)!)
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }

    }
    
    // Function new navigation tapped
    func addTapped() {
        let recipeNewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecipesNewViewController") as! RecipesNewViewController
        self.navigationController?.pushViewController(recipeNewViewController, animated: true)
        print("Add button tapped")
    }
    
    @IBAction func saveNewRecipe(seque: UIStoryboardSegue){
        print("reloading data")
        self.loadCoreData()
        self.collectionView.reloadData()
        // self.collectionView.setContentOffset(CGPoint(x: CGFloat.max, y: 0.0), animated: true)
        // self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: recipes.count-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Right, animated: true)
        let scrollToItem:CGFloat = CGFloat(recipes.count)
        let offsetX = (scrollToItem - 1) * screenWidth * 0.85 + (scrollToItem - 1) * screenWidth * 0.025
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: true)

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecipeListViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: left most card
        // return (recipes.count + 1)
        return recipes.count
    }
    
    func asyncLoadImage(data: NSData, imageView: UIImageView) {
        let loadQueue = dispatch_queue_create("com.byalvin.loadAssets", nil)
        dispatch_async(loadQueue) {
            var image: UIImage!
            image = UIImage(data: data)
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as!RecipeListCollectionViewCell
        // TODO: left most card
//        if (indexPath.item == 0) {
//            cell.recipeName.hidden = true
//            cell.addTextView.hidden = false
//            cell.addTextView.text = "Add New"
//            cell.recipeImageView.image = UIImage(named: "main_storyboard_background")
//            cell.backgroundColor = UIColor.redColor()
//        } else {
        let recipe = recipes[indexPath.item] as! Recipe
        cell.recipeName.hidden = false
        cell.recipeName.text = recipe.name?.uppercaseString
        cell.recipeImageView.image = cachedImage[indexPath.item]

        var vendors: [String] = []
        var ingredients: [String] = []
        for ingredient in recipe.ingredients! {
            let _ingredient = ingredient as! Ingredient
            ingredients.append(_ingredient.name!.lowercaseString)
            if vendors.indexOf(_ingredient.vendor!) == nil {
                vendors.append((ingredient as! Ingredient).vendor!)
            }
        }
//        var ingredientDescription: String = "Requires "
//        ingredientDescription += ingredients.joinWithSeparator(", ")
//        ingredientDescription += " from "
//        ingredientDescription += vendors.joinWithSeparator(", ")
        cell.recipeIngredient.text = String(recipe.ingredients!.count) + " ingredients"
        cell.recipeMarket.text = String(vendors.count) + " markets"
        
        cell.recipeDelete.addTarget(self, action: "deletePressed:", forControlEvents: .TouchUpInside)
        // cell.recipeName.font = UIFont(name: "FontAwesome", size: 14.00)
        // cell.recipeName.font = UIFont.fontAwesomeOfSize(16.00)
        // cell.recipeName.text = String.fontAwesomeIconWithName(FontAwesome.Github)
        

        // cell.recipeImageView.image = UIImage(data: recipe.photo!)
            // asyncLoadImage(recipe.photo!, imageView: cell.recipeImageView)
//        }
        
        return cell
    }
    
    func deletePressed(sender: UIButton!) {
        let alertView = UIAlertController(title: "Warning", message: "Remove this recipe?", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            let buttonPosition = sender.convertPoint(CGPointZero, toView: self.collectionView)
            let indexPath:NSIndexPath = (self.collectionView.indexPathForItemAtPoint(buttonPosition))!
            self.managedContext.deleteObject(self.recipes[indexPath.item])
            self.recipes.removeAtIndex(indexPath.item)
            self.collectionView.deleteItemsAtIndexPaths([indexPath])
        }))
        alertView.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
}

extension RecipeListViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(self.screenWidth*0.85, (self.screenHeight-64)*0.9);
    }

    // compute collection view content offset in method bellow
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("end dragging")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.currentOffset = scrollView.contentOffset.x
        print("current", self.currentOffset)
    }
    
    // compute targetContentOffset in method bellow
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let collectionViewLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cardWithSpacing = self.screenWidth*0.85 + collectionViewLayout.minimumLineSpacing

        var newIndex: CGFloat
        
        // If the same, do nothing
        if self.currentOffset == targetContentOffset.memory.x {
            return
        }
        
        // Determine which direction we are heading
        if self.currentOffset < targetContentOffset.memory.x {
            // Going forward
            
            // Calculate the right visible edge
            let rightEdge = targetContentOffset.memory.x + self.screenWidth
            newIndex = ceil(rightEdge/cardWithSpacing)
            
        } else {
            // Going backward
            let leftEdge = targetContentOffset.memory.x
            newIndex = ceil(leftEdge/cardWithSpacing)
        }

        var newXOffset: CGFloat = 0.0
        if newIndex != 0 {
            newXOffset = (newIndex-1)*cardWithSpacing
        } else {
            
        }
        
        targetContentOffset.memory = CGPoint(x: newXOffset, y: targetContentOffset.memory.y)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected")
    }
}