//
//  SolvedProblemTVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 18/01/24.
//

import UIKit

class SolvedProblemTVC: UITableViewCell {
  
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var TopicLabel: UILabel!
    @IBOutlet weak var HolderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
