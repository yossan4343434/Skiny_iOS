//
//  SKCosmeticListViewController.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/18.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKCosmeticListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cosmetics = [SKCosmetic]()
    var selectedCosmetic = SKCosmetic()

    @IBOutlet weak var cosmeticListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var addCosmeticButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addCosmeticButtonTapped")
        self.navigationItem.rightBarButtonItem = addCosmeticButton

        let nib: UINib = UINib(nibName: "SKCosmeticListCell", bundle: nil)
        cosmeticListTableView.registerNib(nib, forCellReuseIdentifier: "cosmeticListCell")

        cosmeticListTableView.delegate = self
        cosmeticListTableView.dataSource = self

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData() {
        if let path = NSBundle.mainBundle().pathForResource("CosmeticData", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                let jsonResultCosmetics = jsonResult["cosmetics"] as! NSArray
                let jsonResultBrands = jsonResult["brands"] as! NSArray
                let jsonResultCategories = jsonResult["categories"] as! NSArray

                for jsonResultCosmetic in jsonResultCosmetics {
                    var cosmetic = SKCosmetic()

                    var brandId = jsonResultCosmetic["brand"] as! Int
                    var categoryId = jsonResultCosmetic["category"] as! Int

                    cosmetic.id = jsonResultCosmetic["id"] as! Int
                    cosmetic.name = jsonResultCosmetic["name"] as! String
                    cosmetic.brand = jsonResultBrands[brandId]["name"] as! String
                    cosmetic.category = jsonResultCategories[categoryId]["name"] as! String
                    cosmetic.image = jsonResultCosmetic["image"] as! String
                    cosmetic.ingredientIds = jsonResultCosmetic["ingredients"] as! [Int]

                    cosmetics.append(cosmetic)
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosmetics.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SKCosmeticListCell = tableView.dequeueReusableCellWithIdentifier("cosmeticListCell", forIndexPath: indexPath) as! SKCosmeticListCell

        var cosmetic = cosmetics[indexPath.row]

        cell.cosmeticNameLabel.text = cosmetic.name as String
        cell.cosmeticBrandLabel.text = cosmetic.brand as String
        cell.cosmeticCategoryLabel.text = cosmetic.category as String
        let imageName = NSString(string: cosmetic.image as String)
        cell.cosmeticImageView.image = UIImage(named: imageName as String)

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SKCosmeticListCell.cellHeight()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCosmetic = cosmetics[indexPath.row]
        performSegueWithIdentifier("toCosmeticDetail", sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCosmeticDetail" {
            var cosmeticDetailViewController = SKCosmeticDetailViewController()
            cosmeticDetailViewController = segue.destinationViewController as! SKCosmeticDetailViewController
            cosmeticDetailViewController.cosmetic = selectedCosmetic
        } else if segue.identifier == "toSelectCategory" {
            var selectCosmeticViewController = SKSelectCosmeticViewController()
            selectCosmeticViewController = segue.destinationViewController as! SKSelectCosmeticViewController
            selectCosmeticViewController.selectType = 0
        }
    }

    func addCosmeticButtonTapped() {
        performSegueWithIdentifier("toSelectCategory", sender: nil)
    }

}
