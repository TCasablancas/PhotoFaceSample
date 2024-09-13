//
// FaceTec Device SDK config file.
// Auto-generated via the FaceTec SDK Configuration Wizard
//
import UIKit
import Foundation
import FaceTecSDK

open class Config {
    
  static let partnerManager = PartnerManager()

  // -------------------------------------
  // This app can modify the customization to demonstrate different look/feel preferences
  // NOTE: This function is auto-populated by the FaceTec SDK Configuration Wizard based on your UI Customizations you picked in the Configuration Wizard GUI.
  public static func retrieveConfigurationWizardCustomization() ->
      FaceTecCustomization {
          
          let font = UIFont.init(name: "SFProDisplay-Regular", size: UIFont.labelFontSize)
          
          // For Color Customization
          let outerBackgroundColor = UIColor(hexString: "#7d7c80")
          let frameColor = UIColor(hexString: "#7d7c80")
          let borderColor = UIColor(hexString: "#7d7c80")
          let ovalColor = UIColor(hexString: "#ffffff")
          let dualSpinnerColor = UIColor(hexString: "#e32b24")
          let textColor = UIColor(hexString: "#ffffff")
          let buttonAndFeedbackBarColor =  UIColor(hexString: "#01ea5e")
          let buttonAndFeedbackBarTextColor = UIColor(hexString: "#221c46")
          let buttonColorHighlight =  UIColor(hexString: "#396E99")
          let buttonColorDisabled =  UIColor(hexString: "#B9CCDE")
          let feedbackBackgroundLayer = CAGradientLayer.init()
          feedbackBackgroundLayer.colors = [buttonAndFeedbackBarColor.cgColor, buttonAndFeedbackBarColor.cgColor]
          feedbackBackgroundLayer.locations = [0,1]
          feedbackBackgroundLayer.startPoint = CGPoint.init(x: 0, y: 0)
          feedbackBackgroundLayer.endPoint = CGPoint.init(x: 1, y: 0)
          
          // For Frame Corner Radius Customization
          let frameCornerRadius: Int32 = 20

          let cancelImage = UIImage(named: "single_chevron_left_offblack", in: Bundle.getBundle(), compatibleWith: nil)
          let cancelButtonLocation: FaceTecCancelButtonLocation = .topLeft

          
          // Set a default customization
          let defaultCustomization = FaceTecCustomization()
            
          //remover o audio
          defaultCustomization.vocalGuidanceCustomization.mode = .noVocalGuidance
          
          // Set Frame Customization
          defaultCustomization.frameCustomization.cornerRadius = frameCornerRadius
          defaultCustomization.frameCustomization.backgroundColor = frameColor
          defaultCustomization.frameCustomization.borderColor = borderColor

          // Set Overlay Customization
          defaultCustomization.overlayCustomization.brandingImage = nil
          defaultCustomization.overlayCustomization.backgroundColor = outerBackgroundColor

          // Set Guidance Customization
          defaultCustomization.guidanceCustomization.buttonCornerRadius = 0
          defaultCustomization.guidanceCustomization.backgroundColors = [frameColor, frameColor]
          defaultCustomization.guidanceCustomization.foregroundColor = textColor
          
          // customizar as fontes
          defaultCustomization.guidanceCustomization.buttonFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
          defaultCustomization.guidanceCustomization.headerFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
          defaultCustomization.guidanceCustomization.subtextFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
          defaultCustomization.guidanceCustomization.readyScreenHeaderFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
          defaultCustomization.guidanceCustomization.readyScreenSubtextFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
          defaultCustomization.guidanceCustomization.retryScreenHeaderFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
          defaultCustomization.guidanceCustomization.retryScreenSubtextFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
    
          
          defaultCustomization.guidanceCustomization.buttonBackgroundNormalColor = buttonAndFeedbackBarColor
          defaultCustomization.guidanceCustomization.buttonBackgroundDisabledColor = buttonColorDisabled
          defaultCustomization.guidanceCustomization.buttonBackgroundHighlightColor = buttonColorHighlight
          defaultCustomization.guidanceCustomization.buttonBorderWidth = 4
          defaultCustomization.guidanceCustomization.buttonBorderColor = buttonAndFeedbackBarTextColor
          defaultCustomization.guidanceCustomization.buttonTextNormalColor = buttonAndFeedbackBarTextColor
          defaultCustomization.guidanceCustomization.buttonTextDisabledColor = buttonAndFeedbackBarTextColor
          defaultCustomization.guidanceCustomization.buttonTextHighlightColor = buttonAndFeedbackBarTextColor
          defaultCustomization.guidanceCustomization.retryScreenImageBorderColor = borderColor
          defaultCustomization.guidanceCustomization.retryScreenOvalStrokeColor = borderColor

          // Set Oval Customization
          defaultCustomization.ovalCustomization.strokeColor = ovalColor
          defaultCustomization.ovalCustomization.progressColor1 = dualSpinnerColor
          defaultCustomization.ovalCustomization.progressColor2 = dualSpinnerColor

          // Set Feedback Customization
          defaultCustomization.feedbackCustomization.backgroundColor = feedbackBackgroundLayer
          defaultCustomization.feedbackCustomization.textColor = buttonAndFeedbackBarTextColor
          defaultCustomization.feedbackCustomization.textFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)

