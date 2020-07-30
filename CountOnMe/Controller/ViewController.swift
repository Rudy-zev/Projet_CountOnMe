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
    
    var elements: String {
        return textView.text
    }

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* calcul.delegate = self */ 
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        calcul.expressionHaveResult(textView.text) { (expressionHaveResult) in
            if expressionHaveResult {
                textView.text = ""
            }
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calcul.expressionIsCorrect(elements) { (expressionIsCorrect) in
            if expressionIsCorrect {
                textView.text.append(" + ")
            } else {
                alertManagement(AlertMessage: "Un operateur est déja mis !")
            }
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calcul.expressionIsCorrect(elements) { (expressionIsCorrect) in
            if expressionIsCorrect {
                textView.text.append(" - ")
            } else {
                alertManagement(AlertMessage: "Un operateur est déja mis !")
            }
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calcul.expressionIsCorrect(elements) { (expressionIsCorrect) in
            if expressionIsCorrect {
                textView.text.append(" x ")
            } else {
                alertManagement(AlertMessage: "Un operateur est déja mis !")
            }
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calcul.expressionIsCorrect(elements) { (expressionIsCorrect) in
            if expressionIsCorrect {
                textView.text.append(" / ")
            } else {
                alertManagement(AlertMessage: "Un operateur est déja mis !")
            }
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        /* calcul.expressionIsCorrect(elements) { (expressionIsCorrect) in
            guard expressionIsCorrect else {
                let alertVC = UIAlertController(title: "Erreur", message: "Entrez une expression correcte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)
            }
        }
        
        calcul.expressionHaveEnoughElement(elements) { (expressionHaveEnoughElement) in
            guard expressionHaveEnoughElement else {
                let alertVC = UIAlertController(title: "Erreur", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)
            }
        } */
        
        // Create local copy of operations
        //let operationsToReduce = elements
        
        calcul.expressionIsCorrect(elements) { (expressionIsCorrect) in
            if expressionIsCorrect {
                calcul.expressionHaveEnoughElement(elements) { (expressionHaveEnoughElement) in
                    if expressionHaveEnoughElement {
                        calcul.expressionHaveResult(textView.text) { (expressionHaveResult) in
                            if !expressionHaveResult {
                                calcul.divisionByZero(elements) { (divisionByZero) in
                                    if !divisionByZero {
                                        calcul.basicCalcul(elements) { (elements) in
                                            textView.text.append(" = \(elements.first!)")
                                        }
                                    } else {
                                        alertManagement(AlertMessage: "La division par 0 est impossible.")
                                        textView.text = ""
                                    }
                                }
                            } else {
                                alertManagement(AlertMessage: "Vous avez déja votre résultat.")
                            }
                        }
                    } else {
                        alertManagement(AlertMessage: "Démarrez un nouveau calcul !")
                    }
                }
            } else {
                alertManagement(AlertMessage: "Entrez une expression correcte !")
            }
        }
        
        
       
    }
    
    private func alertManagement(AlertMessage: String) {
        let alertVC = UIAlertController(title: "Erreur", message: AlertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

// MARK: - Implement delegate
/* extension ViewController: CalculDelagate {
    func basicCalculEnd(_ elements: [String]) {
        textView.text.append(" = \(elements.first!)")
    }  
} */

