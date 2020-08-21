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
        
        calcul.expressionHaveResultShort(elements) {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calcul.expressionIsCorrectShort(elements, succes: {
            textView.text.append(" + ")
        }) { (errorMessage) in
            alertManagement(AlertMessage: errorMessage)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calcul.expressionIsCorrectShort(elements, succes: {
            textView.text.append(" - ")
        }) { (errorMessage) in
            alertManagement(AlertMessage: errorMessage)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calcul.expressionIsCorrectShort(elements, succes: {
            textView.text.append(" x ")
        }) { (errorMessage) in
            alertManagement(AlertMessage: errorMessage)
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calcul.expressionIsCorrectShort(elements, succes: {
            textView.text.append(" / ")
        }) { (errorMessage) in
            alertManagement(AlertMessage: errorMessage)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        calcul.errorManagementEqualTap(elements, succes: {
            calcul.basicCalcul(elements) { (elements) in
                textView.text.append(" = \(elements.first!)")
            }
        }) { (errorMessage) in
            alertManagement(AlertMessage: errorMessage)
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

