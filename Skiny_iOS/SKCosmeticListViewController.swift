//
//  SKCosmeticListViewController.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/18.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKCosmeticListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dummyCosmetics = [SKCosmetic]()
    var selectedCosmetic = SKCosmetic()

    @IBOutlet weak var cosmeticListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        if let path = NSBundle.mainBundle().pathForResource("dummy_contents", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                let jsonResultCosmetics = jsonResult["cosmetics"] as! NSArray
                let jsonResultBrands = jsonResult["brands"] as! NSArray
                let jsonResultCategories = jsonResult["categories"] as! NSArray

                for jsonResultCosmetic in jsonResultCosmetics {
                    var dummyCosmetic = SKCosmetic()

                    var brandId = jsonResultCosmetic["brand"] as! Int
                    var categoryId = jsonResultCosmetic["category"] as! Int

                    dummyCosmetic.id = jsonResultCosmetic["id"] as! Int
                    dummyCosmetic.name = jsonResultCosmetic["name"] as! String
                    dummyCosmetic.brand = jsonResultBrands[brandId - 1]["name"] as! String
                    dummyCosmetic.category = jsonResultCategories[categoryId - 1]["name"] as! String
                    dummyCosmetic.image = jsonResultCosmetic["image"] as! String
                    dummyCosmetic.ingredientIds = jsonResultCosmetic["ingredients"] as! [Int]

                    dummyCosmetics.append(dummyCosmetic)
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyCosmetics.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SKCosmeticListCell = tableView.dequeueReusableCellWithIdentifier("cosmeticListCell", forIndexPath: indexPath) as! SKCosmeticListCell

        var dummyCosmetic = dummyCosmetics[indexPath.row]

        cell.cosmeticNameLabel.text = dummyCosmetic.name as String
        cell.cosmeticBrandLabel.text = dummyCosmetic.brand as String
        cell.cosmeticCategoryLabel.text = dummyCosmetic.category as String
        let imageName = NSString(string: dummyCosmetic.image as String)
        cell.cosmeticImageView.image = UIImage(named: imageName as String)

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SKCosmeticListCell.cellHeight()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCosmetic = dummyCosmetics[indexPath.row]
        performSegueWithIdentifier("toCosmeticDetail", sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCosmeticDetail" {
            var cosmeticDetailViewController = SKCosmeticDetailViewController()
            cosmeticDetailViewController = segue.destinationViewController as! SKCosmeticDetailViewController
            cosmeticDetailViewController.dummyCosmetic = selectedCosmetic
        }
    }

}
