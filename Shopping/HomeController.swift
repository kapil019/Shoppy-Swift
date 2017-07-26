//
//  HomeController.swift
//  Shopping
//
//  Created by Kewal Kanojia on 12/03/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit
import SDWebImage


class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var open: UIBarButtonItem!
    @IBOutlet weak var homeSlider: UIScrollView!
    
    var names: [String] = []
    var product:[String: Any] = [:];
    
    var productImage: [String] = []
    var productName: [String] = []
    var productPrice: [String] = []
    
    var sliderImageName = [String]()
    
    var sliderImage:[String: Any] = [:];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.open.target = self.revealViewController()
        self.open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        //Create Slider
        self.createSlider()
        self.getProduct()
    }
    
    
    private func createSlider() {
        
        if let categoryListCoreData = UserDefaults.standard.object(forKey: "sliderImage") as? [String: Any] {
            sliderImage = categoryListCoreData;
        } else {
            sliderImage = doHttpRequest(url: "slider.php", method: "GET", params: "")!;
            UserDefaults.standard.set(sliderImage, forKey: "sliderImage");
        }
        
        if !(sliderImage.isEmpty) {
            let status = sliderImage["status"] as! String
            if(status == "false") {
                print(sliderImage["error"]!);
            } else {
                let sliderImageArray: NSArray = sliderImage["slider"] as! NSArray
                for i in 0 ..< sliderImageArray.count{
                    //getting the data at each index
                    let sliderArray = sliderImageArray[i] as! Dictionary<String,AnyObject>
                    let sliderImage = self.sliderBaseUrl()+(sliderArray["sliderImage"]! as! String)
                    sliderImageName.append(sliderImage)
                }
            }
        }
        
        for i in 0..<sliderImageName.count {
            let imageView = UIImageView()
            let mediaURL = URL(string: sliderImageName[i]);
            let _ = try! Data(contentsOf: mediaURL!);
            let _ = SDWebImageDownloader.shared().downloadImage(with: mediaURL, options: [], progress: nil, completed: { (image, data, error, finished) in
                DispatchQueue.main.async {
                    imageView.image = image
                }
            })
            
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y:0 , width: self.homeSlider.frame.width, height: self.homeSlider.frame.height)
            
            homeSlider.contentSize.width = homeSlider.frame.width * CGFloat(i+1)
            homeSlider.addSubview(imageView)
        }
    }

    
    private func getProduct() {
        
        if let productListCoreData = UserDefaults.standard.object(forKey: "productList") as? [String: Any] {
            product = productListCoreData;
        } else {
            product = doHttpRequest(url: "product.php", method: "GET", params: "")!;
            UserDefaults.standard.set(product, forKey: "productList");
        }
//        print(product)
        if !(product.isEmpty) {
            let status = product["status"] as! String
            if(status == "false") {
                print(product["error"]!);
            } else {
                let productArray: NSArray = product["product"] as! NSArray
                for i in 0 ..< productArray.count {
                    //getting the data at each index
                    let productDetails = productArray[i] as! Dictionary<String,AnyObject>
                    let _productImage = self.productBaseUrl()+(productDetails["productImage"]! as! String)
                    let _productName = productDetails["productName"]! as! String
                    let _productPrice = productDetails["productRate"]! as! String
                    productImage.append(_productImage)
                    productName.append(_productName)
                    productPrice.append(_productPrice)
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCellController
        let mediaURL = URL(string: productImage[indexPath.row]);
        do {
            let _ = try Data(contentsOf: mediaURL!);
            let _ = SDWebImageDownloader.shared().downloadImage(with: mediaURL, options: [], progress: nil, completed: { (image, data, error,   finished) in
                DispatchQueue.main.async {
                    cell.productImg.image = image
                }
            })
        } catch {
            print("Error While Loading Image.")
        }
        
        cell.productName.text! = productName[indexPath.row]
        cell.productPrice.text! = productPrice[indexPath.row]
//        cell.layer.borderWidth = 1.0;
//        cell.layer.borderColor = UIColor.gray.cgColor;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 1
        
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let desCV = MainStoryboard.instantiateViewController(withIdentifier: "ProductDetailController") as! ProductDetailController
        desCV.getImage = productImage[indexPath.row]
        desCV.getName = productName[indexPath.row]
        desCV.getPrice = productPrice[indexPath.row]
        self.show(desCV, sender: nil)
        
    }
    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    DispatchQueue.main.async(execute: {
                        imageView.image = image
                        imageView.alpha = 0
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                    })
                } else {
                    print("error")
                }
            }
        })
        task.resume()
    }

}
