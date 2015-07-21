//
//  SKCosmeticDetailViewController.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/19.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKCosmeticDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cosmetic = SKCosmetic()
    var ingredients = [SKIngredient]()

    @IBOutlet weak var cosmeticDetailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let cosmeticListCellNib: UINib = UINib(nibName: "SKCosmeticListCell", bundle: nil)
        let ingredientListCellNib: UINib = UINib(nibName: "SKIngredientListCell", bundle: nil)
        cosmeticDetailTableView.registerNib(cosmeticListCellNib, forCellReuseIdentifier: "cosmeticListCell")
        cosmeticDetailTableView.registerNib(ingredientListCellNib, forCellReuseIdentifier: "ingredientListCell")

        cosmeticDetailTableView.delegate = self
        cosmeticDetailTableView.dataSource = self

        loadData()
    }

    func loadData() {
        if let path = NSBundle.mainBundle().pathForResource("CosmeticData", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                let jsonResult  = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                let jsonResultIngredients = jsonResult["ingredients"] as! NSArray

                for ingredientId in cosmetic.ingredientIds {
                    var ingredient = SKIngredient()

                    ingredient.id = jsonResultIngredients[ingredientId]["id"] as! Int
                    ingredient.name = jsonResultIngredients[ingredientId]["name"] as! String

                    ingredients.append(ingredient)
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
            return ingredients.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cosmeticListCell", forIndexPath: indexPath) as! SKCosmeticListCell

            cell.cosmeticNameLabel.text = cosmetic.name as String
            cell.cosmeticBrandLabel.text = cosmetic.brand as String
            cell.cosmeticCategoryLabel.text = cosmetic.category as String
            let imageName = NSString(string: cosmetic.image as String)
            cell.cosmeticImageView.image = UIImage(named: imageName as String)

            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ingredientListCell", forIndexPath: indexPath) as! SKIngredientListCell

            cell.ingredientNameLabel.text = ingredients[indexPath.row].name as String

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
