//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Rudy on 15/07/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
/*protocol CalculDelagate {
    func basicCalculEnd(_ elements: [String])
}*/

class SimpleCalc {
    /*var delegate: CalculDelagate?*/
    
    private func setUpArray(_ elementsText: String) -> [String] {
        return elementsText.split(separator: " ").map { "\($0)" }
    }
    
    public func expressionIsCorrect(_ elements: String, callbacks: ((_ expressionIsCorrect: Bool) -> Void)) {
        let operationsToReduce = setUpArray(elements)
         callbacks(operationsToReduce.last != "+" && operationsToReduce.last != "-" && operationsToReduce.last != "x" && operationsToReduce.last != "/")
    }
    
    public func expressionHaveEnoughElement(_ elements: String, callbacks: ((_ expressionHaveEnoughElement: Bool) -> Void)) {
        let operationsToReduce = setUpArray(elements)
        callbacks(operationsToReduce.count >= 3)
    }
    
    public func expressionHaveResult(_ text: String!, callbacks: ((_ expressionHaveResult: Bool) -> Void)) {
        callbacks(text.firstIndex(of: "=") != nil)
    }
    
    // Use to prevent division by zero
    public func divisionByZero(_ elements: String, callbacks: ((_ divisionByZero: Bool) -> Void)) {
        let operationsToReduce = setUpArray(elements)
        var test = false
        for item in operationsToReduce {
            if item == "/" {
                let index: Int!
                index = operationsToReduce.firstIndex(of: "/")
                let right = Int(operationsToReduce[index! + 1])!
                
                if right == 0 {
                    test = true
                }
            }
        }
        callbacks(test)
    }
    
    public func basicCalcul(_ elements: String, callbacks: ((_ elements: [String]) -> Void)) {
       var operationsToReduce = setUpArray(elements)
        
        operationsToReduce = priorityCalcul(operationsToReduce)
        
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
                         
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        callbacks(operationsToReduce)
        /* delegate?.basicCalculEnd(operationsToReduce) */
    }
    

    
    // Method used to manage calculation priorities
    private func priorityCalcul(_ elements: [String]) ->  [String] {
        var operationsToReduce = elements

        for element in operationsToReduce {
            if element == "x" || element == "/" {
                let index: Int!
                if element == "x" {
                    index = operationsToReduce.firstIndex(of: "x")
                } else {
                    index = operationsToReduce.firstIndex(of: "/")
                }
                
                let left = Int(operationsToReduce[index! - 1])!
                let right = Int(operationsToReduce[index! + 1])!
                    
                let result: Int
                
                if element == "x" {
                    result = left * right
                } else {
                    result = left / right
                }
                
                operationsToReduce[index!] = "\(result)"
                operationsToReduce.remove(at: index! - 1)
                operationsToReduce.remove(at: index!)
            }
        }
        return operationsToReduce
    }
}
