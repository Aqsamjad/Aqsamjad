//
//  BecomeMuftiThreeVC.swift
//  myMufti
//
//  Created by Qazi on 14/01/2022.
//
import UIKit

class BecomeMuftiTwoVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var documentImage: UIImageView!
    
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var degreeNameView: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var instituteNameView: UIView!
    @IBOutlet weak var experienceFromView: UIView!
    @IBOutlet weak var experienceToView: UIView!
    @IBOutlet weak var degreeNameTF: UITextField!
    @IBOutlet weak var startDateTF: UITextField!
    @IBOutlet weak var endDateTF: UITextField!
    @IBOutlet weak var instituteNameTF: UITextField!
    @IBOutlet weak var experienceToTF: UITextField!
    @IBOutlet weak var experienceFromTF: UITextField!
    @IBOutlet weak var nxtBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    // By Ammar
    var name = String()
    var phoneNumber = String()
    var KUTTypedPlainText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nxtBtn.layer.cornerRadius = 8
        roundView(myView: degreeNameView)
        roundView(myView: startDateView)
        roundView(myView: endDateView)
        roundView(myView: instituteNameView)
        roundView(myView: experienceFromView)
        roundView(myView: experienceToView)
        roundedMainView(myView: mainView)
        print(name)
        print(phoneNumber)
        
        self.startDateTF.setInputViewDatePicker(target: self, selector: #selector(startDateDone))
        self.endDateTF.setInputViewDatePicker(target: self, selector: #selector(endDateDone))
        self.experienceFromTF.setInputViewDatePicker(target: self, selector: #selector(expFromDateDone))
        self.experienceToTF.setInputViewDatePicker(target: self, selector: #selector(expToDateDone))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.degreeNameTF.text = nil
        self.startDateTF.text = nil
        self.endDateTF.text = nil
        self.instituteNameTF.text = nil
        self.experienceToTF.text = nil
        self.experienceFromTF.text = nil
    }
    //    MARK: - Back Btn Action
    @IBAction func becomeMuftiBackBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    MARK: - Import File Btn Action
    @IBAction func importFile(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }else{
                print("Camera Not Available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
//    MARK: - Custom Function Image Picker From Gallery
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        documentImage.contentMode = .scaleToFill
        documentImage.image = image
         picker.dismiss(animated: true, completion: nil)
    }
    //    MARK:- Custom Function Image Picker Controller Cancel
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //   MARK: - Custom Function Next Btn
    @IBAction func muftiTwoNxtBtnAction(_ sender: Any) {
        if isEduTextFieldsAreEmpty() {
            asqa_Alert(message: "Please fill all text fields.")
        } else{
            //Move on next screen
            moveToFieldBecomeMuftiScreen()
        }
    }
    //    MARK: - Custom Function Of TextFeild Validation.
    func isEduTextFieldsAreEmpty() -> Bool {
        if (degreeNameTF.text!.isEmpty || startDateTF.text!.isEmpty || endDateTF.text!.isEmpty || instituteNameTF.text!.isEmpty || experienceFromTF.text!.isEmpty || experienceToTF.text!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    // MARK: - Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Become A Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //MARK: - Custom Function OF Go To The Next Screen
    func moveToFieldBecomeMuftiScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "BecomeMuftiThreeVC") as! BecomeMuftiThreeVC
        destinationViewController.name = self.name
        print(name)
        destinationViewController.phone_Number = self.phoneNumber
        print(phoneNumber)
        destinationViewController.degreeName = degreeNameTF.text!
        destinationViewController.startDateFrom = startDateTF.text!
        destinationViewController.endDateFrom = endDateTF.text!
        destinationViewController.instituteName = instituteNameTF.text!
        destinationViewController.experienceFrom = experienceFromTF.text!
        destinationViewController.experienceTo = experienceToTF.text!
        
        destinationViewController.degree_image = documentImage.image!
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    //MARK: - Rounded View Custom Function
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
    //    MARK: - Custom Function  of Start Date Picker
    @objc func startDateDone() {
        if let datePicker = self.startDateTF.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.startDateTF.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.startDateTF.resignFirstResponder() // 2-5
    }
    //    MARK: - Custom Function  of End Date Picker
    @objc func endDateDone() {
        if let datePicker = self.endDateTF.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.endDateTF.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.endDateTF.resignFirstResponder() // 2-5
    }
    //    MARK: - Custom Function  of Experience From Date Picker
    @objc func expFromDateDone() {
        if let datePicker = self.experienceFromTF.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.experienceFromTF.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.experienceFromTF.resignFirstResponder() // 2-5
    }
    //        MARK: - Custom Function  of Experience From Date Picker
    @objc func expToDateDone() {
        if let datePicker = self.experienceToTF.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.experienceToTF.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.experienceToTF.resignFirstResponder() // 2-5
    }
    
}
// MARK: - UITextFieldDelegate
extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
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
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
