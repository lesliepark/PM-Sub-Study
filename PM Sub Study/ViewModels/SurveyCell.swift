//
//  SurveyCell.swift
//  PM Sub Study
//
//  Created by Travis Allen on 12/12/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit

class SurveyCell: UITableViewCell {
    
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var surveyDate: UILabel!
    
    var surveyID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
