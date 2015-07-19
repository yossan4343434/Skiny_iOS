//
//  SKCosmeticDetailViewController.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/19.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKCosmeticDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dummyCosmetic = SKCosmetic()
    var dummyIngredients = [SKIngredient]()

    @IBOutlet weak var cosmeticDetailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let cosmeticeListCellNib: UINib = UINib(nibName: "SKCosmeticListCell", bundle: nil)
        let ingredientListCellNib: UINib = UINib(nibName: "SKIngredientListCell", bundle: nil)
        cosmeticDetailTableView.registerNib(cosmeticeListCellNib, forCellReuseIdentifier: "cosmeticListCell")
        cosmeticDetailTableView.registerNib(ingredientListCellNib, forCellReuseIdentifier: "ingredientListCell")

        cosmeticDetailTableView.delegate = self
        cosmeticDetailTableView.dataSource = self

        loadData()
    }

    func loadData() {
        if let path = NSBundle.mainBundle().pathForResource("dummy_contents", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                let jsonResult  = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                let jsonResultIngredients = jsonResult["ingredient"] as! NSArray

                for ingredientId in dummyCosmetic.ingredientIds {
                    var dummyIngredient = SKIngredient()

                    dummyIngredient.id = jsonResultIngredients[ingredientId - 1]["id"] as! Int
                    dummyIngredient.name = jsonResultIngredients[ingredientId - 1]["name"] as! String

                    dummyIngredients.append(dummyIngredient)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dummyIngredients.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cosmeticListCell", forIndexPath: indexPath) as! SKCosmeticListCell

            cell.cosmeticNameLabel.text = dummyCosmetic.name as String
            cell.cosmeticBrandLabel.text = dummyCosmetic.brand as String
            cell.cosmeticCategoryLabel.text = dummyCosmetic.category as String
            let imageName = NSString(string: dummyCosmetic.image as String)
            cell.cosmeticImageView.image = UIImage(named: imageName as String)

            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ingredientListCell", forIndexPath: indexPath) as! SKIngredientListCell

            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return SKCosmeticListCell.cellHeight()
        } else {
            return SKIngredientListCell.cellHeight()
        }
    }

}
