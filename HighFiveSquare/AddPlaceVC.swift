//
//  AddPlaceVC.swift
//  HighFiveSquare
//
//  Created by MEWO on 12.11.2021.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeDescription: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //görselimizi tıklanabilir hale getiriyor
        placeImageView.isUserInteractionEnabled = true
        //tıklandığı anda çalışacak fonksiyonu söylüyoruz
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    

    //tıklandığı anda çalışacak fonksiyon
    //fotoğraf galerisinden fotoğraf seçme işlemi
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    //fotoğraf seçildikten sonra ne olacağını yazıyoruz
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as! UIImage
        //işlem başarılı olduktan sonra viewcontroller'ımıza geri dönme işlemi
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        //önce textfieldların boş olup olmadığnı kontrol et
        //ardından imageview'ın boş olup olmadığnı kontrol et
        //eğer boş iseler, uyarı ver
        //boş değiller ise singleton yapısına uygun olarak  objelerimizi atıyoruz
        if placeName.text != nil &&  placeType.text != nil && placeDescription.text != nil{
            if let choosenImage = placeImageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeName.text!
                placeModel.placeType = placeType.text!
                placeModel.placedescription = placeDescription.text!
                placeModel.placeImage = choosenImage
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            let alert = UIAlertController(title: "error", message: "check please", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
        }
        
    }
    
}
