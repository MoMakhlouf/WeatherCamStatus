//
//  Alert.swift
//  WeatherCamStatus
//
//  Created by Mohamed Makhlouf Ahmed on 01/12/2022.
//

import Foundation
import UIKit

//class Alert {
//
//    static func displayAlert(title: String, message: String) {
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.black
//
//        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
//            fatalError("keyWindow has no rootViewController")
//            return
//        }
//
//        viewController.present(alert, animated: true, completion: nil)
//    }
//
//}
//
//extension UIViewController{
//    func showAlertError(title: String, message: String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert )
//        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
//    }
//}
//extension UIViewController {
//    func showAlertSheet(title:String, message:String,complition:@escaping (Bool)->Void){
//        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
//        let logOut = UIAlertAction(title: "Log out", style: .destructive) { _ in
//            complition(true)
//        }
//        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
//            complition(false)
//        }
//        actionSheet.addAction(logOut)
//        actionSheet.addAction(cancel)
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//}

class Alert {
    class func showAlert(title: String, titleColor: UIColor, message: String, messageColor : UIColor , preferredStyle: UIAlertController.Style, titleAction: String, actionStyle: UIAlertAction.Style, vc: UIViewController) {
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: titleColor])
        
        let messageAttributedString = NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: messageColor])
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.black
        
            alert.setValue(attributedString, forKey: "attributedTitle")
            alert.setValue(messageAttributedString, forKey: "attributedMessage")

            alert.addAction(UIAlertAction(title: titleAction, style: actionStyle, handler: nil))
            vc.present(alert, animated: true)
    }
}



