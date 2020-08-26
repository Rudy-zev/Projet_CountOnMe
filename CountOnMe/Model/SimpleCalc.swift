//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Rudy on 15/07/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class SimpleCalc {
    
    private func setUpArray(_ elementsText: String) -> [String] {
        return elementsText.split(separator: " ").map { "\($0)" }
    }
    
    public func errorManagementOperatorTap(_ elements : String, success: (() -> Void), error: ((_ errorCode : String) -> Void)){
        let operationsToReduce = setUpArray(elements)
        
       if expressionIsCorrect(operationsToReduce) {
            success()
        } else {
            error("code01")
        }
    }
    
    public func errorManagementNumberTap(_ elements : String, success: (() -> Void)){
        if expressionHaveResult(elements) {
            success()
        }
    }
    
    public func errorManagementEqualTap(_ elements : String, success: (() -> Void), error: ((_ errorCode : String) -> Void)){
        let operationsToReduce = setUpArray(elements)
        
        if expressionIsCorrect(operationsToReduce) {
            if expressionHaveEnoughElement(operationsToReduce) {
                if !expressionHaveResult(elements) {
                    if !divisionByZero(operationsToReduce) {
                        success()
                    } else {
                        error("code05")
                    }
                } else {
                    error("code04")
                }
            } else {
                error("code03")
            }
        } else {
            error("code02")
        }
    }
    
    private func expressionIsCorrect(_ elements: [String]) -> Bool {
         return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    private func expressionHaveEnoughElement(_ elements: [String]) -> Bool {
        return elements.count >= 3
    }
    
    private func expressionHaveResult(_ elementsString: String) -> Bool  {
        return elementsString.firstIndex(of: "=") != nil
    }
    
    // Use to prevent division by zero
    private func divisionByZero(_ elements: [String]) -> Bool  {
        var test = false
        for item in elements {
            if item == "/" {
                let index: Int!
                index = elements.firstIndex(of: "/")
                let right = Int(elements[index! + 1])!
                
                if right == 0 {
                    test = true
                }
            }
        }
        return test
    }
    
    public func basicCalcul(_ elements: String, callback: ((_ elements: [String]) -> Void)) {
        
       var operationsToReduce = setUpArray(elements)
        
        operationsToReduce = priorityCalcul(operationsToReduce)
        
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
                         
            let result: Float
            switch operand {
                case "+": result = left + right
                case "-": result = left - right
                default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(result.clean, at: 0)
        }

        callback(operationsToReduce)
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
                
                let left = Float(operationsToReduce[index! - 1])!
                let right = Float(operationsToReduce[index! + 1])!
                    
                let result: Float
                
                if element == "x" {
                    result = left * right
                } else {
                    result = left / right
                }
                
                operationsToReduce[index!] = result.clean
                operationsToReduce.remove(at: index! - 1)
                operationsToReduce.remove(at: index!)
            }
        }
        
        return operationsToReduce
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
