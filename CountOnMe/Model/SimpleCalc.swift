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
    
    public func expressionIsCorrectShort(_ elements : String, succes: (() -> Void), error: ((_ errorMessage : String) -> Void)){
        let operationsToReduce = setUpArray(elements)
        
        if operationsToReduce.last != "+" && operationsToReduce.last != "-" && operationsToReduce.last != "x" && operationsToReduce.last != "/" {
            succes()
        } else {
            error("Un operateur est déja mis !")
        }
    }
    
    public func expressionHaveResultShort(_ elements : String, succes: (() -> Void)){
        if elements.firstIndex(of: "=") != nil {
            succes()
        }
    }
    
    public func errorManagementEqualTap(_ elements : String, succes: (() -> Void), error: ((_ errorMessage : String) -> Void)){
        let operationsToReduce = setUpArray(elements)
        
        if expressionIsCorrect(operationsToReduce) {
            if expressionHaveEnoughElement(operationsToReduce) {
                if !expressionHaveResult(elements) {
                    if !divisionByZero(operationsToReduce) {
                        succes()
                    } else {
                        error("La division par 0 est impossible.")
                    }
                } else {
                    error("Vous avez déja votre résultat.")
                }
            } else {
                error("Démarrez un nouveau calcul !")
            }
        } else {
            error("Entrez une expression correcte !")
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
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        callback(operationsToReduce)
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
                
                let left = Float(operationsToReduce[index! - 1])!
                let right = Float(operationsToReduce[index! + 1])!
                    
                let result: Float
                
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
