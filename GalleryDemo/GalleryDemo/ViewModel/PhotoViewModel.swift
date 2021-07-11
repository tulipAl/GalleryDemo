

import Foundation


class PhotosViewModel:NSObject{
     
    @objc dynamic var modelChange = false
    
    let model = PhotoList()
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeNotification(_:)), name: PhotoList.changeNotification, object: nil)
    }
    
    @objc func handleChangeNotification(_ noti:Notification){
        
        modelChange = true
        
    }
    
    func loadNew(){
        download(new: true)
    }
    
    func loadMore(){
        download(new: false)
    }
    
    private func download(new:Bool){
        model.download(new: new)
    }
    
    
}
