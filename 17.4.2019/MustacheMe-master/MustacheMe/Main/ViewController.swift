//
//  ViewController.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var dataSource: [AnimationTableViewCellData] = {
        let multipleAnimations = AnimationTableViewCellData(name: "Multiple Animations") { [unowned self] in
            self.navigationController!.pushViewController(MultipleAnimationsViewController(), animated: true)
        }
        let scrubbedPropertyAnimation = AnimationTableViewCellData(name: "Scrubbed Property Animator") {
            self.navigationController!.pushViewController(ScrubbedPropertyAnimatorViewController(), animated: true)
        }
        let curvePropertyAnimation = AnimationTableViewCellData(name: "Time Curve") {
            self.navigationController!.pushViewController(CurvePropertyAnimatorViewController(), animated: true)
        }
        let dailyTipAnimation = AnimationTableViewCellData(name: "Daily Tip") {
            self.navigationController!.pushViewController(DailyTipViewController(), animated: true)
        }
        return [multipleAnimations, scrubbedPropertyAnimation, curvePropertyAnimation, dailyTipAnimation]
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: AnimationTableViewCell.className, bundle: nil), forCellReuseIdentifier: AnimationTableViewCell.className)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimationTableViewCell.className, for: indexPath) as! AnimationTableViewCell
        cell.title = dataSource[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dataSource[indexPath.row].action()
    }
}

