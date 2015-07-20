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

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib: UINib = UINib(nibName: "SKSelectOptionCell", bundle: nil)
        selectOptionTableView.registerNib(nib, forCellReuseIdentifier: "selectOptionCell")

        selectOptionTableView.delegate = self
        selectOptionTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SKSelectOptionCell = tableView.dequeueReusableCellWithIdentifier("selectOptionCell", forIndexPath: indexPath) as! SKSelectOptionCell

        cell.optionLabel.text = "hoge" as String

        return cell
    }

}
