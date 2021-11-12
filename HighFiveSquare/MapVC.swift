//
//  MapVC.swift
//  HighFiveSquare
//
//  Created by MEWO on 12.11.2021.
//

import UIKit
import MapKit
class MapVC: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
    }
    

    @objc func saveButtonClicked(){
        //parse
        
    }
    @objc func backButtonClicked(){
        //parse
        
    }

}
