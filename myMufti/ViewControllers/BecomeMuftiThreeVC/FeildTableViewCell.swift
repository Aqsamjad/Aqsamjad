//
//  FeildTableViewCell.swift
//  myMufti
//
//  Created by Qazi on 12/02/2022.
//

import UIKit

class FeildTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feildLbl: UILabel!
    @IBOutlet weak var feildView: UIView!
    @IBOutlet weak var checkBox: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView(myView: feildView)
    }
}
//MARK:- Custom Function of Table View Rounded cell
extension FeildTableViewCell {
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
}
