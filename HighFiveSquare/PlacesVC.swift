//
//  PlacesVC.swift
//  HighFiveSquare
//
//  Created by MEWO on 10.11.2021.
//

import UIKit
import Parse

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
    }
    

    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
    @objc func logoutButtonClicked(){
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }

    }

    

    }
