//
//  MyTextTableViewCell.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/19/22.
//

import UIKit

class MyTextTableViewCell: TextTableViewCell {
    static let identifier: String = "MyTextCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        contentView.addSubview(containerView)
        containerView.do {
            setupContainerView($0)
            
            $0.addSubview(textMessageLabel)
            setupTextMessageLabel(textMessageLabel)
        }
    }
    
    private func setupContainerView(_ containerView: UIView) {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.trailing.equalToSuperview().offset(-8)
            $0.leading.greaterThanOrEqualToSuperview().offset(8)
        }
    }
    
    private func setupTextMessageLabel(_ label: UILabel) {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
}
