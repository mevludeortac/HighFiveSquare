//
//  DetailsVC.swift
//  HighFiveSquare
//
//  Created by MEWO on 12.11.2021.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detailsPlaceName: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsPlaceType: UILabel!
    @IBOutlet weak var detailsPlaceDescription: UILabel!
    
        //diğer tarafta seçilen id'ye eşitlemek için, ordaki bilgiyi buraya aktarmamıza yardımcı olacak bir değişken
    var chosenPlaceId = ""
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        
        getDataFromParse()
        detailsMapView.delegate = self
            
    }
    func getDataFromParse(){
        //bi query oluşturup parse'taki tablomuzu bu query'ye atıyoruz
    //veritabanımızdaki objectId'mizi bu dosyada oluşturduğumuz chosenPlaceId'mize eşit olanlarını buluyoruz
    let query = PFQuery(className: "Places")
    query.whereKey("objectId", equalTo: chosenPlaceId)
    query.findObjectsInBackground { (objects, error) in
        if error != nil {
            
        }else{
            if objects != nil{
                if objects!.count > 0{
                    let chosenPlaceObject = objects![0]
                    
                    //OBJECTS
                    
                    if let placeName = chosenPlaceObject.object(forKey: "name") as? String{
                        self.detailsPlaceName.text = placeName
                    }
                    if let placeType = chosenPlaceObject.object(forKey: "type") as? String{
                        self.detailsPlaceType.text = placeType
                    }
                    if let placeDescription = chosenPlaceObject.object(forKey: "description") as? String{
                        self.detailsPlaceDescription.text = placeDescription
                    }
                    
                    if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String{
                        if let placeLatitudeDouble = Double(placeLatitude){
                            self.chosenLatitude = placeLatitudeDouble
                        }
                    }
                    if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String{
                        if let placeLongitudeDouble = Double(placeLongitude){
                            self.chosenLongitude = placeLongitudeDouble
                        }
                    }
                    //görseli data olarak almamız lazım, datayı imageView'ımızın içinde UIImageView olarak göstermemiz lazım
                    if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject{
                        imageData.getDataInBackground { (data, error) in
                            if error == nil{
                                self.detailsImageView.image = UIImage(data: data!)
                            }
                        }
                    }
                    
                }
                //objenin mapse aktarıldığı yer
                //MAPS
                
                let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                let region = MKCoordinateRegion(center: location, span: span)
                self.detailsMapView.setRegion(region, animated: true)
                
                
                //pin gösterme
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.detailsPlaceName.text!
                annotation.subtitle = self.detailsPlaceType.text!
                self.detailsMapView.addAnnotation(annotation)
            }
        }
    }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true //sağ tarafında bir buton oluşturmasına izin veriyoruz
            let iButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = iButton
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
            //iButton'a tıklandıktan sonra napacağımızı yazıyoruz
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLatitude != 0.0 && self.chosenLongitude != 0.0{
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count>0{
                        
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsPlaceName.text
                        
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
    
    
    
}
