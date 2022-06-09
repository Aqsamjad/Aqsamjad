//
//  ButtonTableViewCell.swift
//  myMufti
//
//  Created by Aqsa's on 09/06/2022.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var submitBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        submitBtn.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

        // Configure the view for the selected state
    }

}
