//
//  CreateChatRoomViewController.swift
//  HackerChat
//
//  Created by hackeru on 12/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import PKHUD

protocol CreateChatRoomViewControllerDelegate : class{
    
    func createChatRoomViewController(_ controller : CreateChatRoomViewController, didCreateRoom room : ChatRoom)
    
}

class CreateChatRoomViewController: UIViewController {

    weak var delegate : CreateChatRoomViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Create A Room"
        // Do any additional setup after loading the view.
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePictureAction(_:)))
        navigationItem.rightBarButtonItem = cameraButton
        
    }
    
    @objc func takePictureAction(_ sender : Any){
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func createChatRoom(_ sender : Any){
        guard let name = nameTextField.text, name.count > 0 else{
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var room = ChatRoom(name: name, uid: uid, description: descriptionTextField.text)
        room.save()
        
        guard let image = imageView.image else{
            //finish creating room
            //1. notify delegate
            delegate?.createChatRoomViewController(self, didCreateRoom: room)
            //2. back
            backAction()
            return
        }

        HUD.show(.labeledProgress(title: "Uploading...", subtitle: nil))
        
        room.upload(image: image) { [weak self](filename, error) in
            
            guard let strongSelf = self else { return }
            
            if let error = error{
                HUD.flash(.labeledError(title: error.localizedDescription, subtitle: nil), delay: 3)
            } else {
                room.imageName = filename
                room.save()
                
                strongSelf.delegate?.createChatRoomViewController(strongSelf, didCreateRoom: room)
                
                strongSelf.backAction()
                
                HUD.flash(.success, delay: 1.5)
            }
        }
        
    }
    
    func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension CreateChatRoomViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
