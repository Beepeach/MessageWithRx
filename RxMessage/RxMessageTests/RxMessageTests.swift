//
//  RxMessageTests.swift
//  RxMessageTests
//
//  Created by JunHeeJo on 4/27/22.
//

import XCTest
import RxTest
import RxBlocking
@testable import RxMessage


class RxMessageTests: XCTestCase {
    var sut: MessageRoomViewController!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        sut = MessageRoomViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try? super.tearDownWithError()
    }
    
    func test_whenBeforeViewWillAppear_shouldCellZero() {
        let cellCount: Int = sut.messageTableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(0, cellCount)
    }
    
    func test_whenViewWillAppear_shouldMessageEmit() {
        // given
        let dummyMessageCount: Int = sut.dummyData.value.count
        
        // when
        sut.viewWillAppear(true)
        
        // then
        let afterCellCount: Int = sut.messageTableView.numberOfRows(inSection: 0)
        XCTAssertEqual(dummyMessageCount, afterCellCount)
    }
    
    func test_whenViewWillAppear_shouldCorrectMessageEmiited() {
        sut.dummyData.accept([Message(type: .text, who: "TestWho", body: "TestText")])
        
        sut.viewWillAppear(true)
        
        let cell = sut.messageTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextTableViewCell
        
        XCTAssertEqual(cell.textMessageLabel.text, sut.dummyData.value.first!.body)
        XCTAssertEqual(cell.containerView.backgroundColor, .red)
    }
}
