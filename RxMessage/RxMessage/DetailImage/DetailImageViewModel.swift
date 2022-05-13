//
//  ImageDetailViewModel.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/12/22.
//

import UIKit.UIImage
import RxSwift
import RxRelay
import Action

class DetailImageViewModel: CommonViewModel {
    var image: BehaviorRelay<UIImage> = BehaviorRelay(value: UIImage(named: "image") ?? UIImage())
    // MARK: Input
    
    // MARK: Output
    
    
    // MARK: Service
    
    
    // MARK: Init
    init(image: UIImage, sceneCoordinator: SceneCoordinatorType) {
        self.image.accept(image)
        super.init(sceneCoordinator: sceneCoordinator)
    }
    
    // MARK: Action
    lazy var dismissAction: CocoaAction = CocoaAction { [weak self] in
        guard let self = self else { return Observable.empty() }
        return self.sceneCoordinator.pop(animated: true).asObservable().map { _ in }
    }
}
