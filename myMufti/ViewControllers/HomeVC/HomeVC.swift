//
//  HomeVC.swift
//  myMufti
//
//  Created by Qazi on 11/01/2022.
//

import UIKit
import Alamofire
import SwiftSpinner

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet var gradientView: UIView!
    
    var dashboardModel: DashboardModel?
    
    var collectionViewData = [Dashboard]()
    
    var question_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        callDashboardAPI()
    }
    // view will apear functoion.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        callDashboardAPI()
        setGradientBackground()
        
    }
    //   MARK: - Buttons Action
    @IBAction func JoinUsTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "BecomeMuftiVC") as! BecomeMuftiVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    /// See All Btn Action
    @IBAction func seeAllTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let questionVC  = storyboard.instantiateViewController(withIdentifier: "QuestionsVC") as! QuestionsVC
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    
    /// Post A Question Btn Action
    @IBAction func postQuestTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "AskQuestionVC") as! AskQuestionVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    // MARK: - Custom Functions.
    func moveToFullQuestionScreen()  {
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let destinationViewController  = storyboard.instantiateViewController(withIdentifier: "FullQuestionVC") as! FullQuestionVC
//        destinationViewController.question_id = question_id
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    ///  Funcion of TextFeilds Alert
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Forgot Password", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
}

// MARK: - Home Namaz Collection View Cell & Mufti Collection View Cell
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // this will work for question collection view
        if dashboardModel != nil {
            return (dashboardModel?.data.count)!
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell2 = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionView", for: indexPath) as! HomeCollectionView
        
        cell2.bindData(aqsaQuestionModel: (dashboardModel?.data[indexPath.row])!)
        return cell2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected screen")
        // get id slected tapquestion_id ped cell id.
        let selected_dashboardModel = dashboardModel?.data[indexPath.row]
        
        let storyboard = UIStoryboard(name: "FullQuestions", bundle: nil)
        let fullQuestionVC  = storyboard.instantiateViewController(withIdentifier: "FullQuestionVC") as! FullQuestionVC
        fullQuestionVC.dashboardModel = selected_dashboardModel
        self.navigationController?.pushViewController(fullQuestionVC, animated: true)

    }
}
//MARK: - Dashboard API on Collection View Cell 2
extension HomeVC {
    func callDashboardAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/dashboard"
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
                        self.homeCollectionView.reloadData()
                    } else {
                        self.asqa_Alert(message: self.dashboardModel?.message ?? "Question Model Error")
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
//MARK: - Custom Function Of Votes API
extension HomeVC {
    //    func callVotesAPI() {
    //        let baseURL = "http://mymufti.megaxtudio.com/Users/vote"
    //        let parameter = [
    //            "user_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue) as Any,
    //            "question_id": question_id,
    ////            "vote": votes
    //        ] as [String : Any]
    //        SwiftSpinner.show("Loading...")
    //        AF.request(baseURL,
    //                   method: .post,
    //                   parameters: parameter).response { [self] response in
    //            if let data = response.data {
    //                SwiftSpinner.hide()
    //                print(String(data: data, encoding: .utf8) as Any)
    //                let decoder = JSONDecoder()
    //                do {
    //                    let userCommentModel = try decoder.decode(UserCommentModel.self, from: data)
    //                    self.tableView.reloadData()
    //                    if userCommentModel.status == true {
    //                        self.tableView.reloadData()
    //                        // move to next screen home
    //                    } else {
    //                        // show error message
    //                        self.asqa_Alert(message: userCommentModel.message)
    //                    }
    //                } catch let error {
    //                    print(error)
    //                }
    //            }
    //        }
    //    }
    
    func addGradient(){
        
        let gradient:CAGradientLayer = CAGradientLayer()
        
        //          gradient.colors = [UIColor.green.withAlphaComponent(0).cgColor, UIColor.systemGreen.cgColor] //Or any colors
        //        gradient.colors = [UIColor(red: 116/255, green: 168/255, blue: 130/255, alpha: 1), UIColor(red: 36/255, green: 69/255, blue: 45/255, alpha: 1)]
        gradient.colors = [UIColor(named: "gradientTop")!, UIColor(named: "gradientBottom")!]
        //           gradient.frame = CGRect(x: 0, y: 0, width: self.gradientView.frame.size.width, height: self.gradientView.frame.size.height)
        gradient.locations = [0.0, 1.0]
        gradient.frame = view.bounds
        //           self.gradientView.layer.addSublayer(gradient)
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 116/255, green: 168/255, blue: 130/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 36/255, green: 69/255, blue: 45/255, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

