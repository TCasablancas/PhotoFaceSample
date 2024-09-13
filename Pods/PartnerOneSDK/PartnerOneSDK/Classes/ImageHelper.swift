class ImageHelper {
    
    static func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, imageViewWidth: CGFloat, imageViewHeight: CGFloat) -> UIImage? {
        let imageViewScaleX = (inputImage.size.width / imageViewWidth) * inputImage.scale
        let imageViewScaleY = (inputImage.size.height / imageViewHeight) * inputImage.scale
        
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x: cropRect.origin.x * imageViewScaleX,
                              y: cropRect.origin.y * imageViewScaleY,
                              width: cropRect.size.width * imageViewScaleX,
                              height: cropRect.size.height * imageViewScaleY)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to: cropZone)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
}
