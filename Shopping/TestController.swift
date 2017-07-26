//
//  TestController.swift
//  Shopping
//
//  Created by Kewal Kanojia on 06/04/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit

class TestController: UIViewController {

    
    @IBOutlet weak var hello: UILabel!
    
    
//    @IBOutlet weak var testImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        loginUser()
//        get_image("https://lh5.googleusercontent.com/-H2BUGcg4r6c/AAAAAAAAAAI/AAAAAAAAgQs/lS4tXXu5vfc/s0-c-k-no-ns/photo.jpg",testImage);
        // Do any additional setup after loading the view.
        print(hello.text!)
    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
//    func loginUser() {
//        let url:String = ""
//        let postString:String = "username=test&pass=test"
//        self.postRequest(urlSource: url, postString: postString, result { (dataResult, errorResult) -> () in
//            if errorResult != nil {
//                print("error - could not connect to server");
//            } else {
//                
//            }
//        }
//    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func get_image(_ url_str:String, _ imageView:UIImageView)
//    {
//        
//        let url:URL = URL(string: url_str)!
//        let session = URLSession.shared
//        let task = session.dataTask(with: url, completionHandler: {
//            (
//            data, response, error) in
//            
//            if data != nil
//            {
//                let image = UIImage(data: data!)
//                
//                if(image != nil)
//                {
//                    DispatchQueue.main.async(execute: {
//                        imageView.image = image
//                        imageView.alpha = 0
//                        UIView.animate(withDuration: 2.5, animations: {
//                            imageView.alpha = 1.0
//                        })
//                    })
//                } else {
//                    print("error")
//                }
//            }
//        })
//        task.resume()
//    }

}
