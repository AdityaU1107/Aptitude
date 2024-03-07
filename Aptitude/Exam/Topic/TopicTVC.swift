//
//  TopicTVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 25/01/24.
//

import UIKit

class TopicTVC: UITableViewCell {
    
    @IBOutlet weak var HolderView: UIView!
    @IBOutlet weak var IdLabel: UILabel!
    
    @IBOutlet weak var TopicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func StartButton(_ sender: UIButton) {
    }
    
}
