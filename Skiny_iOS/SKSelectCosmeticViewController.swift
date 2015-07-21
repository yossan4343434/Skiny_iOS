//
//  SKSelectCosmeticViewController.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/20.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKSelectCosmeticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var selectCategoryTableView: UITableView!
    @IBOutlet weak var selectBrandTableView: UITableView!

    var selectType = Int() // 0: select category, 1: select brand

    var categories = [SKCategory]()
    var selectedCategory = SKCategory()
    var brands = [SKBrand]()
    var selectedBrands = SKBrand()
    var cosmetics = [SKCosmetic]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "SKSelectOptionCell", bundle: nil)
        if selectType == 0 {
            selectCategoryTableView.registerNib(nib, forCellReuseIdentifier: "selectOptionCell")

            selectCategoryTableView.delegate = self
            selectCategoryTableView.dataSource = self
        } else if selectType == 1 {
            selectBrandTableView.registerNib(nib, forCellReuseIdentifier: "selectOptionCell")

            selectBrandTableView.delegate = self
            selectBrandTableView.dataSource = self
        }

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData() {
        if let path = NSBundle.mainBundle().pathForResource("CosmeticData", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                if selectType == 0 {
                    let jsonResultCategories = jsonResult["categories"] as! NSArray

                    for jsonResultCategory in jsonResultCategories {
                        var category = SKCategory()

                        category.id = jsonResultCategory["id"] as! Int
                        category.name = jsonResultCategory["name"] as! String

                        categories.append(category)
                    }
                } else if selectType == 1 {
                    var jsonResultCosmetics = jsonResult["cosmetics"] as! NSArray
                    var jsonResultBrands = jsonResult["brands"] as! NSArray

                    for jsonResultCosmetic in jsonResultCosmetics {
                        let jsonResultCosmeticCategoryId = jsonResultCosmetic["category"] as! Int
                        if jsonResultCosmeticCategoryId == selectedCategory.id {
                            var brandId = jsonResultCosmetic["brand"] as! Int

                            var brand = SKBrand()
                            brand.id = jsonResultBrands[brandId]["id"] as! Int
                            brand.name = jsonResultBrands[brandId]["name"] as! String

                            brands.append(brand)
                        }
                    }
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = Int()

        if selectType == 0 {
            rowsCount = categories.count
        } else if selectType == 1 {
            rowsCount = brands.count
        }

        return rowsCount
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SKSelectOptionCell = tableView.dequeueReusableCellWithIdentifier("selectOptionCell", forIndexPath: indexPath) as! SKSelectOptionCell

        if selectType == 0 {
            cell.optionLabel.text = categories[indexPath.row].name as String
        } else if selectType == 1 {
            cell.optionLabel.text = brands[indexPath.row].name as String
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selectType == 0 {
            selectedCategory = categories[indexPath.row]
            performSegueWithIdentifier("toSelectBrand", sender: nil)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSelectBrand" {
            var selectCosmeticViewController = SKSelectCosmeticViewController()
            selectCosmeticViewController = segue.destinationViewController as! SKSelectCosmeticViewController
            selectCosmeticViewController.selectType = 1
            selectCosmeticViewController.selectedCategory = selectedCategory
        }
    }

}
