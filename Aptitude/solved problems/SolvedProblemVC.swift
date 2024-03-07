//
//  SolvedProblemVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 18/01/24.
//

import UIKit

struct SolvedQuestionModel : Codable{
    var id : String?
    var cat_name : String?
    var cat_image : String?
    var thumb_image : String?
}

class SolvedProblemVC: UIViewController {
    
    var SolvedData = [SolvedQuestionModel]()
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "SolvedProblemTVC", bundle: .main), forCellReuseIdentifier: "SolvedProblemTVC")
        TableView.delegate = self
        TableView.dataSource = self
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
                    let json = try JSONDecoder().decode([SolvedQuestionModel].self, from: data)
//                    print("json Data\(json)")
                    self.SolvedData = json
                    
                    DispatchQueue.main.async {
                        self.TableView.reloadData()
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
    
    @IBAction func BackBTn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension SolvedProblemVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SolvedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SolvedProblemTVC", for: indexPath) as! SolvedProblemTVC
        cell.CountLabel.text = SolvedData[indexPath.row].id
        cell.TopicLabel.text = SolvedData[indexPath.row].cat_name
        cell.HolderView.layer.borderWidth = 2.0
        cell.HolderView.layer.borderColor = UIColor.white.cgColor
        cell.HolderView.layer.cornerRadius = 10
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SolutionDataVC") as! SolutionDataVC
        vc.topicdata = SolvedData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
