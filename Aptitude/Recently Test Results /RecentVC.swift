//
//  RecentVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 03/02/24.
//

import UIKit

class RecentVC: UIViewController {
    var recentTexts : [Results] = []
    @IBOutlet weak var TableView: UITableView!
    var receivedResRight: Int?
    var categoryid : TopicModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.register(UINib(nibName: "RecentTVC", bundle: .main), forCellReuseIdentifier: "RecentTVC")
        if let resRight = receivedResRight {
                    print("Received resRight value: \(resRight)")
                }
       fetchdata()
    }
    func fetchdata(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recentTexts = try context.fetch(Results.fetchRequest()) as! [Results]
            TableView.reloadData()
        }
        catch{
            print("error in catch fav")
        }
    }
    func savetocoredata(categoryname:String,result:Int32){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let details = Results(context: context)
        details.categoryname = categoryname
        details.result = result
        
        do {
            try context.save()
            recentTexts.append(details)
            TableView.reloadData()
        }catch{
            print("error in xcatch")
        }
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
   
}
extension RecentVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTVC", for: indexPath) as! RecentTVC
        let recentText = recentTexts[indexPath.row]
                cell.CategoryLabel.text = recentText.categoryname
                cell.Result.text = "\(recentText.result)/20"
        cell.CountLabel.text = "\(indexPath.row + 1)."
        cell.holderview.layer.cornerRadius = 10
        cell.holderview.layer.borderWidth = 2.0
        cell.holderview.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(recentTexts[indexPath.row])
            do {
                try context.save()
                recentTexts.remove(at: indexPath.row)
                TableView.deleteRows(at: [indexPath], with: .fade
                )
                
            } catch {
                print ("Error" )
            }
        }
        
        
    }
}
