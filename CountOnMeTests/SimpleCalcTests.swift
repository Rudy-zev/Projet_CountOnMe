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
        let elements = "3 + 3 + 3"
        
        simpleCalcul.basicCalcul(elements) { (data) in
            XCTAssertEqual(data.count, 1)
        }
    }
    
    func testGivenAddition_WhenTappedEqualButton_ThenResult() {
        let elements = "3 + 3"
        
        simpleCalcul.basicCalcul(elements) { (data) in
            XCTAssertEqual(Float(data.first!), 6)
        }
    }
    
    func testGivenSubstraction_WhenTappedEqualButton_ThenResult() {
        let elements = "3 - 3"
        
        simpleCalcul.basicCalcul(elements) { (data) in
            XCTAssertEqual(Float(data.first!), 0)
        }
    }
    
    func testGivenMultiplication_WhenTappedEqualButton_ThenResult() {
        let elements = "3 x 3"
        
        simpleCalcul.basicCalcul(elements) { (data) in
            XCTAssertEqual(Float(data.first!), 9)
        }
    }
    
    func testGivenDivision_WhenTappedEqualButton_ThenResult() {
        let elements = "3 / 3"
        
        simpleCalcul.basicCalcul(elements) { (data) in
            XCTAssertEqual(Float(data.first!), 1)
        }
    }
    
    func testGivenCalculationPriority_WhenTappedEqualButton_ThenResult() {
        let elements = "3 + 3 x 3 + 3 / 3"
        
        simpleCalcul.basicCalcul(elements) { (data) in
            XCTAssertEqual(Float(data.first!), 13)
        }
    }
    
    func testGivenCalculationDivision_WhenTappedEqualButton_ThenResultFloat() {
        let elements = "7 / 2"
        
        simpleCalcul.basicCalcul(elements) { (data) in
            XCTAssertEqual(Float(data.first!), 3.5)
        }
    }
    
    func testGivenCalculation_WhenDivisionBy0_ThenErrorMessage() {
        let elements = "3 / 0"

        simpleCalcul.errorManagementEqualTap(elements, succes: {
            
        }) { (errorMessage) in
            XCTAssertTrue(errorMessage == "La division par 0 est impossible.")
        }
    }
    
    func testGivenLastEntriesIsOperator_WhenAddOperator_ThenError() {
        let elements = "3 /"

        simpleCalcul.expressionIsCorrectShort(elements, succes: {
        
        }) { (errorMessage) in
            XCTAssertTrue(errorMessage == "Un operateur est déja mis !")
        }
        
        simpleCalcul.errorManagementEqualTap(elements, succes: {
            
        }) { (errorMessage) in
            XCTAssertTrue(errorMessage == "Entrez une expression correcte !")
        }
    }
    
    func testGiven3Entries_WhenValideToCalculation_ThenError() {
        let elements = "3"

        simpleCalcul.errorManagementEqualTap(elements, succes: {
            
        }) { (errorMessage) in
            XCTAssertTrue(errorMessage == "Démarrez un nouveau calcul !")
        }
    }
    
    func testGivenCalculEnd_WhenEqualAgain_ThenError() {
        let elements = "3 / 3 = 1"
        var test = false
        
        simpleCalcul.expressionHaveResultShort(elements) {
            test = true
        }
        
        XCTAssertTrue(test)
        
        simpleCalcul.errorManagementEqualTap(elements, succes: {
            
        }) { (errorMessage) in
            XCTAssertTrue(errorMessage == "Vous avez déja votre résultat.")
        }
    }
}
