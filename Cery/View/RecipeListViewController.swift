//
//  RecipeListViewController.swift
//  Cery
//
//  Created by Alvin Nguyen on 3/11/2015.
//  Copyright © 2015 Alvin Nguyen. All rights reserved.
//

import UIKit
import CoreData

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
        
        // fetching and showing available recipes
        do {
            print("fetching recipes")
            let fetchRequest = NSFetchRequest(entityName: "Recipe")
            let results = try managedContext.executeFetchRequest(fetchRequest)
            recipes = results as! [NSManagedObject]
            for recipe in recipes {
                cachedImage.append(UIImage(data: (recipe as! Recipe).photo!)!)
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        
        // navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Screen and layout
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        print([screenWidth, screenHeight])

        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "ingredients")
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .ScaleAspectFill
        self.view.addSubview(backgroundImageView)
        
        let effect: UIBlurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(frame: self.view.frame)
        blurEffectView.effect = effect
        self.view.addSubview(blurEffectView)
        
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .Horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = screenWidth*0.025
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: screenWidth*0.075, bottom: 0, right: screenWidth*0.075)
        
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 30, width: screenWidth, height: screenHeight-30), collectionViewLayout: collectionViewLayout)
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
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        // Calculate the right width!
//        let itemCount: Int = collectionView.numberOfItemsInSection(0)
//        let contentWidth: Float = ((Float(itemCount) + 20.0) * 240.0) + 500.0
//        let screenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
//        collectionView.contentSize = CGSizeMake(CGFloat(contentWidth), screenHeight)
//        print(collectionView.contentSize)
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
        return (recipes.count + 1)
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
        if (indexPath.item == 0) {
            var frame: CGRect = cell.recipeName.frame
            let cellHeight = cell.frame.size.height
            let textLabelHeight = cell.recipeName.frame.size.height
            frame.origin.y = round((textLabelHeight-cellHeight)/2)
            print(round((textLabelHeight-cellHeight)/2))
            cell.recipeName.frame = frame
            cell.recipeName.text = "Add New"
            cell.recipeImageView.image = UIImage(named: "main_storyboard_background")
            cell.backgroundColor = UIColor.redColor()
        } else {
            let recipe = recipes[indexPath.item - 1] as! Recipe
            cell.recipeName.text = recipe.name
            cell.recipeImageView.image = cachedImage[indexPath.item - 1]
            // cell.recipeImageView.image = UIImage(data: recipe.photo!)
            // asyncLoadImage(recipe.photo!, imageView: cell.recipeImageView)
        }
        
        return cell
    }
}

extension RecipeListViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(self.screenWidth*0.85, (self.screenHeight-64)*0.85);
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