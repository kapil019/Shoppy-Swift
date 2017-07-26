//
//  Extension.swift
//  Shopping
//
//  Created by Kewal Kanojia on 12/04/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func baseUrl() -> String {
//        return "http://192.168.0.105/api/";
        return "http://dlcl.in/api/";
    }
    
    func categoryBaseUrl() -> String {
//        return "http://192.168.0.105/api/upload/category/";
        return "http://dlcl.in/api/upload/category/";
    }
    
    func doHttpRequest(url: String, method:String, params:String) -> [String: Any]? {
        let apiUrl = self.baseUrl()+url;
        print("Url:- "+apiUrl)
        print("Method:- "+method)
        print("Params:- "+params)
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method
        let semaphore = DispatchSemaphore(value: 0)
        if method != "GET" {
        request.httpBody = params.data(using: .utf8)
        }
        var resp:[String: Any] = [:];
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            resp = json!
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        print("Resp")
        print(resp)
        return resp;
    }
    
    func checkLogin(contactSegue: String) -> Bool {
        var ret:Bool = false;
        if let sessionToken = UserDefaults.standard.object(forKey: "sessionToken") as? String {
            if !sessionToken.isEmpty {
                print(sessionToken)
                if !contactSegue.isEmpty {
                    self.performSegue(withIdentifier: contactSegue, sender: nil);
                } else {
                    ret = true;
                }
            }
        }
        return ret
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
