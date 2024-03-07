//
//  ResultVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 02/02/24.
//

import UIKit

protocol RecentResult : AnyObject{
    func DidtapSaveBtn(categoryname:String,result:Int32)
}

class ResultVC: UIViewController {
    
    var categoryID : TopicModel?
    var delegate: RecentResult?
    var resRight:Int?
    var resWrong:Int?
    var pass = 1
    
    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Imageview: UIImageView!
    
    var recenttext = [Results]() {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pass < resRight!{
            if let image1 = UIImage(named: "Pass_cleanup"){
                Imageview.image = image1
            }
        }
        else{
            if let image2 = UIImage(named: "Failed_cleanup"){
                Imageview.image = image2
            }

        }

        self.Label.text = "result is:\(resRight ?? 0 )"
        self.Label2.text = categoryID?.cat_name ?? ""
    }
    
    
    @IBAction func RootBackBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func BackBtn(_ sender: UIButton) {
        
        guard let Rightans = Label.text, Rightans != "" else {return}
        guard let CATid = categoryID?.cat_name else {return}
        delegate?.DidtapSaveBtn(categoryname:CATid,result:Int32(resRight ?? 0))
        
        let context = appdelegate.persistentContainer.viewContext
        
        let details = Results(context: context)
        details.categoryname = CATid
        details.result = Int32(resRight ?? 0)
        appdelegate.saveContext()
        recenttext.append(details)
        
        
        
        let storyboard = UIStoryboard(name: "RecentVC", bundle: .main)
         let vc = storyboard.instantiateViewController(withIdentifier: "RecentVC") as! RecentVC
        vc.receivedResRight = resRight
        vc.categoryid = categoryID
        self.navigationController?.pushViewController(vc, animated: true)
      
    }
    func fetchdata(){
        let context = appdelegate.persistentContainer.viewContext
        do{
            recenttext = try context.fetch(Results.fetchRequest()) as! [Results]
        }catch{
            print("error")
        }
    }
    
}
