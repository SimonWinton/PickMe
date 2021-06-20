//
//  TouchableViewTests.swift
//  Pick MeTests
//
//  Created by Simon Winton on 14/06/2021.
//  Copyright © 2021 Simon Winton. All rights reserved.
//
@testable import Pick_Me
import XCTest

class ConcreteTouchableViewTests: XCTestCase {

    var sut: ConcreteTouchableView!
    
    override func setUp() {
        sut = ConcreteTouchableView(frame: CGRect(origin: .zero,
                                          size: CGSize(width: 100, height: 100)))
    }

    override func tearDown() {
        sut = nil
    }

    func test_Init_SetsIsMultipleTouchEnabledToTrue() {
        XCTAssertTrue(sut.isMultipleTouchEnabled)
    }
    
    func test_TouchesBegan_OneTouch_AddsCircleView() {
        let touches: Set = [UITouch()]
        sut.touchesBegan(touches, with: nil)
        let views = sut.subviews.filter({$0 is TouchSpotView})
        XCTAssertEqual(views.count, touches.count)
    }
    
    func test_TouchesBegan_MultipleTouches_AddsCircleView() {
        let touches: Set = [UITouch(), UITouch(), UITouch()]
        sut.touchesBegan(touches, with: nil)
        let views = sut.subviews.filter({$0 is TouchSpotView})
        XCTAssertEqual(views.count, touches.count)
    }
    
    func test_Update_RemovesCircleViewsWhenDone() {
        let touches: Set = [UITouch(), UITouch(), UITouch()]
        sut.touchesBegan(touches, with: nil)
        
        let views = sut.subviews.filter({$0 is TouchSpotView})
        XCTAssertEqual(views.count, touches.count)
    }

}
