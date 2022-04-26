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
    private let bag: DisposeBag = DisposeBag()
    
    private let dummyData: Observable<[Message]> = Observable.of([
        Message(type: .text, who: "me", body: "Hello RxSwift!!"),
        Message(type: .image, who: "you", body: "imageURL?? 뭐가 와야할까"),
        Message(type: .text, who: "me", body: "Good")
    ])
    
    private var messageTableView: UITableView = UITableView().then {
        $0.backgroundColor = .systemTeal
    }
    
    private var cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    
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
        dummyData.bind(to: messageTableView.rx.items) { tableView, index, message in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            cell.textLabel?.text = message.body
            
            return cell
        }
        .disposed(by: bag)
    }
}



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

