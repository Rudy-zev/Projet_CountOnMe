//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calcul = SimpleCalc()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return calcul.expressionIsCorrect(elements)
    }
    
    var expressionHaveEnoughElement: Bool {
        return calcul.expressionHaveEnoughElement(elements)
    }
    
    var canAddOperator: Bool {
        return calcul.expressionIsCorrect(elements)
    }
    
    var expressionHaveResult: Bool {
        return calcul.expressionHaveResult(textView.text)
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            alertManagement(AlertMessage: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            alertManagement(AlertMessage: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" x ")
        } else {
            alertManagement(AlertMessage: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" / ")
        } else {
            alertManagement(AlertMessage: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Erreur", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Erreur", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        if !expressionHaveResult {
            if !calcul.divisionByZero(operationsToReduce) {
                operationsToReduce = calcul.basicCalcul(operationsToReduce)
                textView.text.append(" = \(operationsToReduce.first!)")
            } else {
                alertManagement(AlertMessage: "La division par 0 est impossible.")
                textView.text = ""
            }
        } else {
            alertManagement(AlertMessage: "Vous avez déja votre résultat.")
        }
       
    }
    
    private func alertManagement(AlertMessage: String) {
        let alertVC = UIAlertController(title: "Erreur", message: AlertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

