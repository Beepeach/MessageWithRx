//
//  SceneCoordinatorType.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/11/22.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    var currentViewController: UIViewController { get }
    
    @discardableResult
    func transition(to scene: Scene, using style: SceneTransitionStyle) -> Completable
    
    @discardableResult
    func pop(animated: Bool) -> Completable
    
    @discardableResult
    func popToRoot(animated: Bool) -> Completable
    
    @discardableResult
    func pop(to viewController: UIViewController, animated: Bool) -> Completable
}
