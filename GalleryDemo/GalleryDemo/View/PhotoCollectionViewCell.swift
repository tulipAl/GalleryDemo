//
//  PhotoCollectionViewCell.swift
//  GalleryDemo
//
//  Created by apple on 2021/7/9.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var img = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(img)
           
        img.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraints = [
            img.leftAnchor.constraint(equalTo: self.leftAnchor),
            img.rightAnchor.constraint(equalTo: self.rightAnchor),
            img.topAnchor.constraint(equalTo: self.topAnchor),
            img.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    func config(photo:Photo){
        
        img.sd_setImage(with: URL(string: photo.downloadUrl) , placeholderImage: UIImage(named: "placeholder.jpg"), options: .continueInBackground) { [weak self] image, error, cache, url in
            
            DispatchQueue.main.async {
                self?.img.image = image?.roundedImage
            }
            
        }
        
       
    }
}
