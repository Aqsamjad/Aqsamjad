//
//  BecomeMuftiFourthVC.swift
//  myMufti
//
//  Created by Qazi on 14/01/2022.
//

import UIKit
import Alamofire
import SwiftSpinner
import SDWebImage


class BecomeMuftiThreeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var degreeName = String()
    var instituteName = String()
    var startDateFrom = String()
    var endDateFrom = String()
    var experienceFrom = String()
    var experienceTo = String()
    var name = String()
    var phone_Number = String()
    var selectedIndex = [Int]()
    
    var degree_image: UIImage?
    
    let categories: [String] = ["Family law" , "Finance" , "Home Finance" , "Marriage" , "Relationship" , "Dhikir" , "Duas" , "Raising kids" , "Parents" , "Salah" , "Dawah" , "Competitive religion" , "Comparative religion"]
    var selectedCategories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedMainView(myView: mainView)
        print(name)
        print(phone_Number)
        
    }
    //    MARK: - Back Btn Action
    @IBAction func becomeMuftiBackBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    MARK: - checkBox BTn Action
    @IBAction func submitBtnAction(_ sender: UIButton) {
        addselectedCategories()
        callBecomeAMuftiAPI()
        
    }
    ///-    Function Of Selectd Categories
    func addselectedCategories() {
        for tempIndex in selectedIndex {
            selectedCategories.append(categories[tempIndex])
        }
    }
    /// Function Of CheckBoxb Action
    @objc func checkboxClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if selectedIndex.contains(sender.tag) {
            selectedIndex.remove(at: selectedIndex.firstIndex(of: sender.tag) ?? -1)
        } else {
            selectedIndex.append(sender.tag)
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    //    MARK: - Custom Fuction of Move to Done Scren
    func moveToDoneBecomeAmUftiScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let doneVC: UIViewController  = storyboard.instantiateViewController(withIdentifier: "BecomeMuftiDoneVC") as! BecomeMuftiDoneVC
        self.navigationController?.pushViewController(doneVC, animated: true)
    }
    func roundedMainView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 0
    }
    //MARK: - Custom Function of Table View Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// put a condtion that checks
            if categories.count < (indexPath.row + 1) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell")
                return cell!
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeildTableViewCell", for: indexPath) as! FeildTableViewCell
            cell.checkBox.tag = indexPath.row
            cell.checkBox.addTarget(self, action: #selector(checkboxClicked(_ :)), for: .touchUpInside)
            cell.checkBox.isSelected = false
            ///  CheckBox SelectedItems Conditions
            if selectedIndex.contains(indexPath.row) {
                cell.checkBox.isSelected = true
            }
            cell.feildLbl.text = categories[indexPath.row]
            return cell
    }
    /// Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Become A Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //    MARK: - Api Function Call
    func callBecomeAMuftiAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/mufti"
        
        // convert image into base64String
        guard let compressedImage = degree_image?.jpegData(compressionQuality : 0.0) else {print("image not compressed");return}
        let documentImg = compressedImage.base64EncodedString()
        
        let  parameter = [
            "user_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue) ?? "",
            "name":name,
            "phone":phone_Number,
            "degree": degreeName,
            "degree_image": documentImg ,
            "degree_start_date":startDateFrom,
            "degree_end_date": endDateFrom ,
            "institute_name":instituteName ,
            "experiance_from":experienceFrom ,
            "experiance_to":experienceTo ,
            "expertise": selectedCategories
        ] as [String : Any]
        
        SwiftSpinner.show("Loading...")
        
        AF.request(baseURL, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers:nil).validate(statusCode: 200..<600).responseData(completionHandler: {   respone in
            
            if let data = respone.data {
                SwiftSpinner.hide()
                print(String(data: data, encoding: .utf8) as Any)
                let decoder = JSONDecoder()
                do {
                    let becomeMuftiModel = try decoder.decode(BecomeAMuftiModel.self, from: data)
                    
                    if becomeMuftiModel.status == true {
                        // move to next screen home
                        self.moveToDoneBecomeAmUftiScreen()
                    } else {
                        // show error message
                        self.asqa_Alert(message: becomeMuftiModel.message)
                    }
                } catch let error {
                    print(error)
                }
            }
        })
    }
}
//MARK: - Custom Function Rounded Views
extension BecomeMuftiThreeVC{
    func roundedTextView(textFeild:UIView) {
        textFeild.layer.shadowColor = UIColor.lightGray.cgColor
        textFeild.layer.shadowOpacity = 1
        textFeild.layer.shadowOffset = .zero
        textFeild.layer.shadowRadius = 1
        textFeild.layer.cornerRadius = 8
    }
}
