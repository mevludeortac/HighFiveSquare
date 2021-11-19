//
//  MapVC.swift
//  HighFiveSquare
//
//  Created by MEWO on 12.11.2021.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    //daha sonra başka yerlerde kullanabiliriz o yüzden class içinde tanımlıyoruz.
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        //konum olarak en iyi, em net, en doğru sonucu almak için
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //sadece uygulamayı kullandığımız zaman konumu göstersin istiyoruz
        locationManager.requestWhenInUseAuthorization()
        //kullanıcının bulunduğu yeri güncelleme işlemi
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(ChooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(recognizer)
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
    }
    @objc func ChooseLocation( gestureRecognizer: UIGestureRecognizer){
        //başladıysa
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            //mapviewde tıklanan noktayı touches'a atıyoruz ve böylelikle tıklanan konumu alıyoruz
            let touches = gestureRecognizer.location(in: self.mapView)
            //tıklanan yeri coordinata çevirmek
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
        }
    }
    
    //kullanıcının konumu güncellendikten sonra yapılacak işlemi yazdığımız fonksiyon
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        //enlem ve boylam deltası: haritayı ne kadar zoomlayabileceğimizi yazıyoruz. haritanın boyutunu width ve heightini belirtiyo. ne kadar küçük yazarsak o kadaar zoomlayabiliyoruz
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        //
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

    @objc func saveButtonClicked(){
        //parse
        //görsel hariç tüm objeleri parse ediyoruz
        let placeModel = PlaceModel.sharedInstance
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["description"] = placeModel.placedescription
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        //görsel kaydetme
        //görseli dataya çevirmemiz gerekiyor
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(data: imageData)
        }
        object.saveInBackground { (succes, error) in
            if error != nil{
                let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
    }
    @objc func backButtonClicked(){
        //parse
        
    }

}
