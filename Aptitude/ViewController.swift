//
//  ViewController.swift
//  Aptitude
//
//  Created by Trycatch Classes on 15/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Formulabtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FormulaVC") as! FormulaVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ExamBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ExamVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExamVC") as! ExamVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func SolvedProblemBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SolvedProblemVC") as! SolvedProblemVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func TipsTricksBtn(_ sender: UIButton) {
    }
    
    @IBAction func PracticeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PracticeVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PracticeVC") as! PracticeVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func thBoardQuestionPaperBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InterviewVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "InterviewVC") as! InterviewVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func RecentlyLearnedTopicBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RecentVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecentVC") as! RecentVC
        self.navigationController?.pushViewController(vc, animated: true)
        
            }
    
}

