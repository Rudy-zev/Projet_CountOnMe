//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    var simpleCalcul: SimpleCalc!
    
    func testGiven6Elements_WhenTappedEqualButton_ThenLoopAnd0Elements() {
        let elements = ["3", "+", "3", "+", "3"]
        
        simpleCalcul.calcul(elements)
        
        XCTAssertEqual(elements.count, 0)
    }
    
    func testGivenAddition_WhenTappedEqualButton_ThenResult() {
        
    }
    
    func testGivenSubstraction_WhenTappedEqualButton_ThenResult() {
        
    }
    
    func testGivenMultiplication_WhenTappedEqualButton_ThenResult() {
        
    }
    
    func testGivenDivision_WhenTappedEqualButton_ThenResult() {
        
    }
    
    func testGivenCalculationPriority_WhenTappedEqualButton_ThenResult() {
        
    }

}
