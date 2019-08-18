//
//  StationPickerViewController.swift
//  Radio
//
//  Created by Benny Davidovitz on 18/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import UIKit

protocol StationPickerViewControllerDelegate : class {
    func stationPickerViewController(_ controller : StationPickerViewController, didSelect station : RadioStation)
}

class StationPickerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate : StationPickerViewControllerDelegate?
    var tableArray : [RadioStation] = []
    var selectedStation : RadioStation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
    }
    
    func loadData(){
        tableArray = RadioStation.readJson(file: "stations")
        tableView.reloadData()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension StationPickerViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let station = tableArray[indexPath.row]
        
        cell.textLabel?.text = station.name
        
        if station.id == selectedStation?.id{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.delegate?.stationPickerViewController(self, didSelect: tableArray[indexPath.row])
        
        self.closeAction(tableView)
    }
}
