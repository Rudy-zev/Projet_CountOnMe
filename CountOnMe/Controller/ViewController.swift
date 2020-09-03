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
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        calcul.errorManagementNumberTap(elements) {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calcul.errorManagementOperatorTap(elements, success: {
            textView.text.append(" + ")
        }) { (errorCode) in
            alertManagement(errorCode: errorCode)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calcul.errorManagementOperatorTap(elements, success: {
            textView.text.append(" - ")
        }) { (errorCode) in
            alertManagement(errorCode: errorCode)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calcul.errorManagementOperatorTap(elements, success: {
            textView.text.append(" x ")
        }) { (errorCode) in
            alertManagement(errorCode: errorCode)
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calcul.errorManagementOperatorTap(elements, success: {
            textView.text.append(" / ")
        }) { (errorCode) in
            alertManagement(errorCode: errorCode)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        calcul.errorManagementEqualTap(elements, success: {
            calcul.basicCalcul(elements) { (elements) in
                textView.text.append(" = \(elements.first!)")
            }
        }) { (errorCode) in
            alertManagement(errorCode: errorCode)
        }
     
    }
    
    private func alertManagement(errorCode: String) {
        var alertMessage: String
        
        switch errorCode {
            case "code01":
                alertMessage = "Un operateur est déja mis !"
            case "code02":
                alertMessage = "Entrez une expression correcte !"
            case "code03":
                alertMessage = "Démarrez un nouveau calcul !"
            case "code04":
                alertMessage = "Vous avez déja votre résultat."
            case "code05":
                alertMessage = "La division par 0 est impossible."
            default:
                alertMessage = "error"
        }
        
        let alertVC = UIAlertController(title: "Erreur", message: alertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}
