//
//  ExamVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 23/01/24.
//

import UIKit
struct TopicModel : Codable{
    var id : String?
    var cat_name : String?
    var cat_image : String?
    var thumb_image : String?
}

class ExamVC: UIViewController {
    var TopicData = [TopicModel]()
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "TopicTVC", bundle: .main), forCellReuseIdentifier: "TopicTVC")
TopicAPI()
      
    }
    
    func TopicAPI (){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/category_list") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([TopicModel].self, from: data)
//                    print("json Data\(json)")
                    self.TopicData = json
                    
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
    
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
 
}

extension ExamVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTVC", for: indexPath) as! TopicTVC
        cell.IdLabel.text = TopicData[indexPath.row].id
        cell.TopicLabel.text = TopicData[indexPath.row].cat_name
        cell.HolderView.layer.borderWidth = 2.0
        cell.HolderView.layer.borderColor = UIColor.white.cgColor
        cell.HolderView.layer.cornerRadius = 10
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "introVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "IntroVC") as! IntroVC
        vc.Examdata = TopicData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
