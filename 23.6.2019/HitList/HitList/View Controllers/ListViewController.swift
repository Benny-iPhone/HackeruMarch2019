//
//  ListViewController.swift
//  HitList
//
//  Created by hackeru on 23/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    weak var tableView : UITableView!
    var dataController : NSFetchedResultsController<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Hit List"
        view.backgroundColor = .white
        

        fetchData()
        
        //navigationItem.hidesBackButton = true
        buildUIElements()
        
    }
    
    private func fetchData(){
        
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        
        //filter result using query (see UISearchBar)
        //let q = "g"
        //request.predicate = NSPredicate(format: "lastName CONTAINS[cd] %@ OR firstName CONTAINS[cd] %@", q)
        
        //sort
        request.sortDescriptors = [
            NSSortDescriptor(key: "lastName", ascending: true),
            NSSortDescriptor(key: "firstName", ascending: true)
        ]
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Database.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            print(error)
        }
        
        controller.delegate = self
        self.dataController = controller
        
    }
    
    private func buildUIElements(){
        //Add Button
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPersonAction(_:)))
        navigationItem.rightBarButtonItem = button
        
        // - TableView
        
        //Create
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        [
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ].forEach{ $0.isActive = true }
        
        //Hook
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(PersonCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.leftBarButtonItem = createToggleButton()
        
    }
    
    @objc func toggleEditingAction(){
        tableView.isEditing = !tableView.isEditing
        navigationItem.leftBarButtonItem = createToggleButton()
    }
    
    private func createToggleButton() -> UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done : .edit, target: self, action: #selector(toggleEditingAction))
    }

    @objc func addPersonAction(_ sender : Any){
        let personVC = PersonViewController()
        self.navigationController?.pushViewController(personVC, animated: true)
    }
    
}

extension ListViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonCell
        
        let person = dataController?.object(at: indexPath)
        cell.populate(with: person)
        //cell.textLabel?.text = person?.firstName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personVC = PersonViewController()
        personVC.person = dataController?.object(at: indexPath)
        
        self.navigationController?.pushViewController(personVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete, let person = dataController?.object(at: indexPath){
            
            Database.shared.context.delete(person)
            Database.shared.saveContext()
            
        }
        
    }
}

extension ListViewController : NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            
            if let indexPath = indexPath,
                let cell = tableView.cellForRow(at: indexPath) as? PersonCell,
                let person = dataController?.object(at: indexPath){
                cell.populate(with: person)
            }
            
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
        
    }
    
}
























