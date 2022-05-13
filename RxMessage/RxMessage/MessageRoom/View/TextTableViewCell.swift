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
        self.selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(textMessageLabel)
        
        /* Then의 do를 이용한 코드 예시
        containerView.do {
            $0.addSubview(textMessageLabel)
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(8)
                $0.bottom.trailing.equalToSuperview().offset(-8)
                $0.leading.greaterThanOrEqualToSuperview().offset(8)
            }
        }
        */
        
        setupContainerView()
        setupTextMessageLabel()
    }
    
    private func setupContainerView() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.trailing.equalToSuperview().offset(-8)
            $0.leading.greaterThanOrEqualToSuperview().offset(8)
        }
    }
    
    private func setupTextMessageLabel() {
        textMessageLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
}
