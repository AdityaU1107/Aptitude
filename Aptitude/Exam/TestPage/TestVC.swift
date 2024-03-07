//
//  TestVC.swift
//  Aptitude
//
//  Created by Trycatch Classes on 29/01/24.
//

import UIKit

struct Question:Codable{
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
class TestVC: UIViewController {
    var timer = Timer()
    var counter = 1800
    
    @IBOutlet weak var Countlbl: UILabel!
    
    @IBOutlet weak var Topiclabel: UILabel!
    var questiondata = [Question]()
    var CatID : TopicModel?
    var no = 1
    @IBOutlet weak var TimerLabel: UILabel!
    
    var right = 0
    var wrong = 0
    
    
    var currentIndex = 0
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimerLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerTrigger),
                                     userInfo: nil,
                                     repeats: true)
       self.Topiclabel.text = CatID?.cat_name ?? ""
        QuestionAPI(catid: CatID?.id ?? "")
      
        
        
        
        
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
        
        if nextItem < questiondata.count {
            currentIndexPath = nextIndexPath
            CollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        } else {
            // Handle case when trying to go forward beyond the last question
            print("No more questions forward")
        }
    }
    
    @objc func timerTrigger() {
        
        if counter > 0 {
            counter -= 1
                   let minutes = counter / 60
                   let seconds = counter % 60
                   TimerLabel.text = String(format: "%02d:%02d", minutes, seconds)
               } else {
                   
                   timer.invalidate()
                   TimerLabel.text = "Time's up!"
                   let storyboard = UIStoryboard(name: "ResultVC", bundle: .main)
                   let vc = storyboard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
                   self.navigationController?.pushViewController(vc, animated: true)
                   vc.resRight = right
                   vc.resWrong = wrong
                   vc.categoryID = CatID

                   
               }
        
        

    }

    var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    @IBAction func Option1(_ sender: UIButton) {
        let nextItem = currentIndexPath.item + 1
        let nextIndexPath = IndexPath(item: nextItem, section: currentIndexPath.section)
        let optionAButton = "1"
        let ans = questiondata[currentIndexPath.item].answer
            
            if nextItem < questiondata.count {
                currentIndexPath = nextIndexPath
                CollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                if optionAButton == ans as! String {
                   right = right + 1
                }else{
                    wrong = wrong + 1
                }
            }else{
                if optionAButton == ans as! String {
                   right = right + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")

                }else{
                    wrong = wrong + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")
                }
                let storyboard = UIStoryboard(name: "ResultVC", bundle: .main)
                let vc = storyboard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
                self.navigationController?.pushViewController(vc, animated: true)
                vc.resRight = right
                vc.resWrong = wrong
                vc.categoryID = CatID

            }
        
        let mybutton = UIButton(type: .system)
        mybutton.setTitle("tap me", for: .normal)
        mybutton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(mybutton)
        mybutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mybutton.centerXAnchor.constraint(equalTo: view.centerXAnchor) , (mybutton.centerYAnchor.constraint(equalTo: view.bottomAnchor))])
    }
    @objc func buttonTapped(){
        print("btn tapped")
    }
    @IBAction func Option2(_ sender: UIButton) {
        let nextItem = currentIndexPath.item + 1
        let nextIndexPath = IndexPath(item: nextItem, section: currentIndexPath.section)
        let optionBButton = "2"
        let ans = questiondata[currentIndexPath.item].answer
            
            if nextItem < questiondata.count {
                currentIndexPath = nextIndexPath
                CollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                if optionBButton == ans as! String {
                   right = right + 1
                }else{
                    wrong = wrong + 1
                }
            }else{
                if optionBButton == ans as! String {
                   right = right + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")

                }else{
                    wrong = wrong + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")
                }
                let storyboard = UIStoryboard(name: "ResultVC", bundle: .main)
                let vc = storyboard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
                self.navigationController?.pushViewController(vc, animated: true)
                vc.resRight = right
                vc.resWrong = wrong
                vc.categoryID = CatID
            }
        
        let mybutton = UIButton(type: .system)
        mybutton.setTitle("tap me", for: .normal)
        mybutton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(mybutton)
        mybutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mybutton.centerXAnchor.constraint(equalTo: view.centerXAnchor) , (mybutton.centerYAnchor.constraint(equalTo: view.bottomAnchor))])
    }
    
    @IBAction func Option3(_ sender: UIButton) {
        let nextItem = currentIndexPath.item + 1
        let nextIndexPath = IndexPath(item: nextItem, section: currentIndexPath.section)
        let optionCButton = "2"
        let ans = questiondata[currentIndexPath.item].answer
            
            if nextItem < questiondata.count {
                currentIndexPath = nextIndexPath
                CollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                if optionCButton == ans as! String {
                   right = right + 1
                }else{
                    wrong = wrong + 1
                }
            }else{
                if optionCButton == ans as! String {
                   right = right + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")

                }else{
                    wrong = wrong + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")
                }
                let storyboard = UIStoryboard(name: "ResultVC", bundle: .main)
                let vc = storyboard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
                self.navigationController?.pushViewController(vc, animated: true)
                vc.resRight = right
                vc.resWrong = wrong
                vc.categoryID = CatID
            }
        
        let mybutton = UIButton(type: .system)
        mybutton.setTitle("tap me", for: .normal)
        mybutton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(mybutton)
        mybutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mybutton.centerXAnchor.constraint(equalTo: view.centerXAnchor) , (mybutton.centerYAnchor.constraint(equalTo: view.bottomAnchor))])

        
    }
    
    @IBAction func Option4(_ sender: UIButton) {
        let nextItem = currentIndexPath.item + 1
        let nextIndexPath = IndexPath(item: nextItem, section: currentIndexPath.section)
        let optionDButton = "2"
        let ans = questiondata[currentIndexPath.item].answer
            
            if nextItem < questiondata.count {
                currentIndexPath = nextIndexPath
                CollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                if optionDButton == ans as! String {
                   right = right + 1
                }else{
                    wrong = wrong + 1
                }
            }else{
                if optionDButton == ans as! String {
                   right = right + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")

                }else{
                    wrong = wrong + 1
                    print("Right:\(right)")
                    print("Wrong:\(wrong)")
                }
                let storyboard = UIStoryboard(name: "ResultVC", bundle: .main)
                let vc = storyboard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
                self.navigationController?.pushViewController(vc, animated: true)
                vc.resRight = right
                vc.resWrong = wrong
                vc.categoryID = CatID
            }
        
        let mybutton = UIButton(type: .system)
        mybutton.setTitle("tap me", for: .normal)
        mybutton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(mybutton)
        mybutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mybutton.centerXAnchor.constraint(equalTo: view.centerXAnchor) , (mybutton.centerYAnchor.constraint(equalTo: view.bottomAnchor))])

    }
    
    
    func QuestionAPI(catid : String) {
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/exam/test_data?category_id=\(catid)") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([Question].self, from: data)
//                    print("json Data\(json)")
                    self.questiondata = json
                    print("json Data\(json)")
                    DispatchQueue.main.async {
                        self.CollectionView.reloadData()
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
extension TestVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questiondata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "McqCVC", for: indexPath) as! McqCVC
        cell.QuestionLabel.text = questiondata[indexPath.row].question
        cell.optionAButton.setTitle(questiondata[indexPath.row].option1, for: .normal)
        cell.optionBButton.setTitle(questiondata[indexPath.row].option2, for: .normal)
        cell.optionCButton.setTitle(questiondata[indexPath.row].option3, for: .normal)
        cell.optionDButton.setTitle(questiondata[indexPath.row].option4, for: .normal)
        //cell.CountLabel.text = "\(indexPath.row + 1)/ \(questiondata.count)"
        cell.HolderView1.layer.borderWidth = 1.0
        cell.HolderView1.layer.borderColor = UIColor.black.cgColor
        cell.HolderView1.layer.cornerRadius = 10
        cell.HolderView2.layer.borderWidth = 1.0
        cell.HolderView2.layer.borderColor = UIColor.black.cgColor
        cell.HolderView2.layer.cornerRadius = 10
        cell.HolderView3.layer.borderWidth = 1.0
        cell.HolderView3.layer.borderColor = UIColor.black.cgColor
        cell.HolderView3.layer.cornerRadius = 10
        cell.HolderView4.layer.borderWidth = 1.0
        cell.HolderView4.layer.borderColor = UIColor.black.cgColor
        cell.HolderView4.layer.cornerRadius = 10
        
        cell.layer.cornerRadius = 10
        Countlbl.text = "\(indexPath.row + 1)/ \(questiondata.count)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets .init(top: 2, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CollectionView.frame.width
        let height = width + 2
        
        return  CGSize(width: width, height: height)
    }
}
