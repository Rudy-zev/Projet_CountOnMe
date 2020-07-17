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
        simpleCalcul = SimpleCalc()
        var elements = ["3", "+", "3", "+", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(elements.count, 1)
    }
    
    func testGivenAddition_WhenTappedEqualButton_ThenResult() {
        simpleCalcul = SimpleCalc()
        var elements = ["3", "+", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 6)
    }
    
    func testGivenSubstraction_WhenTappedEqualButton_ThenResult() {
        simpleCalcul = SimpleCalc()
        var elements = ["3", "-", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 0)
    }
    
    func testGivenMultiplication_WhenTappedEqualButton_ThenResult() {
        simpleCalcul = SimpleCalc()
        var elements = ["3", "x", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 9)
    }
    
    func testGivenDivision_WhenTappedEqualButton_ThenResult() {
        simpleCalcul = SimpleCalc()
        var elements = ["3", "%", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 1)
    }
    
    func testGivenCalculationPriority_WhenTappedEqualButton_ThenResult() {
        simpleCalcul = SimpleCalc()
        var elements = ["3", "+", "3", "x", "3", "+", "3", "%", "3"]
        
        elements = simpleCalcul.basicCalcul(elements)
        
        XCTAssertEqual(Int(elements.first!), 13)
    }

}
