//
//  ThemeHelpers.swift
//  FaceTecSDK-Sample-App
//

import Foundation
import UIKit
import FaceTecSDK

class ThemeHelpers {

    public class func setAppTheme(theme: String) {
        Config.currentCustomization = getCustomizationForTheme(theme: theme)
        Config.currentLowLightCustomization = getLowLightCustomizationForTheme(theme: theme)
        Config.currentDynamicDimmingCustomization = getDynamicDimmingCustomizationForTheme(theme: theme)
        
        FaceTec.sdk.setCustomization(Config.currentCustomization)
        FaceTec.sdk.setLowLightCustomization(Config.currentLowLightCustomization)
        FaceTec.sdk.setDynamicDimmingCustomization(Config.currentDynamicDimmingCustomization)
    }
    
    class func getCustomizationForTheme(theme: String) -> FaceTecCustomization {
        var currentCustomization = FaceTecCustomization()
        

            currentCustomization = Config.retrieveConfigurationWizardCustomization()
        currentCustomization.cancelButtonCustomization.customImage = UIImage(named: "single_chevron_left_offred")
        return currentCustomization
    }
    
    // Configure UX Color Scheme For Low Light Mode
    class func getLowLightCustomizationForTheme(theme: String) -> FaceTecCustomization {
        var currentCustomization = FaceTecCustomization()
        
        

            currentCustomization = Config.retrieveConfigurationWizardCustomization()
        currentCustomization.cancelButtonCustomization.customImage = UIImage(named: "single_chevron_left_offred")
        return currentCustomization
    }
    
    // Configure UX Color Scheme For Low Light Mode
    class func getDynamicDimmingCustomizationForTheme(theme: String) -> FaceTecCustomization {
        var currentDynamicDimmingCustomization: FaceTecCustomization = getCustomizationForTheme(theme: theme)
        currentDynamicDimmingCustomization.cancelButtonCustomization.customImage = UIImage(named: "single_chevron_left_offred")
        return currentDynamicDimmingCustomization
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
