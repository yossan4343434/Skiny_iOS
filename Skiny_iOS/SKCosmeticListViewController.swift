//
//  SKCosmeticListViewController.swift
//  Skiny_iOS
//
//  Created by Yoshiyuki Kuga on 2015/07/18.
//  Copyright (c) 2015年 Gruppy. All rights reserved.
//

import UIKit

class SKCosmeticListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dummyContents = NSArray()

    @IBOutlet weak var cosmeticListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dummyContents = ["hoge", "foo", "bar"]

        let nib: UINib = UINib(nibName: "SKCosmeticListCell", bundle: nil)
        cosmeticListTableView.registerNib(nib, forCellReuseIdentifier: "cosmeticListCell")

        cosmeticListTableView.delegate = self
        cosmeticListTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyContents.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SKCosmeticListCell = tableView.dequeueReusableCellWithIdentifier("cosmeticListCell", forIndexPath: indexPath) as! SKCosmeticListCell

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SKCosmeticListCell.cellHeight()
    }

}
