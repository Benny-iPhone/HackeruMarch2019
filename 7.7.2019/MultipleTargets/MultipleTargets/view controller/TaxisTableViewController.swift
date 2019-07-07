//
//  TaxisTableViewController.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TaxisTableViewController: UITableViewController {

    var tableArray : [Taxi] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableArray = DataLoader<Taxi>().loadDataFrom(file: "taxis")
        
        navigationItem.title = "Taxis"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaxiCell
        
        cell.populate(with: tableArray[indexPath.row])

        return cell
    }
    

}
