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
        self.performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
}
