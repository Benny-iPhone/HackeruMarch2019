//
//  ChatViewController.swift
//  HackerChat
//
//  Created by hackeru on 16/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import MessageKit
import Firebase
import InputBarAccessoryView
import PKHUD

class ChatViewController: MessagesViewController{
    
    var room : ChatRoom!
    var messages : [ChatMessage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = room.name
        
        //mock 1
        //messages = stride(from: 0, to: 1000, by: 7).compactMap{ "Message \($0)"}.compactMap{ ChatMessage(text: $0)}
        //mock 2
        //messages = [0,1,2,3,4,5,6].compactMap{ "Message \($0)"}.compactMap{ ChatMessage(text: $0)}

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        self.messageInputBar.delegate = self
        
        let button = UIButton(type: .system)
        button.setTitle("🧷", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(takePicAction(_:)), for: .touchUpInside)
        
        self.messageInputBar.leftStackView.addArrangedSubview(button)
        self.messageInputBar.setLeftStackViewWidthConstant(to: 60, animated: false)
        
        listenToNewMessages()
    }
    
    @objc func takePicAction(_ sender : Any){
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    deinit {
        room.messagesDatabaseReference.removeAllObservers()
    }
    
    private func listenToNewMessages(){
        //room.messagesDatabaseReference
        room.messagesDatabaseReference.queryOrdered(byChild: "date").observe(.childAdded) { [weak self](msgSnapshot) in
            guard let json = msgSnapshot.value as? [String:Any] else { return }
            
            guard let msg = ChatMessage(json: json) else { return }
            //add message to UI
            self?.messages.append(msg)
            self?.messagesCollectionView.reloadData()
            
            
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        
        let msg = messages[indexPath.section]
        if let mediaCell = cell as? MediaMessageCell, msg.type == .image{
            mediaCell.imageView.sd_setImage(with: msg.storageRef, placeholderImage: UIImage())
        }
        
        return cell
    }
    
}

extension ChatViewController : InputBarAccessoryViewDelegate{
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        inputBar.inputTextView.text = ""
        inputBar.inputTextView.resignFirstResponder()
        
        let msg = ChatMessage(text: text)
        msg.save(in: self.room)
    }
    
}

extension ChatViewController : MessagesDisplayDelegate{
    
}

extension ChatViewController : MessagesLayoutDelegate{
    
}

extension ChatViewController : MessagesDataSource{
    func currentSender() -> SenderType {
        guard let user = Auth.auth().currentUser else{ fatalError() }
        return UserWrapper(displayName: user.displayName ?? "", senderId : user.uid)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
    
}

extension ChatViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage,
        let data = image.jpegData(compressionQuality: 0.7)
        else {
            return
        }
        
        HUD.show(.progress)
        let room = self.room!
        var msg = ChatMessage(type: .image)
        msg.save(imageData: data) { (err) in
            if let _ = err {
                HUD.flash(.error, delay: 1)
            } else {
                HUD.flash(.success, delay: 1)
                msg.save(in: room)
            }
        }
    }
}
