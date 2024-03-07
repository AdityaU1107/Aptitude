//
//  FormulaVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 15/01/24.
//

import UIKit
import Alamofire


struct FormulaModel : Codable{
    var id : String?
    var cat_name : String?
    var cat_image : String?
    var thumb_image : String?
}

class FormulaVC: UIViewController {
    
    var FormulaData = [FormulaModel]()
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "formulaTVC", bundle: .main), forCellReuseIdentifier: "formulaTVC")
        tableview.delegate = self
        tableview.dataSource = self
        FormulaAPI()
       
    }
    
    func FormulaAPI (){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/category_list") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([FormulaModel].self, from: data)
//                    print("json Data\(json)")
                    self.FormulaData = json
                    
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

extension FormulaVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FormulaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formulaTVC", for: indexPath) as! formulaTVC
        cell.FormulaLabel.text = FormulaData[indexPath.row].cat_name
        cell.Idlabel.text = FormulaData[indexPath.row].id
        cell.holderview.layer.cornerRadius = 10
        cell.holderview.layer.borderWidth = 2.0
        cell.holderview.layer.borderColor = UIColor.white.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailFormulaVC") as! DetailFormulaVC
        vc.formuladata = FormulaData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
}
