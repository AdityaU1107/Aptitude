//
//  DetailFormulaVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 17/01/24.
//

import UIKit
import Alamofire
import SDWebImage

struct FormulaDec : Codable{
    var id : String?
    var formula_image : String?
    var thumb_image : String?
    var name : String?
    var description : String?
}


class DetailFormulaVC: UIViewController {
    
    var formuladata : FormulaModel?
    
    var Formulas  = [FormulaDec]()
    
    @IBOutlet weak var FormulaNamelbl: UILabel!
    
    @IBOutlet weak var Collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Collectionview.register(UINib(nibName: "DetailFormulaCVC", bundle: .main), forCellWithReuseIdentifier: "DetailFormulaCVC")
        self.FormulaNamelbl.text = formuladata?.cat_name ?? ""
        FormulaDecAPI(catID: formuladata?.id ?? "")
       
        
        
    }
    func FormulaDecAPI (catID : String){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/formula_data?category_id=\(catID)") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([FormulaDec].self, from: data)
                    print("json Data\(json)")
                    self.Formulas = json
                    
                    DispatchQueue.main.async {
                        self.Collectionview.reloadData()
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
    
   

    
    extension DetailFormulaVC:UICollectionViewDelegate,UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return Formulas.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailFormulaCVC", for: indexPath) as! DetailFormulaCVC
            cell.textview.text = "\n Description: \n \n \(Formulas[indexPath.row].description ?? "")"
            let url = URL(string: Formulas[indexPath.row].formula_image ?? "")
            cell.FormulaImage.sd_setImage(with: url)
            cell.FormulaView.layer.borderWidth = 2.0
            cell.FormulaView.layer.borderColor = UIColor.cyan.cgColor
            
            return cell
        }
    }
extension DetailFormulaVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 20)/1)
        let height = width * 1.85
        return CGSize(width: width, height: height)
    }
}
