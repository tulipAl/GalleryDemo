

import Foundation
import Alamofire

class PhotoList{
    
    static let changeNotification = Notification.Name("PhotoListChange")
    
    var page = 1
    var photos:[Photo]
    
    private let defaultURL = "https://picsum.photos/v2/list"
    
    init() {
        photos = [Photo]()
    }
    
    
    func download(new:Bool){

        
//        if(new){
//            self.page = 1
//        }else{
//            self.page += 1
//        }
        
        AF.request(defaultURL).responseData { response in
            
            
            switch response.result {
            case .success(let data):
    
                do{
                
//                    if (new){
//                        self.photos = try JSONDecoder().decode([Photo].self, from: data)
//                    }else{
//                        self.photos += try JSONDecoder().decode([Photo].self, from: data)
//                    }
                    
                    self.photos = try JSONDecoder().decode([Photo].self, from: data)
                    NotificationCenter.default.post(name: PhotoList.changeNotification, object: nil)
                    
                }catch{
                    print(error)
                }
                
                
            case .failure(let error):
                print("Something went wrong: \(error)")
            }
            
            
        }
        
    }
    
}

