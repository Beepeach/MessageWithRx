//
//  SceneTransitionError.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/11/22.
//

import Foundation

enum SceneTransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
