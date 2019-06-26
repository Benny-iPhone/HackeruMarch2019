//
//  ActivitiesListViewController.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ActivitiesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tableArray : [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableArray = AppManager.shared.getAllActivities()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ActivitiesListViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityCell
        
        cell.populate(with: tableArray[indexPath.row])
        
        return cell
    }
    
}
