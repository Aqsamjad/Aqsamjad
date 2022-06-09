//
//  BecomeMuftiTwoVC.swift
//  myMufti
//
//  Created by Qazi on 14/01/2022.
//

import UIKit

class BecomeMuftiVC: UIViewController {
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var phnNumberView: UIView!
    @IBOutlet weak var phnNmbTF: UITextField!
    @IBOutlet weak var nameTF:UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.layer.cornerRadius = 8
        
        roundView(myView: nameView)
        roundView(myView: phnNumberView)
        
        roundedMainView(myView: mainView)
        phnNmbTF.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nameTF.text = nil
        self.phnNmbTF.text = nil
    }
    //    MARK:- Back Btn Action
    @IBAction func becomeMuftiBackBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    MARK:- BecomeMufti Next Btn Action
    @IBAction func becomeMuftiNextBtnAction(_ sender: Any) {
        if isInfoTextFieldsAreEmpty() {
            // Show alert
            asqa_Alert(message: "Enter Your Name & Phone Number")
        } else {
            if phnNmbTF == textInputMode {
                asqa_Alert(message: "Phone Number is not Valid.")
            } else {
                // Go on Next Screen
                moveToNextEduBecomeMuftiScreen()
                
            }
        }
    }
    //    MARK:- Custom Function Of TextFeild Validation.
    func isInfoTextFieldsAreEmpty() -> Bool {
        if (nameTF.text!.isEmpty || phnNmbTF.text!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    //    MARK:- Custom Function of Phone Number Validation
    // MARK:- Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Become A Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //    MARK:- Custom Function OF Go To The Next Screen
    func moveToNextEduBecomeMuftiScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "BecomeMuftiTwoVC") as! BecomeMuftiTwoVC
        // by Ammar
        destinationViewController.name = nameTF.text!
        destinationViewController.phoneNumber = phnNmbTF.text!
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
//MARK:- Rounded View Custom Function
extension BecomeMuftiVC{
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 0.3
        myView.layer.shadowOffset = CGSize.zero
        myView.layer.shadowRadius = 5.0
        myView.layer.cornerRadius = 8
        myView.layer.shouldRasterize = false
        myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.layer.borderWidth = 0.3
        myView.layer.rasterizationScale = UIScreen.main.scale
    }
    func roundedMainView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 0
    }
}
// MARK: - UITextFieldDelegate
extension BecomeMuftiVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTF {
            //open the picker value
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phnNmbTF {
            var is_check : Bool
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            is_check = string == numberFiltered
            
            if is_check {
                let maxLength = 10
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                is_check = newString.length <= maxLength
            }
            return is_check
        } else {
            return true
        }
    }
    
}
