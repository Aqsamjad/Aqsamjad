//
//  CategoriesVC2ViewController.swift
//  myMufti
//
//  Created by Qazi on 02/03/2022.
//

import UIKit

class Categories2ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    
    // declare the function
    var aqsa_call_back: (([String]) -> Void)?
    
    var selectedIndex = [Int]()
    
    let categories = ["Family law" , "Finance" , "Home Finance" , "Marriage" , "Relationship" , "Dhikir" , "Duas" , "Raising kids" , "Parents" , "Salah" , "Dawah" , "Competitive religion" , "Comparative religion"]
    var selectedCategories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.cornerRadius = 8
    }
    //    MARK:- Back Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    MARK:- Submit Btn Action
    @IBAction func submitBtnAction(_ sender: Any) {
        if selectedIndex.count == 0 {
            asqa_Alert(message: "please select Categories")
        } else {
            // calling of fucntion
            print(selectedCategories)
            addSelectedCategories()
            self.aqsa_call_back?(selectedCategories)
            print(self.selectedCategories)
            self.navigationController?.popViewController(animated: true)
        }
    }
    // Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "My Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    //MARK:-    Function Of Selectd Categories
    func addSelectedCategories() {
        for tempIndex in selectedIndex {
            selectedCategories.append(categories[tempIndex])
        }
    }
   @objc func checkBoxClicked(_ sender:UIButton) {
        sender.isSelected = sender.isSelected
        
        if selectedIndex.contains(sender.tag) {
            selectedIndex.remove(at: selectedIndex.firstIndex(of: sender.tag) ?? -1)
        }else{
            selectedIndex.append(sender.tag)
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}
//MARK: - Custom Function Extension
extension Categories2ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Categories2TableViewCell") as! Categories2TableViewCell
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(checkBoxClicked(_:)), for: .touchUpInside)
        cell.checkBox.isSelected = false
        //  CheckBox SelectedItems Conditions
        if selectedIndex.contains(indexPath.row) {
            cell.checkBox.isSelected = true
        }
        cell.categoriesLbl.text = categories[indexPath.row]
        return cell
    }
}
