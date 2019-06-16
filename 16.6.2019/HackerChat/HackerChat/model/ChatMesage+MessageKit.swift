//
//  ChatMesage+MessageKit.swift
//  HackerChat
//
//  Created by hackeru on 16/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import MessageKit

extension String{
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
    
    var isSingleEmojiChar : Bool{
        return count == 1 && containsEmoji
    }
}

extension ChatMessage : MessageType{
    var sender: SenderType {
        return UserWrapper(displayName: self.uName, senderId : self.uid)
    }
    
    var messageId: String {
        return self.mid
    }
    
    var sentDate: Date {
        return self.date
    }
    
    var kind: MessageKind {
        
        if type == .image{
            return MessageKind.photo(self)
        }
        
        if let text = self.text, text.isSingleEmojiChar{
            return MessageKind.emoji(text)
        }
        return MessageKind.text(self.text ?? "")
    }
    
    
}

extension ChatMessage : MediaItem{
    var url: URL? {
        return info as? URL
    }
    
    var image: UIImage? {
        return nil
    }
    
    var placeholderImage: UIImage {
        return UIImage()
    }
    
    var size: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    
    
    
}
