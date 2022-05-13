//
//  SceneCoordinatorType.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/11/22.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    var currentViewController: UIViewController { get }
    
    init(window: UIWindow)
    
    @discardableResult
    func transition(to scene: Scene, using style: SceneTransitionStyle) -> Completable
    
    @discardableResult
    func pop(animated: Bool) -> Completable
    
    @discardableResult
    func popToRoot(animated: Bool) -> Completable
    
    @discardableResult
    func pop(to viewController: UIViewController, animated: Bool) -> Completable
}
