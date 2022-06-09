//
//  AskQuestionVC.swift
//  myMufti
//
//  Created by Qazi on 05/01/2022.
//

import UIKit
import SwiftSpinner
import Alamofire

enum QuestionOption {
    case none
    case option1
    case option2
}


class AskQuestionVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var submitQuestionBtn: UIButton!
    @IBOutlet weak var opt1Btn: UIButton!
    @IBOutlet weak var opt2Btn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var trueBtn: UIButton!
    @IBOutlet weak var falseBtn: UIButton!
    @IBOutlet weak var timeLimitView: UIView!
    @IBOutlet weak var timeLimitTF: UITextField!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var questiontTF: UITextField!
    @IBOutlet weak var questionTitleTF: UITextField!
    @IBOutlet weak var switchOnOf: UISwitch!
    
    var selectedOption = QuestionOption.none
    var selectedIndex = [Int]()
    var selectedCategories = [String]()
    var myPickerView : UIPickerView!
    
    var arrayMinutes = ["0", "1", "2", "3" , "4", "5", "6" , "7", "8", "9" , "10", "11", "12", "13" , "14", "15", "16" , "17", "18", "19" , "20", "21", "22", "23" , "24", "25", "26" , "27", "28", "29" , "30","31", "32", "33" , "34", "35", "36" , "37", "38", "39" , "40", "41", "42", "43" , "44", "45", "46" , "47", "48", "49" , "50", "51", "52", "53" , "54", "55", "56" , "57", "58", "59" , "60"]
    
    
    //MARK: -  Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedMainView(myView: mainView)
        questiontTF.layer.borderWidth = 1
        questiontTF.layer.borderColor = UIColor.gray.cgColor
        roundTextView(textFeild: questionTitleTF)
        roundTextView(textFeild: questiontTF)
        roundView(myView: categoriesView)
        roundView(myView: timeLimitView)
        submitQuestionBtn.layer.cornerRadius = 8
        yesBtn.layer.cornerRadius = 8
        noBtn.layer.cornerRadius = 8
        trueBtn.layer.cornerRadius = 8
        falseBtn.layer.cornerRadius = 8
        timeLimitTF.delegate = self
        
    }
    
    //MARK: -  Buttons Action
        /// submeit button action.
    @IBAction func submitBtn(_ sender: UIButton) {
        
        if isTextFeildsAreEmpty() {
            asqa_Alert(message: "Please Enter Your Question")
        } else {
            if selectedOption == .none {
                asqa_Alert(message: "Please Select Options")
            } else {
                callAskAQuestionAPI()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    /// Switch On & Off BTn Action
    @IBAction func switch_On_Of(_ sender: UISwitch) {
        if (sender.isOn == true) {
            print("switch is on")
        } else {
            print("switch is off")
        }
    }
    
    /// Back Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Selected Option 1 Action
    @IBAction func opt1Action(_ sender: UIButton) {
        sender.isSelected = true
        opt2Btn.isSelected = false
        selectedOption = .option1
    }
    
    /// Selected Option 2 Action
    @IBAction func opt2Action(_ sender: UIButton) {
        sender.isSelected = true
        opt1Btn.isSelected = false
        selectedOption = .option2
    }
    
    ///  Categories Btn Action
    @IBAction func categoriesBtn(_ sender: UIButton) {
        moveToCategoriesScreen()
    }
    
    // MARK: - Custom Function
    /// of TextFeilds Validation
    func isTextFeildsAreEmpty() -> Bool{
        // this func just check either textfields are empty or not
        if (questionTitleTF.text!.isEmpty  || questiontTF.text!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    ///  custom function of alert message .
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Forgot Password", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    
    ///  custom function of move on next screen .
    func moveToCategoriesScreen() {
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let categoriesVC  = storyboard.instantiateViewController(withIdentifier: "Categories2ViewController") as! Categories2ViewController
        // what will it do
        categoriesVC.aqsa_call_back =  { selectedCate in
            print("ammar test")
            self.selectedCategories = selectedCate
            print(self.selectedCategories = selectedCate)
        }
        self.navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
    /// Custom Function of textField rounded corner
    func roundTextView(textFeild: UIView) {
        textFeild.layer.borderWidth = 2
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.gray.cgColor
    }
    
    /// custom function of rounded and shdow of UIView.
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 0.3
        myView.layer.shadowOffset = CGSize.zero
        myView.layer.shadowRadius = 1.0
        myView.layer.cornerRadius = 8
        myView.layer.shouldRasterize = false
        myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.layer.borderWidth = 0.3
        myView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    /// custom function of shadow of main view.
    func roundedMainView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 0
    }
    
}
//MARK: - Custom Function Of Mintus Time Picker.
extension AskQuestionVC: UIPickerViewDelegate, UIPickerViewDataSource{
    // PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayMinutes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayMinutes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.timeLimitTF.text = arrayMinutes[row]
    }
    //MARK:- TextFiled Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUp(timeLimitTF)
    }
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.systemBlue
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AskQuestionVC.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AskQuestionVC.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    // Button
    @objc func doneClick() {
        timeLimitTF.resignFirstResponder()
    }
    @objc func cancelClick() {
        timeLimitTF.resignFirstResponder()
    }
    
}

//MARK: - Ask A questions API call.
extension AskQuestionVC {
    func callAskAQuestionAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/question"
        
        var selection = -1
        let userId = UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue)
        
        if selectedOption == .option1 {
            selection = 1
        } else {
            selection = 2
        }
        let  parameter = ["user_id": userId as Any,
                          "question_title": questionTitleTF.text!,
                          "question": questiontTF.text!,
                          "time_limit": timeLimitTF.text!,
                          "options": selection,
                          "categories": selectedCategories
        ] as [String : Any]
        SwiftSpinner.show("Loading...")
        AF.request(baseURL, method:.post, parameters: parameter, encoding: JSONEncoding.default,  headers: nil).responseData(completionHandler: {   response in
            switch response.result {
                
            case .success( _):
                SwiftSpinner.hide()
                let decoder = JSONDecoder()
                
                do {
                    // to see the response like postman
                    print(String(data: response.data!, encoding: .utf8) as Any)
                    
                    let askQuestionModel = try decoder.decode(AskAQuestionsModel.self, from: response.data!)
                    
                    if askQuestionModel.status == true {
                        UserDefaults.standard.setValue(askQuestionModel.data.questionID, forKey: UserDefaultsKeys.question_Id.rawValue)
                        print("success")
                        
                    } else {
                        self.asqa_Alert(message: askQuestionModel.message)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                SwiftSpinner.hide()
                print(error.localizedDescription)
            }
        })
    }
}
