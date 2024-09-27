import UIKit
import SCLAlertView

private let reuseIdentifier = "Cell"

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(mainCollectionView)
        self.title = String.init(format: "Level : %ld", level)
        self.loadData()
        
        self.navigationController!.navigationBar.scrollEdgeAppearance = self.navigationController!.navigationBar.standardAppearance
        self.navigationController?.navigationBar.backgroundColor = .brown
    }
    
    
    var dataDic : NSDictionary = ["There are several cats in the picture？":["4","5","6","7"],"What color are the chairs in the picture?":["Yellow","Red","Brown","Black"],"There are several cats under the table?":["0","1","2","3"]]
    
    // MARK: - Netdata
    
    func loadData() {
        
    }
    
    var level = 1
    
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
            
            cell.setImageName(imageName: "demo")
            
        }else{
            if indexPath.section ==  0{
                cell.setContent(content: "Try to remember all the details of the picture, I will quiz you～")
                cell.L.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                cell.L.backgroundColor = .clear
                cell.L.textColor = .darkGray
                return cell
            }
            cell.setContent(content: "Start")
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
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        
        
        let Q = dataDic.allKeys
        let A = dataDic.allValues[index] as! NSArray
        
        for (index,item) in A.enumerated() {
            alertView.addButton(item as! String) {
                if index == 2 {
                    let vc = ViewController()
                    vc.level = 2
                    self.navigationController?.pushViewController(vc, animated: true)
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
        if index < dataDic.allKeys.count - 1 {
            index = index + 1
        }
        
    }
    
    let space = 50.0
    
}

