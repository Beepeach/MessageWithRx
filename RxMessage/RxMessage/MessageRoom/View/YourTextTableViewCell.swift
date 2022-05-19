//
//  YourTextTableViewCell.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/19/22.
//

import UIKit

class YourTextTableViewCell: TextTableViewCell {
    static let identifier: String = "YourTextCell"
    
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
            $0.backgroundColor = .systemYellow
            setupContainerView($0)
            
            $0.addSubview(textMessageLabel)
            setupTextMessageLabel(textMessageLabel)
        }
    }
    
    private func setupContainerView(_ containerView: UIView) {
        containerView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.lessThanOrEqualToSuperview().offset(-8)
        }
    }
    
    private func setupTextMessageLabel(_ label: UILabel) {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
}
