//
//  MuftisVC.swift
//  myMufti
//
//  Created by Qazi on 17/12/2021.
//

import UIKit


class MuftisVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var categoryBTn: UIButton!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var createdAtTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var createdAtView: UIView!
    
    @IBOutlet weak var searchRemoveBtn: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var submitBtn: UIButton!
    var KUTTypedPlainText = String()
    
    let categories = ["Family law" , "Finance" , "Home Finance" , "Marriage" , "Relationship" , "Dhikir" , "Duas" , "Raising kids" , "Parents" , "Salah" , "Dawah" , "Competitive religion" , "Comparative religion"]
    
    let images = ["mufti_1" , "mufti_2","mufti_1" , "mufti_2"]
    let names = ["Mufti Hassan" , "Mufti Ali", "Mufti Hassan" , "Mufti Ali"]
    let descreption = ["Marriage, Family Law and Duas" , "Marriage, Family Law and Duas", "Marriage, Family Law and Duas" , "Marriage, Family Law and Duas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.cornerRadius = 8
        roundView(myView: searchView)
        roundedView(myView: questionView)
        roundedView(myView: categoryView)
        roundedView(myView: createdAtView)
        searchTextField.delegate = self
        
        self.createdAtTF.setInputDatePicker(target: self, selector: #selector(calendarDone))
        
    }
    //MARK: - Buttons actions.
    @IBAction func removeBtnDidTapped(_ sender: Any) {
        if searchRemoveBtn.isSelected == true{
            searchRemoveBtn.isSelected = false
            searchRemoveBtn.setImage(UIImage(named : "RemoveBtn"), for: UIControl.State.normal)
            self.searchTextField.text = nil
        } else {
            searchRemoveBtn.isSelected = true
            searchRemoveBtn.setImage(UIImage(named : ""), for: UIControl.State.normal)
            self.searchTextField.text = nil
            self.tableView.isHidden = false
        }
    }
    
    @IBAction func categoryDidTapped(_ sender: Any) {
        
//        dropDown.dataSource = categories
//        dropDown.anchorView = (sender as! AnchorView)
//        dropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height)
//        dropDown.show()
//        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
//            guard let _ = self else { return }
//            self!.categoriesTF.text = item
            
//        }
    }
    /// Custom function of TextField delegate methods.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.tableView.isHidden = false
        self.questionView.isHidden = true
        self.categoryView.isHidden = true
        self.createdAtView.isHidden = true
        self.createdAtTF.isHidden = true
        self.questionTF.isHidden = true
        self.categoryTF.isHidden = true
        print("TextField Should Begin Editing.")
        
        return true
    }
    
    // start editing textfield delegate method.
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        print("TextField Did Begin Editing")
    }
    // change characters delegate method.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        print(textField.text!)
        print("Api")
        return true
    }
    // clear text on textfield delegate method.
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        
        self.tableView.isHidden = true
        self.questionView.isHidden = false
        self.categoryView.isHidden = false
        self.createdAtView.isHidden = false
        self.createdAtTF.isHidden = false
        self.questionTF.isHidden = false
        self.categoryTF.isHidden = false
        
        print("text cleared")
        
        return true
    }

    // return function of textfield delegate method.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        
        if searchTextField.text != "" {
            self.isEditing = true
            return true
        } else {
            self.isEditing = false
            return false
        }
    }
    /// rounded and shadow custom function for search view.
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 0.1
        myView.layer.shadowOffset = CGSize.zero
//        myView.layer.shadowRadius = 1.0
        myView.layer.cornerRadius = 8
        myView.layer.shouldRasterize = false
        myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.layer.borderWidth = 0.3
//        myView.layer.rasterizationScale = UIScreen.main.scale
    }
    /// rounded and shadow custom function for  UIView.
    func roundedView(myView:UIView) {
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
    /// TextField custom function.
    @objc func calendarDone() {
        if let datePicker = self.createdAtTF.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.createdAtTF.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.createdAtTF.resignFirstResponder() // 2-5
    }
}
//MARK: - TableView datasource and delegate functions.
extension MuftisVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuftiProfileTVC") as! MuftiProfileTVC
        cell.profileImg.image = UIImage(named: images[indexPath.row])
        cell.nameLbl.text = names[indexPath.row]
        cell.descriptionLbl.text = descreption[indexPath.row]
//        cell.onlineImage.image = UIImage(named: image1[indexPath.row])
        
        return cell
        
    }
    
}
extension UITextField{
    /// date Picker on textField.
    func setInputDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(cancelDidTapped)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func cancelDidTapped() {
        self.resignFirstResponder()
    }
}
