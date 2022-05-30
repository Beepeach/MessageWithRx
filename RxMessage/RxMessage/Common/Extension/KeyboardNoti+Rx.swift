//
//  KeyboardNoti+Rx.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/30/22.
//

import Foundation

// TODO: - iOS 15 이상부터는 이 코드가 필요없게 됐다.

/*
let keyboardHideNoti = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
    .map { _ -> CGFloat in 0 }
let keyboardShowNoti = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
    .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
    .map { $0.height }

Observable.merge(keyboardHideNoti, keyboardShowNoti)
    .bind { height in
        UIView.animate(withDuration: 0) {
            self.inputContainerView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(height)
            }
    
            // TableView도 함께 올라가는 모습으로 하려면 어떻게 하지..?
            self.messageTableView.snp.updateConstraints {
                $0.bottom.equalTo(self.inputContainerView.snp.top)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    .disposed(by: bag)
 */
