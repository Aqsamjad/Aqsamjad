//
//  FullQuestionVC.swift
//  myMufti
//
//  Created by Qazi on 05/01/2022.
//

import UIKit
import SwiftSpinner
import Alamofire

class FullQuestionVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var commentTF:UITextField!
    @IBOutlet weak var muftiTF: UITextField!
    
    @IBOutlet weak var minLbl: UILabel!
    
    @IBOutlet weak var stackMufti: UIStackView!
    @IBOutlet weak var stackCmments: UIStackView!
    
    @IBOutlet weak var seeAllBtn: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileDate: UILabel!
    @IBOutlet weak var profileQuestion: UILabel!
    
    @IBOutlet weak var yesBtn: UIButton!
    
    @IBOutlet weak var yesPercentage: UILabel!
    @IBOutlet weak var noPercentage: UILabel!
    
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var votesLbl: UILabel!
    
    var selectedCategory = ""
    
    var dashboardModel: Dashboard?
    
    var userCommentModel: UserCommentModel?
    
    var votes = ""
    
    // Table View Declare
    var images = ["comment_Image" , "comment_Image" , "comment_Image" , "comment_Image" , "comment_Image"]
    var names =  ["Aqsa Amjad" , "Kausar Razaq" , "Numra Sakeena" , "Adeela" , "Ayesha"]
    var comment = ["My Comment" , "My Comment" , "My Comment" , "My Comment" , "My Comment"]
    var hours = ["2 h" , "2 h" , "2 h" , "2 h" , "2 h"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yesBtn.layer.cornerRadius = 7.5
        noBtn.layer.cornerRadius = 7.5
        
        profileImage.layer.cornerRadius = 22.5
        
        // text field hidden time limit
        let secondsToDelay = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) { [self] in
            print("This message is delayed")
            UIView.animate(withDuration: 1) { [self] in
                stackMufti.isHidden = true
                stackCmments.isHidden = false
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// get data from Home collection View and set in full question detail in  Full question vc.
        
        profileName.text = dashboardModel?.userID.name
        
        commentLbl.text = String(dashboardModel!.questionComment)
        
        profileImage.sd_setImage(with: URL(string: (dashboardModel?.userID.image)!), completed: nil)
        
        profileDate.text = DateManager.standard.getDateFrom(stringDate: dashboardModel!.createdAt).timeAgoDisplay()
        profileQuestion.text = dashboardModel?.question
        timeLbl.text = dashboardModel?.timeLimit
        //        commentLbl.text = dashboardModel?.questionComment
        votesLbl.text = dashboardModel?.userVote
        
        yesPercentage.text = calculateVotesPercentage(yes: dashboardModel!.totalVoteForYes, no: dashboardModel!.totalVoteForNo).0
        noPercentage.text = calculateVotesPercentage(yes: dashboardModel!.totalVoteForYes, no: dashboardModel!.totalVoteForNo).1
        
        /// this function calcualte the percenate ration for yes and no lbl.
        func calculateVotesPercentage(yes: Int, no: Int) -> (String, String) {
            let total = yes + no
            if total == 0 {
                return("0%", "0%")
            }
            let yesPercentage = Int(yes / total)
            let noPercentage = Int(no / total)
            
            ///         first index will return the value of yes score and
            ///         second will return the value of no percentage score.
            
            return(String(yesPercentage) + "%", String(noPercentage) + "%")
            
        }
        
        /// this funtion will calculate the value for cicular sliders.
        func calculateSliderPercentage(yes: Int, no: Int) -> (Double, Double) {
            
            let total = yes + no
            if total == 0 {
                return(0.0, 0.0)
            }
            let yesPercentage = Double(yes / total)
            let noPercentage = Double(no / total)
            ///         first index will return the value of yes score and
            ///         second will return the value of no percentage score.
            return(yesPercentage, noPercentage)
        }
        
        /// this function will calculate the remaining Hours.
        func calculateRemainingTime(createdTime: String, timeLimit: String) -> String {
            return ""
        }
        
        func addOrSubtractDay(day:Int)->Date{
            return Calendar.current.date(byAdding: .day, value: day, to: Date())!
        }
        
    }
    
    //    MARK: - Buttons Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Comment Btn Action
    @IBAction func commentBtnAction(_ sender: Any) {
        callUserCommentAPI()
    }
    
    ///  share Btn Function
    @IBAction func shareBtn(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()
        
        let textToShare = "Check out my app"
        
        if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = shareBtn
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    ///  Yes Btn Action
    @IBAction func yesBtnTapped(_ sender: UIButton) {
        yesBtn.backgroundColor = UIColor(named: "selectedButton")
        noBtn.backgroundColor = UIColor(named: "unselectedButton")
        selectedCategory = "yesBtn"
    }
    
    ///  No Btn Action
    @IBAction func noBtnTapped(_ sender: UIButton) {
        noBtn.backgroundColor = UIColor(named: "selectedButton")
        yesBtn.backgroundColor = UIColor(named: "unselectedButton")
        selectedCategory = "noBtn"
    }
    
}
// MARK: - Rounded Text Feild Custom Function
extension FullQuestionVC{
    
    func roundTextView(textFeild:UIView) {
        textFeild.layer.borderWidth = 2
        textFeild.layer.cornerRadius = 8
        textFeild.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 22
    }
    
    func asqa_Alert(message: String) {
        let alertBlankInput = UIAlertController(title: "Become A Mufti", message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertBlankInput.addAction(okAction)
        self.present(alertBlankInput, animated: true, completion: nil)
    }
    
}
//  MARK: - Custom Function Of Table View Cell
extension FullQuestionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullQuestionsTableViewCell") as! FullQuestionsTableViewCell
        //        cell.bindData(aqsaCommentModel: (userCommentModel?.data[indexPath.row]))
        cell.commentImage.image = UIImage(named: images[indexPath.row])
        cell.nameLbl.text = names[indexPath.row]
        cell.commentLbl.text = comment[indexPath.row]
        cell.hoursLbl.text = hours[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

//MARK: - Custom Function Of UserComment API
extension FullQuestionVC {
    func callUserCommentAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/comment"
        let parameter = [
            "user_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue) as Any,
            //            "question_id": question_id,
            "comment": commentTF.text as Any
        ] as [String : Any]
        SwiftSpinner.show("Loading...")
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter).response { [self] response in
            if let data = response.data {
                SwiftSpinner.hide()
                print(String(data: data, encoding: .utf8) as Any)
                let decoder = JSONDecoder()
                do {
                    let userCommentModel = try decoder.decode(UserCommentModel.self, from: data)
                    self.tableView.reloadData()
                    if userCommentModel.status == true {
                        self.tableView.reloadData()
                        // move to next screen home
                    } else {
                        // show error message
                        self.asqa_Alert(message: userCommentModel.message)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

//MARK: - Custom Function Of UserComment API
extension FullQuestionVC {
    func callMuftiAnswerAPI() {
        let baseURL = "http://mymufti.megaxtudio.com/Users/answer"
        let parameter = [
            "mufti_id": UserDefaults.standard.string(forKey: UserDefaultsKeys.user_id.rawValue) as Any,
            //            "question_id": question_id,
            "answer": muftiTF.text! as Any
        ] as [String : Any]
        SwiftSpinner.show("Loading...")
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter).response { [self] response in
            if let data = response.data {
                SwiftSpinner.hide()
                print(String(data: data, encoding: .utf8) as Any)
                let decoder = JSONDecoder()
                do {
                    let userCommentModel = try decoder.decode(UserCommentModel.self, from: data)
                    self.tableView.reloadData()
                    if userCommentModel.status == true {
                        // move to next screen home
                    } else {
                        // show error message
                        self.asqa_Alert(message: userCommentModel.message)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
