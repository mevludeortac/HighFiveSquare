//
//  ViewController.swift
//  HighFiveSquare
//
//  Created by MEWO on 9.11.2021.
//

import UIKit
import ParseSwift
import Parse
class ViewController: UIViewController {

    

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //parse veri kaydetme
       /* let parseObject = PFObject(className: "coffee")
        parseObject["name"] = "turkish coffe"
        parseObject["calories"] = 2
        parseObject["price"] = 12.00
        parseObject.saveInBackground { (success, error) in
            if error != nil
            {
                print(error?.localizedDescription)
            }else{
                print("ordered")
            }
        }
        
        //parse veri çekmek
        let query = PFQuery(className: "coffee")
        query.whereKey("name", equalTo: "cortado") //isim filtreleme
        query.whereKey("price", greaterThan: 20.00) //fiyat filtreleme
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                print(objects)
            }
        }*/
        }
    
    @IBAction func signInClicked(_ sender: Any) {
        if usernameTxt.text != nil && passwordTxt.text != nil{
            PFUser.logInWithUsername(inBackground: usernameTxt.text!, password: passwordTxt.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "error", messageInput: "is empty")
                    
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput: "error", messageInput: "wrong info, check please")
        }
    
    }
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameTxt.text != "" && passwordTxt.text != "" {
            
            let user = PFUser()
            user.username = usernameTxt.text
            user.password = passwordTxt.text
            user.signUpInBackground { (success, error) in
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error!!")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput: "OK", messageInput: "wrong info, check please")
        }
    }
    
    func makeAlert(titleInput: String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

