import Foundation
import UIKit
import FaceTecSDK
import AVFoundation

class SampleAppUtilities: NSObject, FaceTecCustomAnimationDelegate {
    enum SampleAppVocalGuidanceMode {
        case OFF
        case MINIMAL
        case FULL
    }
    
    var vocalGuidanceOnPlayer: AVAudioPlayer!
    var vocalGuidanceOffPlayer: AVAudioPlayer!
    static var sampleAppVocalGuidanceMode: SampleAppVocalGuidanceMode!
    
    // Reference to app's main view controller
    let sampleAppVC: ScanViewController!
    
    var currentTheme = Config.wasSDKConfiguredWithConfigWizard ? "Config Wizard Theme" : "FaceTec Theme"
    var themeTransitionTextTimer: Timer!
    
    var networkIssueDetected = false
    
    init(vc: ScanViewController) {
        sampleAppVC = vc
    }
    
    func startSessionTokenConnectionTextTimer() {
        themeTransitionTextTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showSessionTokenConnectionText), userInfo: nil, repeats: false)
    }
    
    @objc func showSessionTokenConnectionText() {
        UIView.animate(withDuration: 0.6) {
//            self.sampleAppVC.themeTransitionText.alpha = 1
        }
    }

    func hideSessionTokenConnectionText() {
        themeTransitionTextTimer.invalidate()
        themeTransitionTextTimer = nil
    }
 
    public static func setOCRLocalization() {
        // Set the strings to be used for group names, field names, and placeholder texts for the FaceTec ID Scan User OCR Confirmation Screen.
        // DEVELOPER NOTE: For this demo, we are using the template json file, 'FaceTec_OCR_Customization.json,' as the parameter in calling this API.
        // For the configureOCRLocalization API parameter, you may use any dictionary object that follows the same structure and key naming as the template json file, 'FaceTec_OCR_Customization.json'.
        if let path = Bundle.main.path(forResource: "FaceTec_OCR_Customization", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
                if let jsonDictionary = jsonObject as? Dictionary<String, AnyObject> {
                    FaceTec.sdk.configureOCRLocalization(dictionary: jsonDictionary)
                }
            } catch {
                print("Error loading JSON for OCR Localization")
            }
        }
    }
}
