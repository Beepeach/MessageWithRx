//
//  ViewWillDisAppear+Rx.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/12/22.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var viewWillDisappear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillDisappear)).map { _ in }
        
        return ControlEvent(events: source)
    }
}


extension Reactive where Base: UIViewController {
    public var viewDidDisappear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidDisappear)).map { _ in }
        
        return ControlEvent(events: source)
    }
}
