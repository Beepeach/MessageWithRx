//
//  SceneCoordinator.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/11/22.
//

import UIKit
import RxSwift


class SceneCoordinator: SceneCoordinatorType {
    private var window: UIWindow
    private let bag: DisposeBag = DisposeBag()
    
    var currentViewController: UIViewController
    
    static func getActualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first ?? UIViewController()
        } else {
            return viewController
        }
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: SceneTransitionStyle) -> Completable {
        // Never가 아니라 Void면 asCompletable이 안된다.
        // 그런데 Never로하면 didShow에 바인딩이 안된다.
        // 해결책은?? Void로하고 ignoreElement하고 completable로 바꾸자
        let subject = PublishSubject<Void>()
        let viewController = scene.instantiate()
        
        switch style {
        case .root:
            currentViewController = SceneCoordinator.getActualViewController(for: viewController)
            window.rootViewController = currentViewController
            subject.onCompleted()
            
        case .push(let animated):
            guard let navigationController = currentViewController.navigationController else {
                subject.onError(SceneTransitionError.navigationControllerMissing)
                break
            }
            
            _ = navigationController.rx.didShow
                .map { _ in }
                .bind(to: subject)
            
            navigationController.pushViewController(viewController, animated: animated)
            currentViewController = SceneCoordinator.getActualViewController(for: viewController)
            subject.onCompleted()
            
        case .modal(let animated):
            // fullScreen을 하지 않으면 이전 VC를 어떻게 저장해야할까?
            viewController.modalPresentationStyle = .fullScreen
            currentViewController.present(viewController, animated: animated) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.getActualViewController(for: viewController)
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    
    @discardableResult
    func pop(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        if let presentingVC = currentViewController.presentingViewController {
            currentViewController.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.getActualViewController(for: presentingVC)
                subject.onCompleted()
            }
        } else if let navigationController = currentViewController.navigationController {
            _ = navigationController.rx.didShow
                .map { _ in }
                .bind(to: subject)
            
            guard let _ = navigationController.popViewController(animated: animated) else {
                subject.onError(SceneTransitionError.cannotPop)
                return subject.ignoreElements().asCompletable()
            }
            
            currentViewController = SceneCoordinator.getActualViewController(for: navigationController.viewControllers.last ?? UIViewController())
        } else {
            subject.onError(SceneTransitionError.cannotPop)
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    @discardableResult
    func popToRoot(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        if let navigationController = currentViewController.navigationController {
            _ = navigationController.rx.didShow
                .map { _ in }
                .bind(to: subject)
            
            guard let _ = navigationController.popToRootViewController(animated: animated) else {
                subject.onError(SceneTransitionError.cannotPop)
                return subject.ignoreElements().asCompletable()
            }
            
            currentViewController = SceneCoordinator.getActualViewController(for:  navigationController.viewControllers.first ?? UIViewController())
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    @discardableResult
    func pop(to viewController: UIViewController, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        if let navigationController = currentViewController.navigationController {
            _ = navigationController.rx.didShow
                .map { _ in }
                .bind(to: subject)
            
            guard let _ = navigationController.popToViewController(viewController, animated: animated) else {
                subject.onError(SceneTransitionError.cannotPop)
                return subject.ignoreElements().asCompletable()
            }
            currentViewController = SceneCoordinator.getActualViewController(for: navigationController.viewControllers.last ?? UIViewController())
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    required init(window: UIWindow) {
        self.window = window
        self.currentViewController = window.rootViewController ?? UIViewController()
    }
}
