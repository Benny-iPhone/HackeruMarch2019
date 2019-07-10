//
//  TweetsViewController.swift
//  CellFromNibFile
//
//  Created by hackeru on 10/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tableArray : [Tweet] = Tweet.demo
    weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Tweets"
        
        buildTableView()
        hookNibFiles()
    }
    
    private func hookNibFiles(){
        tableView.register(UINib(nibName: "TweetTextCell", bundle: .main), forCellReuseIdentifier: "textCell")
        //tableView.register(UINib(nibName: "TweetImageCell", bundle: .main), forCellReuseIdentifier: "imageCell")
    }
    
    private func buildTableView(){
        
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        [
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ].forEach{ $0.isActive = true }
        
        
        self.tableView = tableView
        
        tableView.dataSource = self

    }
    

}

extension TweetsViewController : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TweetTextCell
        cell.populate(with: tableArray[indexPath.row])
        return cell
    }
    
    
    
    
    
}
