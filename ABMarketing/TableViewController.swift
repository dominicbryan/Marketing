//
//  TableViewController.swift
//  ABMarketing
//
//  Created by Dominic Bryan on 04/06/2020.
//  Copyright © 2020 Neos Ventures Ltd. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(SmartMotionMarketingCell.self,
                           forCellReuseIdentifier: SmartMotionMarketingCell.cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SmartMotionMarketingCell.cellIdentifier, for: indexPath) as! SmartMotionMarketingCell

        cell.configure(delegate: self, variant: .B)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
}

extension TableViewController: SmartMotionMarketingCellDelegate {
    func actionButtonPressed() {
        print("We printing baby")
    }
}
