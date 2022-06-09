//
//  MyViewController.swift
//  myMufti
//
//  Created by Qazi on 13/01/2022.
//

import UIKit
import SwiftSpinner
import Alamofire

class QuestionsVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var questionsCVC: UICollectionView!
    
    @IBOutlet weak var cView1: UICollectionView!
    
    var dashboardModel: DashboardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundView(myView: mainView)
        callQuestionsAPI()
    }
    
    //MARK: - Buttons Action.
    /// back btn action.
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// custom function of move on next screen.
    func moveToFullQuestionScreen()  {
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "FullQuestionVC") as! FullQuestionVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    /// custom function of alert Messages.
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Questions", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    
    /// custom function of shadow view.
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 0
    }
    
}
//MARK: - Custom Function Of Collection View Cell data source
extension QuestionsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardModel?.data.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questionsCVC.dequeueReusableCell(withReuseIdentifier: "QuestionsCollectionViewCell", for: indexPath) as! QuestionsCollectionViewCell
        cell.bindData(aqsaQuestionModel: (dashboardModel?.data[indexPath.row])!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected screen")
        
        // data from card move on full question screen.
        let selected_dashboardModel = dashboardModel?.data[indexPath.row]
        
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let fullQuestionVC  = storyboard.instantiateViewController(withIdentifier: "FullQuestionVC") as! FullQuestionVC
        fullQuestionVC.dashboardModel = selected_dashboardModel
        self.navigationController?.pushViewController(fullQuestionVC, animated: true)
        
    }
}

//MARK: - Dashboard API on Collection View Cell
extension QuestionsVC {
    func callQuestionsAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/question"
        SwiftSpinner.show("Loading...")
        AF.request(baseURL, method:.get, encoding: JSONEncoding.default,  headers: nil).responseData(completionHandler: {   response in
            switch response.result {
            case .success( _):
                SwiftSpinner.hide()
                let decoder = JSONDecoder()
                do {
                    print(String(data: response.data!, encoding: .utf8) as Any)
                    
                    self.dashboardModel = try decoder.decode(DashboardModel.self, from: response.data!)
                    
                    if self.dashboardModel?.status == true {
                        
                        print("success")
                        self.cView1.reloadData()
                    } else {
                        self.asqa_Alert(message: self.dashboardModel?.message ?? "Question Model Error")
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                SwiftSpinner.hide()
                print(error.localizedDescription)
            }
        })
    }
}
