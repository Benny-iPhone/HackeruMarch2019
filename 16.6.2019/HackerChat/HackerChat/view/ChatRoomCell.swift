//
//  ChatRoomCell.swift
//  HackerChat
//
//  Created by hackeru on 12/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI

class ChatRoomCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var roomImageView : UIImageView!

    func populate(with room : ChatRoom){
        nameLabel.text = room.name
        descriptionLabel.text = room.description

        if let ref = room.imageStorageRef{
            roomImageView.sd_setImage(with: ref)
        } else {
            roomImageView.image = nil
            roomImageView.sd_cancelCurrentImageLoad()
        }
    }

}
