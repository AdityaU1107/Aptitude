//
//  QuestionTVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 18/01/24.
//

import UIKit

class QuestionTVC: UITableViewCell {

    @IBOutlet weak var QuestionLbl: UILabel!
    
    @IBOutlet weak var SolutionLabel: UILabel!
    
    @IBOutlet weak var holderview: UIView!
    
  //  @IBOutlet weak var QuestionCount: UILabel!
    
    
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBOutlet weak var AnswerLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
