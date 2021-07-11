//
//  HomeVCExtension.swift
//  GalleryDemo
//
//  Created by apple on 2021/7/10.
//

import UIKit

extension HomeCollectionViewController:UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        return self
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        // FromView and ToView
        let cell:PhotoCollectionViewCell = collectionView.cellForItem(at: selectIndexPath!)! as! PhotoCollectionViewCell
        let fromView = cell.img
        
        
        let toVC:DetailViewController = transitionContext.viewController(forKey: .to)! as! DetailViewController
        let toView:UIImageView = toVC.img
        
        let containerView = transitionContext.containerView
        
        
        // Mock Detail Page
        let snapshotView = UIImageView(image: cell.img.image)
        snapshotView.frame = containerView.convert(fromView.frame, from: fromView.superview)
        
        let infoView = DetailInfoView()
        let photo = viewModel.model.photos[selectIndexPath!.item]
        infoView.config(author: photo.author, url: photo.url)
        snapshotView.addSubview(infoView)

        infoView.translatesAutoresizingMaskIntoConstraints = false
        let viewConstraints = [
            infoView.leftAnchor.constraint(equalTo: snapshotView.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: snapshotView.rightAnchor),
            infoView.topAnchor.constraint(equalTo: snapshotView.bottomAnchor),
            infoView.heightAnchor.constraint(equalToConstant: kScreenHeight-snapshotView.frame.height)
        ]

        NSLayoutConstraint.activate(viewConstraints)
        
        
        // Animation
        fromView.isHidden = true
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toView.isHidden = true
        toVC.infoView.isHidden = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1,initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            containerView.layoutIfNeeded()
            snapshotView.frame = containerView.convert(toView.frame, from: toView.superview)
            
        }) { (finished) in
            
            toVC.infoView.isHidden = false
            toView.isHidden = false
            fromView.isHidden = false
            snapshotView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}

extension DetailViewController:UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.55
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        return self
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        // FromView and ToView
        let fromVC:DetailViewController = transitionContext.viewController(forKey: .from) as! DetailViewController
        let fromView = fromVC.img!
        
        
        let toVC:HomeCollectionViewController = transitionContext.viewController(forKey: .to) as! HomeCollectionViewController
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        
        let containerView = transitionContext.containerView
        
        
        let cell:PhotoCollectionViewCell = toVC.collectionView.cellForItem(at: toVC.selectIndexPath!)! as! PhotoCollectionViewCell
        let originView = cell.img
        
        
        // Snapshot
        let snapShotView = fromView.snapshotView(afterScreenUpdates: false)
        snapShotView?.frame = containerView.convert(fromView.frame, from: fromView.superview)
        
        
        
        // Animation
        fromView.isHidden = true
        originView.isHidden = true
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapShotView!)
        
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.85, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            
            containerView.layoutIfNeeded()
            fromVC.view.alpha = 0
            snapShotView?.frame = containerView.convert((originView.frame), from: originView.superview)
            
        }) { (finished) in
            
            snapShotView?.removeFromSuperview()
            originView.isHidden = false
            transitionContext.completeTransition(true)
            
        }
        
    }
    
}

extension UIImage{
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: 30
        ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
