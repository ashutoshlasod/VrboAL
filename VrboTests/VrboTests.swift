//
//  VrboTests.swift
//  VrboTests
//
//  Created by Ashutosh Lasod on 06/11/20.
//  Copyright © 2020 Ashutosh Lasod. All rights reserved.
//

import XCTest
@testable import Vrbo

class VrboTests: XCTestCase {
    
    var sut: OnBoardingVM!
    
    override func setUp() {
        sut = OnBoardingVM()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testTotalCount() {
        let count: Int = sut.getTotalCount()
        XCTAssertEqual(count, 4, "Onboarding screen count is different")
    }
    
    func testOnbordingModel() {
        let count: Int = sut.getTotalCount()
        for i in 0..<count {
            let onBoardingModel: OnBoardingPageModel? = sut.getOnBoardScreenModel(for: i)
            XCTAssertNotNil(onBoardingModel, "required model is nil at index \(i)")
        }
    }

}
