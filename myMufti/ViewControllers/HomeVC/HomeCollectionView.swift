//
//  CollectionViewCell2.swift
//  myMufti
//
//  Created by Qazi on 10/02/2022.
//

import UIKit
import MSCircularSlider
import MBCircularProgressBar
import SDWebImage

class HomeCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var muftiImages: UIImageView!
    @IBOutlet weak var muftiNames: UILabel!
    @IBOutlet weak var muftiDays: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var yesPercentage: UILabel!
    @IBOutlet weak var noPercentage: UILabel!
    
    @IBOutlet weak var remainingTimeLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var votesLbl: UILabel!
    
    var now = Date()
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    var selectedCategory = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        yesBtn.layer.cornerRadius = 7.5
        noBtn.layer.cornerRadius = 7.5
        
        roundView(myView: mainView)
        
        muftiImages.layer.cornerRadius = 25
        
        setGradientBackground()
        
    }
    //    MARK: - Bind Data With Api of Collection View Cell.
    
    func bindData(aqsaQuestionModel: Dashboard) {
        
        muftiNames.text = aqsaQuestionModel.questionTitle
        questionLbl.text = aqsaQuestionModel.question
        
        votesLbl.text = String(aqsaQuestionModel.userVote)
        remainingTimeLbl.text = aqsaQuestionModel.timeLimit
        
        commentsLbl.text = String(aqsaQuestionModel.questionComment)
        
        muftiImages.sd_setImage(with: URL(string: aqsaQuestionModel.userID.image), completed: nil)
        // setting yes and no percentages of the question votes.
        yesPercentage.text = calculateVotesPercentage(yes: aqsaQuestionModel.totalVoteForYes, no: aqsaQuestionModel.totalVoteForNo).0
        noPercentage.text = calculateVotesPercentage(yes: aqsaQuestionModel.totalVoteForYes, no: aqsaQuestionModel.totalVoteForNo).1
        muftiDays.text = DateManager.standard.getDateFrom(stringDate: aqsaQuestionModel.createdAt).timeAgoDisplay()
        
        let current = Calendar.current.dateComponents(in: .current, from: DateManager.standard.getDateFrom(stringDate: aqsaQuestionModel.timeLimit))
        
        if let currentHour = current.hour {
            let hoursTillMidnight = 24 - currentHour
            print(hoursTillMidnight)
    // remainingTimeLbl.text = String(hoursTillMidnight)
        }
    }
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
    
    //    MARK: - Buttons Action
            /// yes Btn Action.
    @IBAction func yesBtnTapped(_ sender: UIButton) {
        yesBtn.backgroundColor = UIColor(named: "selectedButton")
        noBtn.backgroundColor = UIColor(named: "unselectedButton")
        selectedCategory = "yesBtn"
        
    }
    
            /// No Btn Action
    @IBAction func noBtnTapped(_ sender: UIButton) {
        noBtn.backgroundColor = UIColor(named: "selectedButton")
        yesBtn.backgroundColor = UIColor(named: "unselectedButton")
        selectedCategory = "noBtn"
    }
    
            /// Custom function of rounded circle.
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 20
    }
    
            /// Custom function of gradiant color.
    func setGradientBackground() {
        let colorTop =  UIColor(red: 116/255, green: 168/255, blue: 130/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 66/255, green: 99/255, blue: 75/255, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.mainView.bounds
        
        self.mainView.layer.insertSublayer(gradientLayer, at:0)
    }
}

