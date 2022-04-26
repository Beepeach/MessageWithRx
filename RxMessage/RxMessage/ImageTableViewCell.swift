//
//  ImageTableViewCell.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import UIKit
import Then
import SnapKit

class ImageTableViewCell: UITableViewCell {
    static let identifier: String = "ImageCell"
    
    var containerView: UIView = UIView().then {
        $0.backgroundColor = .systemYellow
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    var messageImageView: UIImageView = UIImageView().then {
        $0.tintColor = .systemGray
        $0.contentMode = .scaleAspectFill
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
        contentView.addSubview(containerView)
        containerView.addSubview(messageImageView)
        
        setupContainerView()
        setupMessageImageView()
    }
    
    private func setupContainerView() {
        containerView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().offset(8)
            $0.bottom.trailing.equalToSuperview().offset(-8)
            $0.leading.greaterThanOrEqualToSuperview().offset(8)
            $0.height.equalTo(200)
            $0.width.equalTo(300)
        }
    }
    
    private func setupMessageImageView() {
        messageImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
