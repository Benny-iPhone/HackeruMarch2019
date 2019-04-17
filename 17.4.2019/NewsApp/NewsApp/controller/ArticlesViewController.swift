//
//  ArticlesViewController.swift
//  NewsApp
//
//  Created by hackeru on 17/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import SafariServices

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    var tableArray : [NewsAPI.Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let tableview know our xib
        tableView.register(UINib(nibName: "ArticleCell", bundle: .main), forCellReuseIdentifier: "ArticleCell")
        
        //hook protocols
        tableView.dataSource = self
        tableView.delegate = self

        //get data
        fetchDataFromServer()
    }
    
    private func fetchDataFromServer(){
        NewsAPI().fetchArticles(from: .topHeadlines, with: ["country":"us"]) { [weak self](result, error) in
            
            guard let strongSelf = self else { return }
            if let error = error{
                //TODO: - Show error (see pod PKHUD)
                print(error)
                return
            }
            
            strongSelf.tableArray = result?.articles ?? []
            strongSelf.tableView.reloadData()
            
        }
    }

}

extension ArticlesViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        cell.config(with: tableArray[indexPath.row])
        
        return cell
        
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tableArray[indexPath.row].title
        cell.detailTextLabel?.text = tableArray[indexPath.row].description
        
        return cell
 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //remove gray selection
        tableView.deselectRow(at: indexPath, animated: true)
        
        //create safari view controller
        guard let url = URL(string: tableArray[indexPath.row].url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
}
