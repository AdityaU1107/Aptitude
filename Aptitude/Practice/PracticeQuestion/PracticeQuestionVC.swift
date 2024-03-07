//
//  PracticeQuestionVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 19/01/24.
//

import UIKit
struct PracticeQuestionModel :Codable{
    var id : String?
    var cat_id : String?
    var question : String?
    var option1 : String?
    var option2 : String?
    var option3 : String?
    var option4 : String?
    var answer : String?
    var explanation : String?
    
}

class PracticeQuestionVC: UIViewController {
    
    @IBOutlet weak var TopicLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var QuestionData : PracticeModel?
    var PracticeQuestionData = [PracticeQuestionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "PracticeDataTVC", bundle: .main), forCellReuseIdentifier: "PracticeDataTVC")
        self.TopicLabel.text = QuestionData?.cat_name ?? ""
        GetQuestionApi(catid: QuestionData?.id ?? "")
       
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func GetQuestionApi(catid : String){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/practice_data?category_id=\(catid)") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([PracticeQuestionModel].self, from: data)
                    print("json Data\(json)")
                    self.PracticeQuestionData = json
                    
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
    
}

extension PracticeQuestionVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PracticeQuestionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeDataTVC") as! PracticeDataTVC
        cell.QuestionLabel.text = " Question:\(indexPath.row + 1)) \(PracticeQuestionData[indexPath.row].question ?? "")"
        cell.AnswerLabel.text = "Answer: \(PracticeQuestionData[indexPath.row].answer ?? "")"
        cell.ExplainationLabel.text = PracticeQuestionData[indexPath.row].explanation ?? ""
        cell.Option1.text = PracticeQuestionData[indexPath.row].option1 ?? ""
        cell.Option2.text = PracticeQuestionData[indexPath.row].option2 ?? ""
        cell.Option3.text = PracticeQuestionData[indexPath.row].option3 ?? ""
        cell.Option4.text = PracticeQuestionData[indexPath.row].option4 ?? ""
        cell.holderview.layer.borderWidth = 2.0
        cell.holderview.layer.borderColor = UIColor.brown.cgColor
        cell.holderview.layer.cornerRadius = 10
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    
    
}