          // Set Cancel Customization
          defaultCustomization.cancelButtonCustomization.customImage = cancelImage
          defaultCustomization.cancelButtonCustomization.location = cancelButtonLocation

          // Set Result Screen Customization
          defaultCustomization.resultScreenCustomization.backgroundColors = [frameColor, frameColor]
          defaultCustomization.resultScreenCustomization.foregroundColor = textColor
          defaultCustomization.resultScreenCustomization.activityIndicatorColor = buttonAndFeedbackBarColor
          defaultCustomization.resultScreenCustomization.resultAnimationBackgroundColor = buttonAndFeedbackBarColor
          defaultCustomization.resultScreenCustomization.resultAnimationForegroundColor = buttonAndFeedbackBarTextColor
          defaultCustomization.resultScreenCustomization.uploadProgressFillColor = buttonAndFeedbackBarColor
          defaultCustomization.resultScreenCustomization.messageFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
          
          // Set Security Watermark Customization
          defaultCustomization.securityWatermarkImage = .faceTec

          // Set ID Scan Customization
          defaultCustomization.idScanCustomization.selectionScreenBackgroundColors = [frameColor, frameColor]
          defaultCustomization.idScanCustomization.selectionScreenForegroundColor = textColor
          defaultCustomization.idScanCustomization.reviewScreenBackgroundColors = [frameColor, frameColor]
          defaultCustomization.idScanCustomization.reviewScreenForegroundColor = buttonAndFeedbackBarTextColor
          defaultCustomization.idScanCustomization.reviewScreenTextBackgroundColor = buttonAndFeedbackBarColor
          defaultCustomization.idScanCustomization.captureScreenForegroundColor = buttonAndFeedbackBarTextColor
          defaultCustomization.idScanCustomization.captureScreenTextBackgroundColor = buttonAndFeedbackBarColor
          defaultCustomization.idScanCustomization.buttonBackgroundNormalColor = buttonAndFeedbackBarColor
          defaultCustomization.idScanCustomization.buttonBackgroundDisabledColor = buttonColorDisabled
          defaultCustomization.idScanCustomization.buttonBackgroundHighlightColor = buttonColorHighlight
          defaultCustomization.idScanCustomization.buttonTextNormalColor = buttonAndFeedbackBarTextColor
          defaultCustomization.idScanCustomization.buttonTextDisabledColor = buttonAndFeedbackBarTextColor
          defaultCustomization.idScanCustomization.buttonTextHighlightColor = buttonAndFeedbackBarTextColor
          defaultCustomization.idScanCustomization.captureScreenBackgroundColor = frameColor
          defaultCustomization.idScanCustomization.captureFrameStrokeColor = borderColor

          
          return defaultCustomization
  }
  
  public static func retrieveLowLightConfigurationWizardCustomization() -> FaceTecCustomization {
      
      let font = UIFont.init(name: "SFProDisplay-Regular", size: UIFont.labelFontSize)
      
      // For Color Customization
      //let outerBackgroundColor = UIColor(hexString: "#ffffff")
      let frameColor = UIColor(hexString: "#ffffff")
      let borderColor = UIColor(hexString: "#ffffff")
      let ovalColor = UIColor(hexString: "#000000")
      let dualSpinnerColor = UIColor(hexString: "#e32b24")
      let textColor = UIColor(hexString: "#ffffff")
      let buttonAndFeedbackBarColor =  UIColor(hexString: "#e32b24")
      let buttonAndFeedbackBarTextColor = UIColor(hexString: "#ffffff")
      let buttonColorHighlight =  UIColor(hexString: "#396E99")
      let buttonColorDisabled =  UIColor(hexString: "#B9CCDE")
      let feedbackBackgroundLayer = CAGradientLayer.init()
      feedbackBackgroundLayer.colors = [buttonAndFeedbackBarColor.cgColor, buttonAndFeedbackBarColor.cgColor]
      feedbackBackgroundLayer.locations = [0,1]
      feedbackBackgroundLayer.startPoint = CGPoint.init(x: 0, y: 0)
      feedbackBackgroundLayer.endPoint = CGPoint.init(x: 1, y: 0)
      
      // For Frame Corner Radius Customization
      let frameCornerRadius: Int32 = 20

      let cancelImage = UIImage(named: "single_chevron_left_offwhite", in: Bundle.getBundle(), compatibleWith: nil)
      let cancelButtonLocation: FaceTecCancelButtonLocation = .topLeft

      // Set a default customization
      let defaultCustomization = FaceTecCustomization()
        
      //remover o audio
      defaultCustomization.vocalGuidanceCustomization.mode = .noVocalGuidance
      
      // Set Frame Customization
      defaultCustomization.frameCustomization.cornerRadius = frameCornerRadius
      defaultCustomization.frameCustomization.backgroundColor = frameColor
      defaultCustomization.frameCustomization.borderColor = borderColor

      // Set Overlay Customization
      defaultCustomization.overlayCustomization.brandingImage = nil
//          defaultCustomization.overlayCustomization.backgroundColor = outerBackgroundColor

      // Set Guidance Customization
      defaultCustomization.guidanceCustomization.buttonCornerRadius = 25
      defaultCustomization.guidanceCustomization.backgroundColors = [frameColor, frameColor]
      defaultCustomization.guidanceCustomization.foregroundColor = textColor
      
      // customizar as fontes
      defaultCustomization.guidanceCustomization.buttonFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
      defaultCustomization.guidanceCustomization.headerFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
      defaultCustomization.guidanceCustomization.subtextFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
      defaultCustomization.guidanceCustomization.readyScreenHeaderFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
      defaultCustomization.guidanceCustomization.readyScreenSubtextFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
      defaultCustomization.guidanceCustomization.retryScreenHeaderFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
      defaultCustomization.guidanceCustomization.retryScreenSubtextFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)

      
      defaultCustomization.guidanceCustomization.buttonBackgroundNormalColor = buttonAndFeedbackBarColor
      defaultCustomization.guidanceCustomization.buttonBackgroundDisabledColor = buttonColorDisabled
      defaultCustomization.guidanceCustomization.buttonBackgroundHighlightColor = buttonColorHighlight
      defaultCustomization.guidanceCustomization.buttonTextNormalColor = buttonAndFeedbackBarTextColor
      defaultCustomization.guidanceCustomization.buttonTextDisabledColor = buttonAndFeedbackBarTextColor
      defaultCustomization.guidanceCustomization.buttonTextHighlightColor = buttonAndFeedbackBarTextColor
      defaultCustomization.guidanceCustomization.retryScreenImageBorderColor = borderColor
      defaultCustomization.guidanceCustomization.retryScreenOvalStrokeColor = borderColor

      // Set Oval Customization
      defaultCustomization.ovalCustomization.strokeColor = ovalColor
      defaultCustomization.ovalCustomization.progressColor1 = dualSpinnerColor
      defaultCustomization.ovalCustomization.progressColor2 = dualSpinnerColor

      // Set Feedback Customization
      defaultCustomization.feedbackCustomization.backgroundColor = feedbackBackgroundLayer
      defaultCustomization.feedbackCustomization.textColor = buttonAndFeedbackBarTextColor
      defaultCustomization.feedbackCustomization.textFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)

      // Set Cancel Customization
      defaultCustomization.cancelButtonCustomization.customImage = cancelImage
      defaultCustomization.cancelButtonCustomization.location = cancelButtonLocation

      // Set Result Screen Customization
      defaultCustomization.resultScreenCustomization.backgroundColors = [frameColor, frameColor]
      defaultCustomization.resultScreenCustomization.foregroundColor = textColor
      defaultCustomization.resultScreenCustomization.activityIndicatorColor = buttonAndFeedbackBarColor
      defaultCustomization.resultScreenCustomization.resultAnimationBackgroundColor = buttonAndFeedbackBarColor
      defaultCustomization.resultScreenCustomization.resultAnimationForegroundColor = buttonAndFeedbackBarTextColor
      defaultCustomization.resultScreenCustomization.uploadProgressFillColor = buttonAndFeedbackBarColor
      defaultCustomization.resultScreenCustomization.messageFont = font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
      
      // Set Security Watermark Customization
      defaultCustomization.securityWatermarkImage = .faceTec

      // Set ID Scan Customization
      defaultCustomization.idScanCustomization.selectionScreenBackgroundColors = [frameColor, frameColor]
      defaultCustomization.idScanCustomization.selectionScreenForegroundColor = textColor
      defaultCustomization.idScanCustomization.reviewScreenBackgroundColors = [frameColor, frameColor]
      defaultCustomization.idScanCustomization.reviewScreenForegroundColor = buttonAndFeedbackBarTextColor
      defaultCustomization.idScanCustomization.reviewScreenTextBackgroundColor = buttonAndFeedbackBarColor
      defaultCustomization.idScanCustomization.captureScreenForegroundColor = buttonAndFeedbackBarTextColor
      defaultCustomization.idScanCustomization.captureScreenTextBackgroundColor = buttonAndFeedbackBarColor
      defaultCustomization.idScanCustomization.buttonBackgroundNormalColor = buttonAndFeedbackBarColor
      defaultCustomization.idScanCustomization.buttonBackgroundDisabledColor = buttonColorDisabled
      defaultCustomization.idScanCustomization.buttonBackgroundHighlightColor = buttonColorHighlight
      defaultCustomization.idScanCustomization.buttonTextNormalColor = buttonAndFeedbackBarTextColor
      defaultCustomization.idScanCustomization.buttonTextDisabledColor = buttonAndFeedbackBarTextColor
      defaultCustomization.idScanCustomization.buttonTextHighlightColor = buttonAndFeedbackBarTextColor
      defaultCustomization.idScanCustomization.captureScreenBackgroundColor = frameColor
      defaultCustomization.idScanCustomization.captureFrameStrokeColor = borderColor

      
      return defaultCustomization
  }
  
  public static func retrieveDynamicDimmingConfigurationWizardCustomization() -> FaceTecCustomization {
    return retrieveLowLightConfigurationWizardCustomization()
  }
  
  static var currentCustomization: FaceTecCustomization = retrieveConfigurationWizardCustomization()
  static var currentLowLightCustomization: FaceTecCustomization = retrieveLowLightConfigurationWizardCustomization()
  static var currentDynamicDimmingCustomization: FaceTecCustomization = retrieveDynamicDimmingConfigurationWizardCustomization()
  
  // -------------------------------------*
  // Boolean to indicate the FaceTec SDK Configuration Wizard was used to generate this file.
  // In this Sample App, if this variable is true, a "Config Wizard Theme" will be added to this App's Design Showcase,
  // and choosing this option will set the FaceTec SDK UI/UX Customizations to the Customizations that you selected in the
  // Configuration Wizard.
  static let wasSDKConfiguredWithConfigWizard = false
    
    static func loadFont(withName fontName: String) {
        guard
            let bundleURL = Bundle.getBundle().url(forResource: "PartnerOneSDK", withExtension: "bundle"),
              let bundle = Bundle(url: bundleURL),
              let fontURL = bundle.url(forResource: fontName, withExtension: "ttf"),
              let fontData = try? Data(contentsOf: fontURL) as CFData,
              let provider = CGDataProvider(data: fontData),
              let font = CGFont(provider) else {
                return
            }
            CTFontManagerRegisterGraphicsFont(font, nil)
    }
    
}
