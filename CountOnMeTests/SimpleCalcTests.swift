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
    
    override func setUp() {
        super.setUp()
        simpleCalcul = SimpleCalc()
    }
    
    func testGiven6Elements_WhenTappedEqualButton_ThenLoopAnd0Elements() {
        var elements = ["3", "+", "3", "+", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(elements.count, 1)
    }
    
    func testGivenAddition_WhenTappedEqualButton_ThenResult() {
        var elements = ["3", "+", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 6)
    }
    
    func testGivenSubstraction_WhenTappedEqualButton_ThenResult() {
        var elements = ["3", "-", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 0)
    }
    
    func testGivenMultiplication_WhenTappedEqualButton_ThenResult() {
        var elements = ["3", "x", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 9)
    }
    
    func testGivenDivision_WhenTappedEqualButton_ThenResult() {
        var elements = ["3", "%", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 1)
    }
    
    func testGivenCalculationPriority_WhenTappedEqualButton_ThenResult() {
        var elements = ["3", "+", "3", "x", "3", "+", "3", "%", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 13)
    }
    
    func testGivenCalculation_WhenDivisionBy0_ThenErrorMessage() {
        let elements = ["3", "%", "0"]
        
        XCTAssertTrue(simpleCalcul.divisionByZero(elements))
    }
    
    func testGivenLastEntriesIsOperator_WhenAddOperator_ThenError() {
        let elements = ["3", "%"]
        
        XCTAssertFalse(simpleCalcul.expressionIsCorrect(elements))
    }
    
    func testGiven3Entries_WhenValideToCalculation_ThenError() {
        let elements = ["3", "%"]
        
        XCTAssertFalse(simpleCalcul.expressionHaveEnoughElement(elements))
    }
    
    func testGivenCalculEnd_WhenEqualAgain_ThenError() {
        let elements = "3 % 3 = 1"
               
        XCTAssertTrue(simpleCalcul.expressionHaveResult(elements))
        
    }
}
