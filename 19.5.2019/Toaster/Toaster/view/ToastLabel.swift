//
//  ToastLabel.swift
//  Toaster
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

extension String{
    func toast(){
        
        let appWindow = UIApplication.shared.delegate?.window
        appWindow??.toast(self)
        
    }
}

extension UIView{
    func toast(_ string : String, position : ToastLabel.Position = .top){
        ToastLabel.showToast(on: self, text: string, position: position)
    }
}

class ToastLabel: UILabel {
    
    enum Position{
        case top,bottom,center
        
        var yPosition : CGFloat{
            get{
                switch self {
                case .top: return 0.2
                case .center: return 0.5
                case .bottom: return 0.8
                }
            }
        }
    }
    
    class func showToast(on view : UIView, text : String, position : Position){

        let label = ToastLabel(frame: .zero)
        label.text = text
        
        label.sizeToFit()
        label.frame.size.width += 24
        label.frame.size.height += 16
        
        label.center = CGPoint(x: view.bounds.midX, y: view.bounds.height * position.yPosition)

        label.alpha = 0
        view.addSubview(label)
        
        UIView.animate(withDuration: 1.5, animations: {
            //fade in
            label.alpha = 1
        }) { (_) in
            //fade in finished
            UIView.animate(withDuration: 1.5, animations: {
                //fade out
                label.alpha = 0
            }, completion: { (_) in
                //fade out finished, remove label
                label.removeFromSuperview()
            })
        }
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup(){
        
        self.font = UIFont.boldSystemFont(ofSize: 24)
        self.textAlignment = .center
        self.backgroundColor = .black
        self.textColor = .white
        self.numberOfLines = 2
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
    }
}
