//
//  BaseCollectionViewCell.swift
//  ImageQA
//
//  Created by edy on 2024/9/26.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    lazy var L: UILabel = {
        let label = UILabel.init(frame: self.bounds)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var I: UIImageView = {
        let imageView = UIImageView.init(frame: self.bounds)
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    func setImageName(imageName:String)  {
        L.isHidden = true
        self.addSubview(I)
        I.isHidden = false
        I.image = UIImage.init(named: imageName)
    }
    
    func setContent(content:String)  {
        I.isHidden = true
        self.addSubview(L)
        L.text = content
        L.isHidden = false

    }
    
}
