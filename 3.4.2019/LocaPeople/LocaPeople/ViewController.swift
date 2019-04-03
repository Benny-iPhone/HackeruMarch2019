//
//  ViewController.swift
//  LocaPeople
//
//  Created by hackeru on 03/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tableArray : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableArray = DataManager.manager.loadPeople()

        tableView.dataSource = self
    }

}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let p = tableArray[indexPath.row]
        cell.textLabel?.text = p.firstName + " " + p.lastName
        cell.detailTextLabel?.text = p.email
        cell.textLabel?.textColor = p.color
        
        //cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{
            return
        }
        
        tableArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    
}
