//
//  MessageRoomViewModelTests.swift
//  RxMessageTests
//
//  Created by JunHeeJo on 4/28/22.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import RxMessage

class MessageRoomViewModelTests: XCTestCase {
    var sut: MessageRoomViewModel!
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MessageRoomViewModel(messageService: DummyMessageSender())
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }
    
    func testDummyData_whenViewWillAppear_shouldEmit() {
        let messageObservable = sut.messages.asObservable().subscribe(on: scheduler)
        
        let dummyMessageCount = (sut.messageService as! DummyMessageSender).dummyData.value.count
    }
}
