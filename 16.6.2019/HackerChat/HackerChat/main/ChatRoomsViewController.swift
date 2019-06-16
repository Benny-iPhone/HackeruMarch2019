//
//  ChatRoomsViewController.swift
//  HackerChat
//
//  Created by hackeru on 12/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableArray : [ChatRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Chat Rooms"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        getDataFromFirebase()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func pullToRefreshAction(){
        getDataFromFirebase()
    }
    
    func getDataFromFirebase(){
        
        ChatRoom.chatRoomsRef.observeSingleEvent(of: .value) { [weak self](snapshot) in
            guard let rawData = snapshot.value as? [String:Any] else { return }
            let allRooms = rawData.compactMap{ $0.value as? [String:Any]}.compactMap{ ChatRoom(dict: $0)}
            
            self?.tableArray = allRooms
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
            
            //print(allRooms)
            /*
            var roomsArray : [ChatRoom] = []
            for (_,value) in rawData{
                if let dict = value as? [String:Any]{
                    roomsArray += [ChatRoom(dict)]
                }
            }*/
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let createVC = segue.destination as? CreateChatRoomViewController{
            createVC.delegate = self
        }
        
        if let chatVC = segue.destination as? ChatViewController,
            let indexPath = tableView.indexPathForSelectedRow{
            
            chatVC.room = tableArray[indexPath.row]
            
        }
        
    }
    

}

extension ChatRoomsViewController : CreateChatRoomViewControllerDelegate{
    
    func createChatRoomViewController(_ controller: CreateChatRoomViewController, didCreateRoom room: ChatRoom) {
        tableArray.insert(room, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
}

extension ChatRoomsViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatRoomCell
        
        let obj = tableArray[indexPath.row]

        cell.populate(with: obj)
//        cell.textLabel?.text = obj.name
//        cell.detailTextLabel?.text = obj.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        return tableArray[indexPath.row].owner == uid
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        tableArray.remove(at: indexPath.row).removeFromDB()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


