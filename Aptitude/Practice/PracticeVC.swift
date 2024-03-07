//
//  PracticeVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 19/01/24.
//

import UIKit

//struct PracticeModel:Codable{
//    var id : String?
//    var cat_id : String?
//    var question : String?
//    var option1 : String?
//    var option2 : String?
//    var option3 : String?
//    var option4 : String?
//    var answer : String?
//    var explanation : String?
//}

struct PracticeModel : Codable{
    var id : String?
    var cat_name : String?
    var cat_image : String?
    var thumb_image : String?
}

class PracticeVC: UIViewController {
    var PracticeData = [PracticeModel]()
    @IBOutlet weak var Tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Tableview.register(UINib(nibName: "PracticeTVC", bundle: .main), forCellReuseIdentifier: "PracticeTVC")

       SolvedAPI()
    }
    
    func SolvedAPI (){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/category_list") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([PracticeModel].self, from: data)
//                    print("json Data\(json)")
                    self.PracticeData = json
                    
                    DispatchQueue.main.async {
                        self.Tableview.reloadData()
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

extension PracticeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PracticeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeTVC", for: indexPath) as! PracticeTVC
        cell.IdLabel.text = PracticeData[indexPath.row].id
        cell.TopicLabel.text = PracticeData[indexPath.row].cat_name
        cell.holderview.layer.borderWidth = 2.0
        cell.holderview.layer.borderColor = UIColor.white.cgColor
        cell.holderview.layer.cornerRadius = 10
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PracticeQuestionVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PracticeQuestionVC") as! PracticeQuestionVC
        vc.QuestionData = PracticeData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
}
