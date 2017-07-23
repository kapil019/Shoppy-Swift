//
//  HomeController.swift
//  Shopping
//
//  Created by Kewal Kanojia on 12/03/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit



class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var open: UIBarButtonItem!
    @IBOutlet weak var homeSlider: UIScrollView!
    
    var names: [String] = []
    
    var productImageName = [UIImage(named: "th_product_13400"),UIImage(named: "th_product_13440"),UIImage(named: "th_product_87022"),UIImage(named: "th_product_151530"),UIImage(named: "th_product_152000"),UIImage(named: "th_product_163400"),UIImage(named: "th_product_172560"),UIImage(named: "th_product_1462389051")]
    
    var productNameArray = ["First Shoes","2 shoes","First Shoes","2 shoes","First Shoes","2 shoes","First Shoes","2 shoes"]
    var productPriceArray = ["Rs. 2000","Rs. 1000","Rs. 3000","Rs. 400","Rs. 100","Rs. 10","Rs. 190","Rs. 56"]
    
    var sliderImageName = [UIImage()]
    override func viewDidLoad() {
        
//        let a = doHttpRequest(url: "category.php", method: "GET", params: "category:category");
//        print(a)
        
//        let isLoged = self.checkLogin(contactSegue: "")
        
        super.viewDidLoad()
        
        let url=URL(string:"http://localhost/being/api/homeSlider.php")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["slider"] {
                for index in 0...arrJSON.count-1 {
//                    let aObject = "http://localhost/being/upload/slider/\(arrJSON[index]!)"
//                    print(aObject)
//                    sliderImageName.append(aObject);
                }
            }
//            print(sliderImageName)
        }
        catch {
            
        }
        
        
        self.open.target = self.revealViewController()
        self.open.action = #selector(SWRevealViewController.revealToggle(_:))
        sliderImageName = [UIImage(named: "slider1")!,UIImage(named: "slider2")!,UIImage(named: "slider3")!]

        for i in 0..<sliderImageName.count{
            
            let imageView = UIImageView()
            imageView.image = sliderImageName[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y:0 , width: self.homeSlider.frame.width, height: self.homeSlider.frame.height)
            
            homeSlider.contentSize.width = homeSlider.frame.width * CGFloat(i+1)
            
            homeSlider.addSubview(imageView)
        }
    }

    
//    func getProduct() -> String {
//        var request = URLRequest(url: URL(string: "http://localhost/being/api/homeSlider.php")!)
//        request.httpMethod = "GET"
//        //        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print(error!)
//                return
//            }
//            guard let data = data else {
//                print("Data is empty")
//                return
//            }
//            
//            let json = try! JSONSerialization.jsonObject(with: data, options: [])
//            print(json)
//            return
//        }
//        task.resume()
//        return
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCellController
        cell.productImg.image = productImageName[indexPath.row]
        cell.productName.text! = productNameArray[indexPath.row]
        cell.productPrice.text! = productPriceArray[indexPath.row]
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
        desCV.getImage = productImageName[indexPath.row]!
        desCV.getName = productNameArray[indexPath.row]
        desCV.getPrice = productPriceArray[indexPath.row]
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
