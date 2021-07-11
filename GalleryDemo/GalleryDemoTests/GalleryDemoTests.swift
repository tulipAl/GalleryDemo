//
//  GalleryDemoTests.swift
//  GalleryDemoTests
//
//  Created by apple on 2021/7/9.
//

import XCTest
@testable import GalleryDemo

class GalleryDemoTests: XCTestCase {

    var photosViewModel:PhotosViewModel!
    var photosObserver : NSKeyValueObservation?
    
    var count = 0
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        photosViewModel = PhotosViewModel()
        
        photosObserver = photosViewModel.observe(\.modelChange, changeHandler: { [weak self] (viewModel, change) in
            self?.count = 1
        })
    }
    
    
    func testViewModelKVO(){
        
        photosViewModel.modelChange = true
        XCTAssert(self.count == 1)
    
    }
    
    func testNotification(){
        
        XCTAssert(photosViewModel.modelChange == false)
        
        NotificationCenter.default.post(name: PhotoList.changeNotification, object: nil)
        
        XCTAssert(photosViewModel.modelChange == true)
        XCTAssert(self.count == 1)
    }
    
    
    func testPhotosViewModelContents(){
        XCTAssert(photosViewModel.model.photos.isEmpty)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
