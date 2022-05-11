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
import Action

class MessageRoomViewController: UIViewController, ViewModelBindableType {
    
    // MARK: Private properties
    private let bag: DisposeBag = DisposeBag()
    
    private let zoomAction: CocoaAction = Action {
        print("Zoom!!")
        return Observable.empty()
    }
    private var messageTableView: UITableView = MessageRoomViewController.makeMessageTableView()
    
    
    // MARK: Properties
    var viewModel: MessageRoomViewModel!
    
    
    // MARK: Binding
    func bindViewModel() {
        rx.viewWillAppear
            .bind(to: viewModel.viewWillAppearSubject)
            .disposed(by: bag)
        
        viewModel.messages
            .drive(messageTableView.rx.items) { tableView, index, message in
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
                    
                    
                    cell.zoomInButton.rx
                        .bind(to: self.zoomAction) { _ in }
                    
                    return cell
                }
            }.disposed(by: bag)
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
    
    
    // MARK: VCLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        messageTableView.separatorStyle = .none
    }
}


extension MessageRoomViewController {
    class func makeMessageTableView() -> UITableView {
        let tableView = UITableView().then {
            $0.backgroundColor = .systemTeal
            
            $0.register(TextTableViewCell.classForCoder(), forCellReuseIdentifier: TextTableViewCell.identifier)
            $0.register(ImageTableViewCell.classForCoder(), forCellReuseIdentifier: ImageTableViewCell.identifier)
            
            $0.separatorStyle = .none
        }
        
        return tableView
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
}

// MARK: - Previews
/*
 #if DEBUG
 import SwiftUI
 
 struct MessageRoomVCRepresentable: UIViewControllerRepresentable {
 func makeUIViewController(context: Context) -> some UIViewController {
 let viewModel = MessageRoomViewModel(messageService: DummyMessageSender(), sceneCoordinator: SceneCoordinator(window: <#T##UIWindow#>))
 return MessageRoomViewController(viewModel: viewModel)
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
 */
