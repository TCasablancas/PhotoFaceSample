import UIKit

extension UIView {
  @discardableResult
  func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
    let borderLayer = CAShapeLayer()
    
    borderLayer.strokeColor = color
    borderLayer.lineDashPattern = pattern
    borderLayer.frame = bounds
    borderLayer.fillColor = nil
    borderLayer.path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: .allCorners,
                                    cornerRadii: CGSize(width: radius, height: radius)).cgPath
    layer.addSublayer(borderLayer)
    return borderLayer
  }
  
  func addDashedBorder(radius: CGFloat, pattern: [NSNumber], color: CGColor) {
    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
    
    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineDashPattern = pattern
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect,
                                   cornerRadius: radius).cgPath
    
    self.layer.addSublayer(shapeLayer)
  }
  
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}
