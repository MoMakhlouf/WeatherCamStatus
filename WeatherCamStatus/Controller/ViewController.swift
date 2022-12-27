//
//  ViewController.swift
//  WeatherCamStatus
//
//  Created by Mohamed Makhlouf Ahmed on 13/11/2022.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {

    @IBOutlet weak var weatherStatusView: UIView!
    @IBOutlet weak var takePhotoButtonPressed: UIButton!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let locationManager = CLLocationManager()
    let networkManager = NetworkManager()
    let statusDB = DBManager.sharedInstance
    var statusList = [Status]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var tempDegree : String = ""
   
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    //  var images = []
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherStatusView.isHidden = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        networkManager.delegate = self
        
        takePhotoButtonPressed.layer.cornerRadius = 12
     
         
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        weatherStatusView.isHidden = false
    }

    @IBAction func takePhoto(_ sender: Any) {
       
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary  //.camera
            picker.delegate = self
            present(picker , animated: true)
       // weatherStatusView.isHidden = true

        appNameLabel.isHidden = true
    }
    
    @IBAction func savePhotoButtonPressed(_ sender: UIBarButtonItem) {
      
        if imageView.image == nil {
            Alert.showAlert(title: "No Photo Added", titleColor: .white, message: "You Must Take a photo First", messageColor: .white, preferredStyle: .alert, titleAction: "OK", actionStyle: .default, vc: self)

        } else{
            var degree = tempDegree
            let imageData = imageView.image!.pngData() as NSData?
            statusDB.saveToDB(appDelegate: appDelegate, city: cityNameTextField.text ?? "Not Found", degree: Double(degree) ?? 0 , photo: imageData! as Data , weatherStatus: descriptionLabel.text ?? "Not Found")
            
            weatherStatusView.isHidden = true
            
            let list = storyboard?.instantiateViewController(withIdentifier: "list") as! photosListViewController
            self.navigationController?.pushViewController(list, animated: true)
            
            imageView.image = nil
            appNameLabel.isHidden = false

        }
    }

}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
     
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true , completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true , completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        imageView.image = image
        }
    }
}

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityNameTextField.text = weather.cityName
            self.descriptionLabel.text = weather.desc
            self.tempDegree = weather.temperatureString
            self.tempLabel.text = self.tempDegree + "°C"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherStatusView.isHidden = false
            networkManager.weatherNetwork(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
