//
//  PlacesVC.swift
//  HighFiveSquare
//
//  Created by MEWO on 10.11.2021.
//

import UIKit

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    

    @objc func addButtonClicked(){
        //segue
    }
       
    }


