//
//  UIViewController+extension.swift
//  PartnerOneSDK
//
//  Created by Adriano Mazucato on 22/08/23.
//

public extension UIViewController {
    
    func showModal(title: String, message: String) {
     
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (nil) in
            alert.dismiss(animated: true)
        }))

        self.present(alert, animated: true, completion: nil)
    }
}
