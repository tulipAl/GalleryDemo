//
//  DetailRootView.swift
//  GalleryDemo
//
//  Created by apple on 2021/7/10.
//

import UIKit

class DetailRootView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var imageHight:Double?
    
    func addImage(img:UIView,width:Double, hight:Double){
        
        backgroundColor = .black
        
        imageHight = hight
        
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius =  CGFloat(kScreenWidth) / ((kScreenWidth-56)/2) * 15
        img.layer.masksToBounds = true
        addSubview(img)
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraints = [
            img.centerXAnchor.constraint(equalTo: centerXAnchor),
            img.topAnchor.constraint(equalTo: topAnchor,constant: 44),
            img.widthAnchor.constraint(equalToConstant: CGFloat(width)),
            img.heightAnchor.constraint(equalToConstant: CGFloat(hight))
            
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
    
    }
    
    func addInfoView(view:UIView){
        
        view.backgroundColor = .white
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewConstraints = [
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.topAnchor.constraint(equalTo: topAnchor,constant: 44 + CGFloat(imageHight!)),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)

        ]
        
        NSLayoutConstraint.activate(viewConstraints)
        
    }

}
