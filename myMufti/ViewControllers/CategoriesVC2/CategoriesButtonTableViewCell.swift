//
//  ButtonTableViewCell.swift
//  myMufti
//
//  Created by Aqsa's on 09/06/2022.
//

import UIKit

class CategoriesButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var submitBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        submitBtn.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

        // Configure the view for the selected state
    }

}
