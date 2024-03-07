//
//  InterviewVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 24/01/24.
//

import UIKit
struct InterviewModel:Codable{
    var id : String?
    var question : String?
    var answer : String?
}
class InterviewVC: UIViewController {
    var InterviewData = [InterviewModel]()
    var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "InterviewCVC", bundle: .main), forCellWithReuseIdentifier: "InterviewCVC")
       getInterviewAPI()
    }
    
    func getInterviewAPI (){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/interview_question_answer_list") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([InterviewModel].self, from: data)
//                    print("json Data\(json)")
                    self.InterviewData = json
                    
                    DispatchQueue.main.async {
                      
                        self.InterviewData = self.InterviewData.reversed()
                        self.CollectionView.reloadData()
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        if currentIndexPath.item > 0 {
            let previousItem = currentIndexPath.item - 1
            let previousIndexPath = IndexPath(item: previousItem, section: currentIndexPath.section)
            currentIndexPath = previousIndexPath
            CollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        }
    }

    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        let nextItem = currentIndexPath.item + 1
        let nextIndexPath = IndexPath(item: nextItem, section: currentIndexPath.section)
        
        if nextItem < InterviewData.count {
            currentIndexPath = nextIndexPath
            CollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        } else {
            
            print("No more questions forward")
        }
    }
   
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension InterviewVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return InterviewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterviewCVC", for: indexPath) as! InterviewCVC
        cell.textview.text = "Answer: \(InterviewData[indexPath.row].answer ?? "")"
        cell.questionLabel.text = "Question :\(indexPath.row + 1)) \(InterviewData[indexPath.row].question ?? "")"
        //cell.Textview.text = InterviewData[indexPath.row].answer
        cell.holderview.layer.cornerRadius = 10
        cell.holderview.layer.borderWidth = 2.0
        cell.holderview.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    
}
extension InterviewVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width-20)
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
