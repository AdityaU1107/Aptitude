//
//  PracticeDataTVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 23/01/24.
//

import UIKit

class PracticeDataTVC: UITableViewCell {

    @IBOutlet weak var holderview: UIView!
    @IBOutlet weak var Option1: UILabel!
    @IBOutlet weak var Option2: UILabel!
    @IBOutlet weak var Option3: UILabel!
    @IBOutlet weak var Option4: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var ExplainationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
