//
//  CommonViewModel.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/11/22.
//

import Foundation
import RxSwift

class CommonViewModel: NSObject {
    let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}
