//
//  ViewController.swift
//  ProfilePicImageView
//
//  Created by hackeru on 22/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

struct User{
    
    enum Gender{
        case male, female
    }
    
    let name : String
    let birthdate : String
    let gender : Gender
    let profileImage : UIImage?
    
}

class ViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    //set isHighlighted true for male
    @IBOutlet weak var genderImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //allow gesture on profile pic imageView
        profilePicImageView.isUserInteractionEnabled = true
        
        let image = UIImage(named: "dany")
        let testUser = User(name: "dynarise targaryen",
                            birthdate: "22.03.1991",
                            gender: .female,
                            profileImage: image)
        
        populate(with: testUser)
        
        //makeBlueMaleIcon()
    }
    
    private func makeBlueMaleIcon(){
        let image = UIImage(named: "icons8-male")?.withRenderingMode(.alwaysTemplate)
        genderImageView.image = image
        genderImageView.tintColor = .blue
    }
    
    func populate(with user : User)
    {
        profilePicImageView.image = user.profileImage
        nameLabel.text = user.name.capitalized
        birthdateLabel.text = user.birthdate
        
        genderImageView.isHighlighted = user.gender == .male
        genderImageView.tintColor = user.gender == .male ? .blue : .red
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        genderImageView.tintColor = sender.selectedSegmentIndex == 0 ? .black : .orange
        
    }
    
    @IBAction func editImageAction(_ sender: Any) {
        /*
        if let gesture = sender as? UITapGestureRecognizer{
            //do whatever
        }
 */
        
        let actionSheet = UIAlertController(title: "Select Source", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        func handler(_ action : UIAlertAction){
            guard let title = action.title else{ return }
            
            let picker = UIImagePickerController()
            
            switch title {
            case "Rear Camera":
                picker.sourceType = .camera
                picker.cameraDevice = .rear
            case "Selfie Camera":
                picker.sourceType = .camera
                picker.cameraDevice = .front
            case "Album":
                picker.sourceType = .photoLibrary
            default:
                return
            }
            
            picker.delegate = self
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
            
        }
        
        actionSheet.addAction(UIAlertAction(title: "Rear Camera", style: .default, handler: handler))
        actionSheet.addAction(UIAlertAction(title: "Selfie Camera", style: .default, handler: handler))
        //.destructive => Red
        actionSheet.addAction(UIAlertAction(title: "Album", style: .destructive, handler: handler))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

extension ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //get edited image, if nil => original image. Cast to UIImage since dictionary values are Any
        let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        profilePicImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
