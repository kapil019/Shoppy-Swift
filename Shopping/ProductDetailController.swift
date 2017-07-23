//
//  ProductDetailController.swift
//  Shopping
//
//  Created by Kewal Kanojia on 13/03/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController {
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var getName = String()
    var getPrice = String()
    var getImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblName.text! = getName
        imgImage.image = getImage
        price.text! = getPrice
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
