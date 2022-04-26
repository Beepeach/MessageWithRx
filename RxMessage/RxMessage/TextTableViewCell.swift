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
    static let identifier: String = "TextCell"
    
    var containerView: UIView = UIView().then {
        $0.backgroundColor = .red
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
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupContainerView()
        setupTextMessageLabel()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.trailing.equalToSuperview().offset(-8)
            $0.leading.greaterThanOrEqualToSuperview().offset(8)
        }
    }
    
    private func setupTextMessageLabel() {
        containerView.addSubview(textMessageLabel)
        textMessageLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
}
