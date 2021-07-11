//
//  HomeCollectionViewController.swift
//  GalleryDemo
//
//  Created by apple on 2021/7/9.
//

import UIKit


class HomeCollectionViewController: UICollectionViewController {
    
    let viewModel = PhotosViewModel()
    var observer : NSKeyValueObservation?
    
    var selectIndexPath:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Register cell classes
        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: .photoCellIdentity) 
        
        view.backgroundColor = .white
        
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        
        
        
        //KVO
        observer = viewModel.observe(\.modelChange, changeHandler: { [weak self] (viewModel, change) in
            
            self?.collectionView.reloadData()
            
        })
        
        viewModel.loadNew()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.delegate = self
        
    }
    
}


//  UICollectionViewDelegateFlowLayout

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.model.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .photoCellIdentity, for: indexPath as IndexPath) as! PhotoCollectionViewCell
        cell.config(photo: viewModel.model.photos[indexPath.item])
        return cell
    }
}


//  UICollectionViewDelegate

extension HomeCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.viewModel.photo = viewModel.model.photos[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // Tap animation
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        let cell = collectionView.cellForItem(at: indexPath)
        selectIndexPath = indexPath
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        return true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        if selectIndexPath == indexPath {
            UIView.animate(withDuration: 0.2) {
                cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                return
            }
        }
        
    }
    
}

extension HomeCollectionViewController: HeightDelegate {
    
    func heightForPhotoAtIndexPath(indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.model.photos[indexPath.item].thumbnailHeight)
    }
    
}


