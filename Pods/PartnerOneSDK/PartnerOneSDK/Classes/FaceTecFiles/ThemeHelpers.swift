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
        currentCustomization.cancelButtonCustomization.customImage = UIImage(named: "single_chevron_left_offwhite", in: Bundle.getBundle(), compatibleWith: nil)
        return currentCustomization
    }
    
    // Configure UX Color Scheme For Low Light Mode
    class func getLowLightCustomizationForTheme(theme: String) -> FaceTecCustomization {
        var currentCustomization = FaceTecCustomization()
        currentCustomization = Config.retrieveConfigurationWizardCustomization()
        currentCustomization.cancelButtonCustomization.customImage = UIImage(
            named: "single_chevron_left_offwhite",
            in: Bundle.getBundle(),
            compatibleWith: nil
        )
        return currentCustomization
    }
    
    // Configure UX Color Scheme For Low Light Mode
    class func getDynamicDimmingCustomizationForTheme(theme: String) -> FaceTecCustomization {
        let currentDynamicDimmingCustomization: FaceTecCustomization = getCustomizationForTheme(theme: theme)
        currentDynamicDimmingCustomization.cancelButtonCustomization.customImage = UIImage(named: "single_chevron_left_offwhite", in: Bundle.getBundle(), compatibleWith: nil)
        return currentDynamicDimmingCustomization
    }
}
