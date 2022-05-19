//
//  TextTableViewCell.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import UIKit
import SnapKit
import Then

class TextTableViewCell: UITableViewCell {    
    var containerView: UIView = UIView().then {
        $0.backgroundColor = .systemTeal
        $0.layer.cornerRadius = 10
    }
    
    var textMessageLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .natural
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.selectionStyle = .none
    }
}
