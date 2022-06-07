//
//  MockSceneCoordinator.swift
//  RxMessageTests
//
//  Created by JunHeeJo on 6/7/22.
//

import Foundation
import RxSwift
@testable import RxMessage

class MockSceneCoordinator: SceneCoordinatorType {
    var lastScene: Scene!
    var lastStyle: SceneTransitionStyle!
    var lastViewModel: CommonViewModel!
    
    func transition(to scene: Scene, using style: SceneTransitionStyle) -> Completable {
        lastScene = scene
        lastStyle = style
        lastViewModel = scene.associatedViewModel
    }
}
