//
//  ViewController.swift
//  login_with_facebook
//
//  Created by Bibek on 5/30/19.
//  Copyright © 2019 ARtech. All rights reserved.
//

import UIKit
//import Fac

class ViewController: UIViewController,LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("login successfull")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        let loginButton = FBLoginButton()
        // Optional: Place the button in the center of your view.
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        
        loginButton.delegate = self
        
        if (AccessToken.current != nil) {
           fetchProfile()
        }
        
    }
    
    func fetchProfile(){
       print("fetch profile")
        
        let parameters = ["fields" : "email,first_name,last_name,picture.type(large)"]
        
      
        
        GraphRequest(graphPath: "me",parameters: parameters).start(completionHandler: { (connection, result, error) -> Void in

            if error != nil{
                print(error as Any)
                return
            }

            print("Json : ",result!)
            
        
            
             if let data = result as? NSDictionary
             {
                
                if let picture = data.object(forKey: "picture") as? NSDictionary,let data = picture["data"] as? NSDictionary, let url = data["url"] as? String{
                    print("Url : ",url)
                }
                
//                if let email = data.object(forKey: "first_name") as? String
//                {
//                    print("Email : ",email)
//                }
//                else
//                {
//                    // If user have signup with mobile number you are not able to get their email address
//                    print("We are unable to access Facebook account details, please use other sign in methods.")
//                }
            }
          
            })
        
    }


}

