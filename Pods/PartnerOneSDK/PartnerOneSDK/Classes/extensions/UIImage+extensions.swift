extension UIImage {
    
    private var MAX_SIZE_IMAGE: CGFloat { return 1000 }
    
    func imageResizedIfNedd() -> UIImage {
        let max = max(self.size.width, self.size.height)
        if(max > MAX_SIZE_IMAGE) {
            let percents = MAX_SIZE_IMAGE / max
            return self.imageResized(to: CGSize(width: self.size.width * percents, height: self.size.height * percents))
        }
        
        return self
    }
    
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func compress(_ jpegQuality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, jpegQuality.rawValue)
    }
    
    func rotate(degrees: CGFloat)-> UIImage? {
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        
        // Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(origin: .zero, size: size))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 0.0)
        
        guard let bitmap: CGContext = UIGraphicsGetCurrentContext(), let unwrappedCgImage: CGImage = cgImage else {
            return nil
        }
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width/2.0, y: rotatedSize.height/2.0)
        
        // Rotate the image context
        bitmap.rotate(by: degreesToRadians(degrees))
        
        bitmap.scaleBy(x: CGFloat(1.0), y: -1.0)
        
        let rect: CGRect = CGRect(
            x: -size.width/2,
            y: -size.height/2,
            width: size.width,
            height: size.height)
        
        bitmap.draw(unwrappedCgImage, in: rect)
        
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    class func loadImageBundle(named imageName:String) -> UIImage? {
        let podBundle = Bundle.getBundle()
        if let bundleURL = podBundle.url(forResource: "PartnerOneSDK", withExtension: "bundle")
        {
            let imageBundel = Bundle(url:bundleURL )
            let image = UIImage(named: imageName, in: imageBundel, compatibleWith: nil)
            return image
        }
        return nil
    }
}
