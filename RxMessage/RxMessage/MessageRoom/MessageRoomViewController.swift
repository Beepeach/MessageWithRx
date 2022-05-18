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
    private var messageTableView: UITableView = MessageRoomViewController.makeMessageTableView()
    private let inputContainerView: UIView = MessageRoomViewController.makeInputContainerView()
    private let inputField: UITextField = MessageRoomViewController.makeInputField()
    private let sendButton: UIButton = MessageRoomViewController.makeSendButton()

    
    
    // MARK: Properties
    var viewModel: MessageRoomViewModel?
    
    
    // MARK: Binding
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
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
                    
                    return cell
                }
            }.disposed(by: bag)
        
        // 여기서 바로 이미지를 가져올 수는 없을까??
        
        
        messageTableView.rx.modelSelected(Message.self)
            .compactMap { self.getImage(from: $0.body) }
            .bind(to: viewModel.detailImageAction.inputs)
            .disposed(by: bag)
        
        //        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
        //            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
        //            .map { $0.height }
        
        
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
    private func setupUI() {
        setupInputContainerView()
        setupMessageTableViewUI()
    }
    
    private func setupMessageTableViewUI() {
        view.addSubview(messageTableView)
        
        messageTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(inputContainerView.snp.top)
        }
    }
    
    private func setupInputContainerView() {
        view.addSubview(inputContainerView)
        
        inputContainerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        inputContainerView.do {
            setupSendButton(in: $0)
            setupInputField(in: $0)
        }
    }
    
    private func setupSendButton(in container: UIView) {
        container.addSubview(sendButton)
        
        sendButton.snp.makeConstraints {
            $0.height.width.equalTo(33)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setupInputField(in container: UIView) {
        container.addSubview(inputField)
        
        inputField.snp.makeConstraints {
            $0.centerY.equalTo(sendButton)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-10)
        }
    }
    static func makeMessageTableView() -> UITableView {
        let tableView = UITableView().then {
            $0.register(TextTableViewCell.classForCoder(), forCellReuseIdentifier: TextTableViewCell.identifier)
            $0.register(ImageTableViewCell.classForCoder(), forCellReuseIdentifier: ImageTableViewCell.identifier)
            
            $0.separatorStyle = .none
            $0.contentInset.bottom = 60
        }
        
        return tableView
    }
    
    static func makeInputContainerView() -> UIView {
        let containerView = UIView().then {
            $0.backgroundColor = .systemGray5
        }
        
        return containerView
    }
    
    static func makeInputField() -> UITextField {
        let textField = UITextField().then {
            $0.borderStyle = .roundedRect
            $0.placeholder = "메시지를 입력하세요."
            $0.textColor = .black
        }
        
        return textField
    }
    
    static func makeSendButton() -> UIButton {
        let button = UIButton().then {
            $0.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        }
        
        return button
    }
}



// MARK: - Previews

#if DEBUG
import SwiftUI

struct MessageRoomVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let messageService = DummyMessageSender()
        let sceneCoordinator = SceneCoordinator(window: window)
        let messageRoomViewModel = MessageRoomViewModel(messageService: messageService, sceneCoordinator: sceneCoordinator)
        let messageRoomScene = Scene.messageRoom(messageRoomViewModel)
        
        return messageRoomScene.instantiate()
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

