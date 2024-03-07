//
//  IntroVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 25/01/24.
//

import UIKit

class IntroVC: UIViewController {
    
    var Examdata : TopicModel?
    @IBOutlet weak var TopicLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TopicLabel.text = Examdata?.cat_name
       
    }
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func StartTestBtn(_ sender: UIButton) {
        
        
        
        
        let storyboard = UIStoryboard(name: "TestVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "TestVC") as! TestVC
       // vc.QuestionData = PracticeData[indexPath.row]
        vc.CatID = Examdata
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
