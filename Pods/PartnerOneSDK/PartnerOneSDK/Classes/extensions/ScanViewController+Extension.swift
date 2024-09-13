//
//  ScanViewController+Extension.swift
//  PartnerOneSDK
//
//  Created by Adriano Mazucato on 27/10/23.
//

extension ScanViewController {
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
        present(alert, animated: true, completion: nil)
    }
}
