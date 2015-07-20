//
//  SKSelectCosmeticViewController.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/20.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKSelectCosmeticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var selectOptionTableView: UITableView!

    var categories = [SKCategory]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib: UINib = UINib(nibName: "SKSelectOptionCell", bundle: nil)
        selectOptionTableView.registerNib(nib, forCellReuseIdentifier: "selectOptionCell")

        selectOptionTableView.delegate = self
        selectOptionTableView.dataSource = self

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData() {
        if let path = NSBundle.mainBundle().pathForResource("dummy_contents", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                let jsonResultCategories = jsonResult["categories"] as! NSArray

                for jsonResultCategory in jsonResultCategories {
                    var category = SKCategory()

                    category.id = jsonResultCategory["id"] as! Int
                    category.name = jsonResultCategory["name"] as! String

                    categories.append(category)
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SKSelectOptionCell = tableView.dequeueReusableCellWithIdentifier("selectOptionCell", forIndexPath: indexPath) as! SKSelectOptionCell

        cell.optionLabel.text = categories[indexPath.row].name as String

        return cell
    }

}
