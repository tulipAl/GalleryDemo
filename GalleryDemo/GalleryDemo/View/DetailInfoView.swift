//
//  DetailInfoView.swift
//  GalleryDemo
//
//  Created by apple on 2021/7/10.
//

import UIKit

class DetailInfoView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    func config(author:String, url:String){
        
        let titleLB = UILabel()
        titleLB.textColor = .black
        titleLB.text = "Author: " + author
        titleLB.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLB.textAlignment = .center
        titleLB.sizeToFit()
        titleLB.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLB)
        
        let titleLBConstraints = [
            titleLB.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLB.widthAnchor.constraint(equalTo: widthAnchor),
            //            titleLB.heightAnchor.constraint(equalToConstant: 30),
            titleLB.topAnchor.constraint(equalTo: topAnchor, constant: 40)
        ]
        NSLayoutConstraint.activate(titleLBConstraints)
        
        let urlLB = UILabel()
        urlLB.textColor = .black
        urlLB.text = "URL: " + url
        urlLB.font = UIFont.preferredFont(forTextStyle: .body)
        urlLB.textAlignment = .center
        urlLB.numberOfLines = 0
        urlLB.sizeToFit()
        urlLB.translatesAutoresizingMaskIntoConstraints = false
        addSubview(urlLB)
        
        let urlLBConstraints = [
            urlLB.centerXAnchor.constraint(equalTo: centerXAnchor),
            urlLB.widthAnchor.constraint(equalTo: widthAnchor),
            //            urlLB.heightAnchor.constraint(equalToConstant: 30),
            urlLB.bottomAnchor.constraint(equalTo: titleLB.bottomAnchor, constant: 40)
        ]
        NSLayoutConstraint.activate(urlLBConstraints)
        
    }
    
    
}
