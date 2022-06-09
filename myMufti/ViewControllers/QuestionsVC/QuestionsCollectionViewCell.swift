//
//  QuestionsCollectionViewCell.swift
//  myMufti
//
//  Created by Qazi on 11/02/2022.
//

import UIKit
import MSCircularSlider
import SDWebImage

class QuestionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var muftidiscriptionLbl: UILabel!
    
    @IBOutlet weak var muftiDays: UILabel!
    @IBOutlet weak var muftiName: UILabel!
    @IBOutlet weak var remaining: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var fiftyK: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var votesFiftK: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var questionView: UIView!
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var yesPercentage: UILabel!
    @IBOutlet weak var noPercentage: UILabel!
    
    @IBOutlet weak var yesSlider: MSCircularSlider!
    @IBOutlet weak var noSlider: MSCircularSlider!
    
    var selectedCategory = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView(myView: questionView)
        
        image.layer.cornerRadius = 25
        
        yesBtn.layer.cornerRadius = 8
        noBtn.layer.cornerRadius = 8
    }
    
    //MARK: - Buttons Action
    /// yes btn action.
    @IBAction func yesBtnTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor(named: "selectedButton")
        noBtn.backgroundColor = UIColor(named: "unselectedButton")
        selectedCategory = "yesBtn"
    }
    
    /// No Btn Action
    @IBAction func noBtnTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor(named: "selectedButton")
        yesBtn.backgroundColor = UIColor(named: "unselectedButton")
        selectedCategory = "yesBtn"
    }
    
    //    MARK: - Data From Api in Collection View Cell.
    /// custom function of bind data in collection view cell.
    func bindData(aqsaQuestionModel: Dashboard) {
        muftiName.text = aqsaQuestionModel.questionTitle
        muftidiscriptionLbl.text = aqsaQuestionModel.question
        votesFiftK.text = String(aqsaQuestionModel.totalVote)
        fiftyK.text = String(aqsaQuestionModel.questionComment)
        image.sd_setImage(with: URL(string: aqsaQuestionModel.userID.image), completed: nil)
        // setting yes and no percentages of the question votes.
        yesPercentage.text = calculateVotesPercentage(yes: aqsaQuestionModel.totalVoteForYes, no: aqsaQuestionModel.totalVoteForNo).0
        noPercentage.text = calculateVotesPercentage(yes: aqsaQuestionModel.totalVoteForYes, no: aqsaQuestionModel.totalVoteForNo).1
        //  Calculate the value of Circular Slider With Percentage.
        let yesSliderValue = calculateSliderPercentage(yes: aqsaQuestionModel.totalVoteForYes, no: aqsaQuestionModel.totalVoteForNo).0
        let noSliderValue = calculateSliderPercentage(yes: aqsaQuestionModel.totalVoteForYes, no: aqsaQuestionModel.totalVoteForNo).1
        
        //        muftiDays.text = aqsaQuestionModel.createdAt
        muftiDays.text = DateManager.standard.getDateFrom(stringDate: aqsaQuestionModel.createdAt).timeAgoDisplay()
        
        yesSlider.currentValue = yesSliderValue
        noSlider.currentValue = noSliderValue
        
        let current = Calendar.current.dateComponents(in: .current, from: DateManager.standard.getDateFrom(stringDate: aqsaQuestionModel.timeLimit))
        if let currentHour = current.hour {
            let hoursTillMidnight = 24 - currentHour
            print(hoursTillMidnight)
            hours.text = String(hoursTillMidnight)
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
    
    /// custom function  on rounded corner.
    func roundView(myView:UIView) {
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 1
        myView.layer.cornerRadius = 8
    }
}

