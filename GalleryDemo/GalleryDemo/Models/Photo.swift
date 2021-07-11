
import Foundation


class Photo : Codable{

    
//{"id":"117","author":"Daniel Ebersole","width":1544,"height":1024,"url":"https://unsplash.com/photos/Q14J2k8VE3U","download_url":"https://picsum.photos/id/117/1544/1024"},
//
    
    
    var id : String
    var author : String
    var width : Int
    var height : Int
    var url:String
    var download_url : String
    
    
    var thumbnailWidth:Double{
        return  Double((kScreenWidth-56)/2)
    }
    
    var thumbnailHeight:Double{
        return  thumbnailWidth / Double(width) * Double(height)
    }
    
    var downloadWidth:Double{
        return Double(kScreenWidth)
    }
    
    var downloadHeight:Double{
        return  downloadWidth / Double(width) * Double(height)
    }
    
    
    
    var thumbnailUrl:String{
        
       return getTheURLWithSize(width: thumbnailWidth, hight: thumbnailHeight)
    }
    
    var downloadUrl:String{
        
        return getTheURLWithSize(width: downloadWidth, hight: downloadHeight)
    }
    
    private func getTheURLWithSize(width:Double,hight:Double)->String{
        var arr = download_url.split(separator: "/")
        arr[arr.count-2] = "\(Int(width))"
        arr[arr.count-1] = "\(Int(hight))"
        
        var str = arr.joined(separator: "/")
        str.insert("/", at: str.index(str.startIndex, offsetBy: 6))
        return str
    }
}


