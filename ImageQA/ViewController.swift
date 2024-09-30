import UIKit
import SCLAlertView

private let reuseIdentifier = "Cell"

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        dataDic = dic1

        if level%3 == 0 {
            dataDic = dic0
            markImageName = "0"
        }else if level%3 == 1{
            dataDic = dic1
            markImageName = "1"
        }else if level%3 == 2{
            dataDic = dic2
            markImageName = "2"
        }
        
        
        view.addSubview(mainCollectionView)
        self.title = String.init(format: "Level : %ld", level)
        self.loadData()
        
        self.navigationController!.navigationBar.scrollEdgeAppearance = self.navigationController!.navigationBar.standardAppearance
        self.navigationController?.navigationBar.backgroundColor = .brown
        
        
//        let right1 = UIBarButtonItem.init(image:UIImage(named: "搜索"), style: .done, target: self, action: #selector(rigtFun1))

        let right1 = UIBarButtonItem.init(title: "Next", style: .done, target: self, action: #selector(rigtFun1))
        self.navigationItem.rightBarButtonItems = [right1]
        
    }
    
    @objc func rigtFun1(){//搜索
        
        let vc = ViewController()
        self.level = self.level + 1
        vc.level = self.level
        self.navigationController?.pushViewController(vc, animated: true)
                            
    }
    
    var markImageName = "0"
    
    
    var dataDic : NSDictionary!
    
    
    var dic0 : NSDictionary = ["There are several cats in the picture？":["4","5","6","7"],"What color are the chairs in the picture?":["Yellow","Red","Brown","Black"],"There are several cats under the table?":["0","1","2","3"]]
    var dic1 : NSDictionary = ["What colour is the dress of the second child in the picture ？":["Yellow","Red","Pink","Black"],"There are several children in the picture":["1","2","3","4"],"What is the third character in the picture ？":["J","K","L","I"]]
    var dic2 : NSDictionary = ["What color is the bucket in the elephant's hand?":["Yellow","Pink","Red","Black"],"What fruit is in the bear's hand in the picture?":["Banana","Apple","watermelon","strawberry"],"What is the last animal in the picture?":["Duck","Monkey","Cow","Elephant"]]


    
    // MARK: - Netdata
    
    func loadData() {
        
    }
    
    var level = 0
    
    // MARK: - collectionview
    
    lazy var mainCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        let collview = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collview.delegate = self
        collview.dataSource = self
        collview.backgroundColor = UIColor.white
        collview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collview.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "BaseCollectionViewCell")

        return collview
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell", for: indexPath) as! BaseCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        if indexPath.section == 1 {
            
            cell.setImageName(imageName: markImageName)
            
        }else{
            if indexPath.section ==  0{
                cell.setContent(content: "Try to remember all the details of the picture, I will quiz you～")
                cell.L.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                cell.L.backgroundColor = .clear
                cell.L.textColor = .darkGray
                return cell
            }
            cell.setContent(content: "I memorized the picture")
            cell.L.backgroundColor = .systemGray4
        }
        
        return cell
    }
    
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        
        if indexPath.section == 1 {
            return  CGSize.init(width: view.bounds.size.width - space*2, height: view.bounds.size.width - space*2)
        }
        
        return CGSize.init(width: view.bounds.size.width - space*2, height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: space, left: space, bottom: space/2, right: space)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        if isFinish == false{
            UIView .animate(withDuration: 0.5, delay: 0.0, options: .curveLinear) {
                collectionView.transform3D = CATransform3DMakeRotation(.pi , 0, 1, 0)

            } completion: { (make) in
                collectionView.transform = .identity

            }
        
//        }
        
    }
    
    
    var index = 0
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 2 {
            return
        }
        
        
        
        index = Int(arc4random()) % dataDic.allKeys.count

        
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        
        
        let Q = dataDic.allKeys
        let A = dataDic.allValues[index] as! NSArray
        
        for (index,item) in A.enumerated() {
            alertView.addButton(item as! String) {
                if index == 2 {

                    let alert = SCLAlertView()
                    alert.showSuccess("You are right", subTitle: "You can choose the next level or revisit the picture to answer different questions")
                    
                }else{
                    self.afalse()
                }
            }
        }
        alertView.showInfo("Question", subTitle: Q[index] as! String)
    }
    
    func afalse()  {
        
        index = Int(arc4random()) % dataDic.allKeys.count
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let alert = SCLAlertView()
            alert.showError("Oh no,Wrong answer", subTitle: " I'll ask you a new question \n Once again")
        })
//        if index < dataDic.allKeys.count - 1 {
//            index = index + 1
//        }
        
    }
    
    let space = 50.0
    
}

