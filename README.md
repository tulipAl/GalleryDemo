# GalleryDemo Mobile App Document

## Screenshot

<img src="https://user-images.githubusercontent.com/44119669/125179883-0f288080-e1a8-11eb-960c-304eb1581bf0.png" width="200" height="400"><img src="https://user-images.githubusercontent.com/44119669/125179885-12237100-e1a8-11eb-8f2a-d0089d0e854d.png" width="200" height="400">

## Background 


The objective is to create a “Gallery Demo” - iOS mobile native application (Swift preferred)  consisting of two pages
1. Gallery page - this will be the home page for the app, it will show a list of images, the app must make a REST API call to URL  https://picsum.photos/v2/list  to get a list of pictures and extra information, Please show the images in a staggering list view (2 columns ) and add a click listener for the image, Once the user clicks on the image it takes the user to the “Gallery Detail Page”
2. Gallery detail page, please show a detailed view consisting of - image, author, and URL.


## Functional Requirements


1. The app must make a REST API call.
2. Users will see a scrollable collection of images from posts/images.
3. Show the images in a staggering list view (2 columns )
4. Users can click on an image and be taken to a detail page for the corresponding post. 
5. The post detail page will have the post’s metadata. 

## Non Functional Requirements

1. CollectionView performance. Make the cells http requirements Asynchronizely by using SDWebimage framework. 
2. Avoid editing the layer to reduce the burden of GPU. Use the UIBezierPath to make the corner radius.
3. Calculate the height of cell in advance. 
4. Try to make the size of image close to its actually size. 
5. Almofire framework to make HTTP request. Improve system performance.
6. FMBD to do SQLite database on iOS for caching ( Not necessary, If I have more time, I will do this). 
7. GCD to handle multithreading solutions. Only put the tasks of updating UI into main thread.
8. Use UIViewControllerAnimatedTransitioning to handle the transition animation.
9. For the UI/UX part, I learned a lot from Pinterest.
10. I first download the thumbnail size image for CollectionView. When user tap into detail page, I will start download the regular size image. This will make the main page faster and the logic works good. Another logic is direcly download the regular size at the main page, this wll slow the speed of main page, but will speed up the detail page. It is all about the trade off.
12. Programmatic UI
## App Size


2.2M
* Alamofire :  636KB
* MJRefresh : 144KB
* SDWebImage: 888KB

## Architecture


MVC: 
Simplest and most straightforward design pattern. Apple also recommend this pattern. But it has two main problems.

Problems:
One is massive view controller problem. We put all the logic into view controller. When the project become big, it become so hard to maintain and update the view controller. 
Another is test problem. Because view is so integrated with view controller. It become very hard to do unit tests of the controller. We have to do integration tests. 

MVVM:
It solves the two problems of MVC by introducing the new layer: ViewModel. ViewModel unload most of burden from view controller. And because view is separated from view model, so we can do interface test of view model. 

Conclusion: 
I will choose MVVM to do this project.

High Level Diagram:

<img src="https://user-images.githubusercontent.com/44119669/125179831-36328280-e1a7-11eb-9359-e026f385a8c5.png" width="600" height="400">

## Third Party Framework


Alamofire : 
Alamofire is an HTTP networking library written in Swift.
35.9K Stars

MJRefresh : 
An easy way to use pull-to-refresh.
13.5K Stars


SDWebImage:
Asynchronous image downloader with cache support as a UIImageView category

23.6K Stars


## Lorem Ipsum API


Get a list of images. https://picsum.photos/v2/list. 
The API will return 30 items per page by default.
One Item response format:

[
    {
        "id": "0",
        "author": "Alejandro Escamilla",
        "width": 5616,
        "height": 3744,
        "url": "https://unsplash.com/...",
        "download_url": "https://picsum.photos/..."
    }
]

Also, this API allows page and limit parameter to request more data. I consider about that in this project. I leave space for this function and import MJRefresh framework for footer fresh. It can be easily change to infinite scroll.


## Timeline 

<!-- <img width="485" alt="image" src="https://user-images.githubusercontent.com/44119669/125179838-5c582280-e1a7-11eb-98c0-36d83ae72878.png"> -->
<img src="https://user-images.githubusercontent.com/44119669/125179838-5c582280-e1a7-11eb-98c0-36d83ae72878.png" width="800" height="150">


## Reference 


https://picsum.photos

## Improvement 

1. I don't have any exprience with Combine but I use RXSwift before. The logic behind them is actully the same. For this project, I still use the notification and KVO to apply MVVM.
2. Not handle device rotation. Will improve it in the future.

