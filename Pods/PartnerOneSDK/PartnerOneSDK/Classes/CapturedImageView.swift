import UIKit

final class CapturedImageView: BaseView {
  
  var image: UIImage? {
    didSet {
      guard let image = image else {
        return
      }
      
      imageView.image = image
    }
  }
  
  //MARK:- View Components
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  // MARK: - Initialize
  
  override func initialize() {
    backgroundColor = .red
//    clipsToBounds = false
    translatesAutoresizingMaskIntoConstraints = false
//    layer.cornerRadius = 10
    addSubview(imageView)
  }
  
  override func installConstraints() {
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
    ])
  }
}
