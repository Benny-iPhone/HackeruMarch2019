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
    
    var expandedIndexPath : IndexPath?
    
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
    
    func identifier(for indexPath : IndexPath) -> String{
        
        if let expandedIndexPath = self.expandedIndexPath, expandedIndexPath == indexPath{
            return "expanded_cell" //'open' cell
        } else {
            return "collapsed_cell" //'closed' cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.identifier(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ActivityCell
        
        cell.populate(with: tableArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //remove seletion
        tableView.deselectRow(at: indexPath, animated: true)
        
        // -- logic --
        
        let activity = tableArray[indexPath.row]
        guard activity.steps.count >= 2 else {
            //not enough steps, avoid expanding cell
            return
        }
        
        // --- UI ---
        
        var arr : [IndexPath] = [indexPath]
        
        if indexPath == self.expandedIndexPath{
            //close current
            self.expandedIndexPath = nil
        } else {
            //open new row
            
            if let expandedIndexPath = self.expandedIndexPath{
                //refresh also old 'open' row
                arr += [expandedIndexPath]
            }
            
            self.expandedIndexPath = indexPath

            
        }
        
        tableView.reloadRows(at: arr, with: .automatic)
    }
    
}
