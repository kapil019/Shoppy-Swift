//
//  MenuController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit
import SDWebImage

class MenuController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ManuNameArray:Array = [String]()
    var iconArray:Array = [String]()
    override func viewDidLoad() {
        let categoryLoading = self.displayLoading();
        super.viewDidLoad()
        var categoryList:[String: Any];
        
        if let categoryListCoreData = UserDefaults.standard.object(forKey: "categoryList") as? [String: Any] {
            categoryList = categoryListCoreData;
        } else {
            categoryList = doHttpRequest(url: "category.php", method: "GET", params: "category:category")!;
            UserDefaults.standard.set(categoryList, forKey: "categoryList");
        }
        
        if !(categoryList.isEmpty) {
            let status = categoryList["status"] as! String
            if(status == "false") {
                print(categoryList["error"]!);
            } else {
                categoryLoading.dismiss(animated: false, completion: {})
                let categoryListArray: NSArray = categoryList["category"] as! NSArray
                for i in 0 ..< categoryListArray.count{
                    //getting the data at each index
                    let categoryArray = categoryListArray[i] as! Dictionary<String,AnyObject>
                    self.ManuNameArray.append(categoryArray["categoryName"]! as! String)
                    let categoryImage = self.categoryBaseUrl()+(categoryArray["categoryImage"]! as! String)
                    self.iconArray.append(categoryImage)
                }
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Code
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.lblMenuname.text! = ManuNameArray[indexPath.row]
        let mediaURL = URL(string: iconArray[indexPath.row]);
        let _ = try! Data(contentsOf: mediaURL!);
        let _ = SDWebImageDownloader.shared().downloadImage(with: mediaURL, options: [], progress: nil, completed: { (image, data, error, finished) in
                DispatchQueue.main.async {
                    cell.imgIcon.image = image
                }
            })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        
        let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
        print(cell.lblMenuname.text!)
        if cell.lblMenuname.text! == "Home"
        {
            print("Home Tapped")
//            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
//            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }
        if cell.lblMenuname.text! == "Message"
        {
            print("message Tapped")
        }
        if cell.lblMenuname.text! == "Map"
        {
            print("Map Tapped")
        }
        if cell.lblMenuname.text! == "Setting"
        {
            print("setting Tapped")
        }
    }
    
    @IBAction func logotUser(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "sessionToken")
        UserDefaults.standard.removeObject(forKey: "categoryList")
        UserDefaults.standard.removeObject(forKey: "productList")
//        self.performSegue(withIdentifier: "showHome", sender: self)
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let desCV = MainStoryboard.instantiateViewController(withIdentifier: "Login") as! LoginController
        self.show(desCV, sender: nil)
    }
    
    
}
