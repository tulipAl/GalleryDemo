//
//  DetailViewController.swift
//  GalleryDemo
//
//  Created by apple on 2021/7/9.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    let viewModel = DetailViewModel()
    
    var shareView = DetailRootView()
    var infoView = DetailInfoView()
    var img:UIImageView!
    
    
    override func loadView() {
        view = shareView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        img = UIImageView()
        
        img.sd_setImage(with: URL(string: viewModel.photo!.downloadUrl), placeholderImage: img.image,options: .progressiveLoad)
        
        shareView.addImage(img: img, width: viewModel.photo!.downloadWidth, hight: viewModel.photo!.downloadHeight)
        
        
        infoView.config(author: viewModel.photo!.author, url: viewModel.photo!.url)
        shareView.addInfoView(view: infoView)
        
        shareView.bringSubviewToFront(img)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        view?.addGestureRecognizer(pan)
        pan.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.delegate = self
        
    }
    
    
    
    var startPointX:CGFloat = 0
    var startPointY:CGFloat = 0
    var scale:CGFloat = 1
    
    
    @objc func handleGesture(_ sender:UIGestureRecognizer){
        
        switch sender.state {
        
        case .began:
            
            let currentPoint = sender.location(in: self.view)
            startPointX = currentPoint.x
            startPointY = currentPoint.y
            
            break
            
        case .changed:
            
            let currentPoint = sender.location(in: self.view)
            
            scale = min(  (kScreenWidth-(currentPoint.x-startPointX))/kScreenWidth,         (kScreenHeight-(currentPoint.y-startPointY))/kScreenHeight)
            
            self.img.transform = CGAffineTransform(translationX: currentPoint.x-startPointX, y: (currentPoint.y-startPointY))
            
            self.infoView.alpha = self.infoView.alpha * scale
        
            break
        case .ended:
            
            if(scale <= 0.95){
                self.navigationController?.popViewController(animated: true)
            }
            
            if scale > CGFloat(0.95) {
                UIView.animate(withDuration: 0.2) {
                    self.img.transform = CGAffineTransform(translationX: 0, y: 0);
                    self.infoView.alpha = 1
                }
            }
            
            break
        default:
            break
        }
    }

}


extension DetailViewController:UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        return true
    }
    
}
