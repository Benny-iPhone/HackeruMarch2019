//
//  ViewController.swift
//  SegementedTableView
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Mode : Int{
        case recent
        case poular
        case a2z

        var bl : IPersonVCBL{
            let array = DataController.shared.allPeople
            switch self {
            case .recent: return RecentPeopleBL(array: array)
            case .poular: return PopularityPeopleBL(array: array)
            case .a2z: return AlphabeticPeopleBL(array: array)
            }
        }
    }
    
    var bl : IPersonVCBL?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        //tableView.delegate = self
        DataController.shared.allPeople = Person.allPeople
        
        implement(mode: .recent)
    }
    
    func implement(mode : Mode){
        bl = nil
        tableView.reloadData()
        
        var newBL = mode.bl
        
        newBL.fetch(with: { [weak self](arr) in
            newBL.array = arr
            self?.bl = newBL
            self?.tableView.reloadData()
        })
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        guard let mode = Mode(rawValue: sender.selectedSegmentIndex) else{ return }
        self.implement(mode: mode)
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bl?.numberOfPeople ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let p = bl?.peopleAt(index: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonCell
        cell.populate(with: p)
        return cell
        
    }
}

