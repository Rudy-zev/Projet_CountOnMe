//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Rudy on 15/07/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class SimpleCalc {
    public func expressionIsCorrect(_ elements: [String]) ->  Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    public func expressionHaveEnoughElement(_ elements: [String]) ->  Bool {
        return elements.count >= 3
    }
    
    public func expressionHaveResult(_ text: String!) ->  Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    public func basicCalcul(_ elements: [String]) ->  [String] {
        var operationsToReduce = elements
        
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
        return operationsToReduce
    }
    
    // Use to prevent division by zero
    public func divisionByZero(_ elements: [String]) ->  Bool {
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
