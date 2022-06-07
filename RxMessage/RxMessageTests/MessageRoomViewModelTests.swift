//
//  MessageRoomViewModelTests.swift
//  RxMessageTests
//
//  Created by JunHeeJo on 4/28/22.
//

import XCTest
import RxSwift
import RxBlocking
@testable import RxMessage

class MessageRoomViewModelTests: XCTestCase {
    var sut: MessageRoomViewModel!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var sceneCoordinator: SceneCoordinatorType!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MessageRoomViewModel(messageService: DummyMessageSender())
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        sceneCoordinator = MockSceneCoordinator(window: UIApplication.shared.windows.first!)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        scheduler = nil
        sceneCoordinator = nil
    }
    
    func testDummyData_whenViewWillAppear_shouldEmit() {
        let messageObservable = sut.messages.asObservable().subscribe(on: scheduler)
        
        let dummyMessageCount = (sut.messageService as! DummyMessageSender).dummyData.value.count
    }
}
