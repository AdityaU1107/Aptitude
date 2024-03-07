//
//  SolutionDataVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 18/01/24.
//

import UIKit

struct QuestionModel: Codable{
    var id : String?
    var cat_id : String?
    var question : String?
    var answer : String?
    var explanation : String?
}

class SolutionDataVC: UIViewController {
    
    var QuestionData = [QuestionModel]()
    var topicdata : SolvedQuestionModel?
    @IBOutlet weak var TopicLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "QuestionTVC", bundle: .main), forCellReuseIdentifier: "QuestionTVC")
        self.TopicLabel.text = topicdata?.cat_name ?? ""
        GetQuestionApi(catid: topicdata?.id ?? "")
        
    }
    func GetQuestionApi(catid : String){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/solved_problem_data?category_id=\(catid)") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([QuestionModel].self, from: data)
                    print("json Data\(json)")
                    self.QuestionData = json
                    
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
  
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension SolutionDataVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTVC", for: indexPath) as! QuestionTVC
        cell.QuestionLbl.text = "Question: \(indexPath.row + 1)) \(QuestionData[indexPath.row].question ?? "")"
        cell.AnswerLabel.text = "Answer: \(QuestionData[indexPath.row].answer ?? "")"
        cell.SolutionLabel.text = "Explanation : \n \(QuestionData[indexPath.row].explanation ?? "")"
        //cell.QuestionCount.text = "Question : \(QuestionData[indexPath.row].id ?? "")"
//        cell.AnswerLabel.text = QuestionData[indexPath.row].
        cell.holderview.layer.borderWidth = 2.0
        cell.holderview.layer.borderColor = UIColor.black.cgColor
        cell.holderview.layer.cornerRadius = 10
        
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    
}
