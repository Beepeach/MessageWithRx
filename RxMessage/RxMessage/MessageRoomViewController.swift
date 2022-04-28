//
//  MessageRoomViewController.swift
//  RxMessage
//
//  Created by JunHeeJo on 4/26/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class MessageRoomViewController: UIViewController {
    // MARK: Private properties
    private let bag: DisposeBag = DisposeBag()
   
    
    // MARK: Properties
    var messageTableView: UITableView = UITableView().then {
        $0.backgroundColor = .systemTeal
        $0.separatorStyle = .none
        
        $0.register(TextTableViewCell.classForCoder(), forCellReuseIdentifier: TextTableViewCell.identifier)
        $0.register(ImageTableViewCell.classForCoder(), forCellReuseIdentifier: ImageTableViewCell.identifier)
    }
    
    
    // MARK: VCLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindMessageTableView()
    }
    
    private func setupUI() {
        setupMessageTableViewUI()
    }
    
    private func setupMessageTableViewUI() {
        view.addSubview(messageTableView)
        
        messageTableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func bindMessageTableView() {
        rx.viewWillAppear
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.dummyData
            }.bind(to: messageTableView.rx.items) { tableView, index, message in
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                switch message.type {
                case .text:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as? TextTableViewCell else {
                        return TextTableViewCell()
                    }
                    
                    cell.textMessageLabel.text = message.body
                    
                    return cell
                case .image:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else {
                        return ImageTableViewCell()
                    }
                    cell.messageImageView.image = self.getImage(from: message.body)
                    
                    return cell
                }
            }
            .disposed(by: bag)
    }
    
    private func getImage(from url: String) -> UIImage? {
        guard let url = URL(string: url) else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return UIImage(data: data)
    }
}


// MARK: - Previews
#if DEBUG
import SwiftUI

struct MessageRoomVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return MessageRoomViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct MessageRoomPreviewProvider: PreviewProvider {
    static var previews: some View {
        MessageRoomVCRepresentable()
    }
}
#endif

