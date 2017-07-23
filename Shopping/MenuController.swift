//
//  MenuController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class MenuController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ManuNameArray:Array = [String]()
    var iconArray:Array = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ManuNameArray = [
            "Backpacks",
            "Value Packs & Combos",
            "Blankets",
            "Men T-Shirts",
            "Women T-Shirts",
            "Lowers",
            "Jackets & Shrugs",
            "Trackpants",
            "Home",
            "Soft Toys",
            "Map",
            "Setting",
            "Home"
        ]
        
        iconArray = [
            UIImage(named:"category_88185974")!,
            UIImage(named:"category_217022206")!,
            UIImage(named:"category_415492883")!,
            UIImage(named:"category_499035813")!,
            UIImage(named:"category_660226043")!,
            UIImage(named:"category_661555279")!,
            UIImage(named:"category_891667567")!,
            UIImage(named:"category_966973448")!,
            UIImage(named:"category_1024887059")!,
            UIImage(named:"category_1105402039")!,
            UIImage(named:"category_1547864751")!,
            UIImage(named:"category_1559306682")!,
            UIImage(named:"category_2091043475")!
        ]
        
//        imgProfile.layer.borderWidth = 2
//        imgProfile.layer.borderColor = UIColor.green.cgColor
//        imgProfile.layer.cornerRadius = 50
//        
//        imgProfile.layer.masksToBounds = false
//        imgProfile.clipsToBounds = true
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Code
//        let a = doHttpRequest(url: "category.php", method: "GET", params: "category:category");
//        print(a)
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
        print(ManuNameArray[indexPath.row])
        cell.lblMenuname.text! = ManuNameArray[indexPath.row]
        cell.imgIcon.image = iconArray[indexPath.row]
        
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
//            
//            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }
        if cell.lblMenuname.text! == "Message"
        {
            print("message Tapped")
            
//            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "MessageController") as! MessageViewController
//            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//            
//            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func logotUser(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "sessionToken")
//        self.performSegue(withIdentifier: "showHome", sender: self)
    }
    
    
}
