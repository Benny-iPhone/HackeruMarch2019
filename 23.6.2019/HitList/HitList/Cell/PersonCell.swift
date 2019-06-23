//
//  PersonCell.swift
//  HitList
//
//  Created by hackeru on 23/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

extension Date{
    var uiString : String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        
        return formatter.string(from: self)
    }
}

class PersonCell: UITableViewCell {
    
    weak var nameLabel : UILabel!
    weak var createdAtLabel : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
        
    }
    
    private func buildUI(){
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        let createdAtLabel = UILabel(frame: .zero)
        createdAtLabel.font = UIFont.systemFont(ofSize: 18)
        createdAtLabel.textColor = .darkGray
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel,createdAtLabel])
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ].forEach{ $0.isActive = true }
        
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.nameLabel = nameLabel
        self.createdAtLabel = createdAtLabel
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(with person : Person?){
        var arr : [String] = []
        if let firstName = person?.firstName { arr += [firstName] }
        if let lastName = person?.lastName { arr += [lastName] }
        nameLabel.text = arr.joined(separator: " ")
        
        nameLabel.textColor = (person?.personGender.boolValue ?? false) ? .red : .blue
        
        createdAtLabel.text = person?.createdAt?.uiString
    }
    
}
