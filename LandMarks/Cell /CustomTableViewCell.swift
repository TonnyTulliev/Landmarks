//
//  PlaceTableViewCell.swift
//  LandMarks
//
//  Created by Антон Скуратов on 16.12.2021.
//

import Foundation
import UIKit
import SnapKit

class PlaceTableViewCell: UITableViewCell {
    
    var image: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "")
        image.layer.cornerRadius = 30
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var star: UIImageView = {
        var star = UIImageView()
        star.image = UIImage(systemName: "star.fill")
        star.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        star.contentMode = .scaleAspectFill
        star.layer.masksToBounds = true
        star.isHidden = true
        return star
    }()
    
    var label : UILabel = {
        var label = UILabel()
        label.text =  ""
        return label
    } ()
    
    var forward: UIImageView = {
        var forward = UIImageView()
        forward.image = UIImage(systemName: "chevron.right")
        forward.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        forward.contentMode = .scaleAspectFill
        forward.layer.masksToBounds = true
        return forward
    }()
    
    func setup(data: [Landmark], indexPath: IndexPath) {
        label.text = data[indexPath.row].name
        image.image = UIImage(named: data[indexPath.row].imageName)
        switch data[indexPath.row].isFavorite{
        case true: star.isHidden = false
        case false: star.isHidden = true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(image)
        self.addSubview(label)
        self.addSubview(star)
        self.addSubview(forward)
        
        image.snp.makeConstraints { (image) in
            image.centerY.equalTo(self.snp.centerY)
            image.left.equalTo(self).offset(10)
            image.height.equalTo(60)
            image.width.equalTo(60)
        }
        
        label.snp.makeConstraints { (label) in
            label.left.equalTo(image.snp.right).offset(10)
            label.centerY.equalTo(self.snp.centerY)
        }
        
        star.snp.makeConstraints { (star) in
            star.centerY.equalTo(self.snp.centerY)
            star.left.equalTo(label.snp.right).offset(10)
            star.height.equalTo(20)
            star.width.equalTo(20)
        }
        
        forward.snp.makeConstraints { (forward) in
            forward.centerY.equalTo(self.snp.centerY)
            forward.right.equalTo(self.snp.right).offset(-20)
            forward.height.equalTo(20)
            forward.width.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


