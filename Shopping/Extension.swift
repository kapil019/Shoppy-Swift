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
        return "http://localhost/api/";
    }
    
    func doHttpRequest(url: String, method:String, params:String) -> [String: Any]? {
        let baseUrl = self.baseUrl();
        var request = URLRequest(url: URL(string: baseUrl+url)!)
        request.httpMethod = method
        let semaphore = DispatchSemaphore(value: 0)
        request.httpBody = params.data(using: .utf8)
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
            print(json)
            resp = json!
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
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
