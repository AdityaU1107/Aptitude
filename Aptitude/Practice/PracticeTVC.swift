//
//  PracticeTVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 19/01/24.
//

import UIKit

class PracticeTVC: UITableViewCell {
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var TopicLabel: UILabel!
    
    @IBOutlet weak var holderview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
