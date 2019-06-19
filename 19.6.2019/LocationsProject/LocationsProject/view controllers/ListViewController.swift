//
//  ListViewController.swift
//  LocationsProject
//
//  Created by hackeru on 19/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableArray : [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
        loadData()
        
        NotificationCenter.default.addObserver(forName: .locationUpdate, object: nil, queue: .main) { [weak self](_) in
            self?.sortData()
        }
    }
    
    private func sortData(){
        guard let userLocation = LocationTracker.shared.location else { return }
        
        tableArray.sort { (p1, p2) -> Bool in
            let p1Distance = p1.location.distance(from: userLocation)
            let p2Distance = p2.location.distance(from: userLocation)
            
            return p1Distance < p2Distance
        }
        
        tableView.reloadData()
    }
    
    private func loadData(){
        tableArray = Place.loadFrom(file: "places")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? PlaceDetailsViewController,
            let indexPath = tableView.indexPathForSelectedRow{
            
            //pass data
            nextVC.place = tableArray[indexPath.row]
            
            //de-select row (UI)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension ListViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceCell
        
        cell.populate(with: tableArray[indexPath.row])
        
        return cell
    }
    
}
