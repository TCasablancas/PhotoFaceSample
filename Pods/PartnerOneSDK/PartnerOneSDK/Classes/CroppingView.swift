import UIKit

final class CroppingView: BaseView {
  
    var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var content: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    var cropReferenceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
  // MARK: - Initialize
  
    override func initialize() {
        backgroundColor = .clear
        content.backgroundColor = .clear

        addSubview(overlayView)
        addSubview(content)
        overlayView.addSubview(cropReferenceView)
    }
  
    override func installConstraints() {
        NSLayoutConstraint.activate([
            overlayView.widthAnchor.constraint(equalTo: widthAnchor),
            overlayView.heightAnchor.constraint(equalTo: heightAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),

            //      cropReferenceView.topAnchor.constraint(equalTo: topAnchor, constant: 100), //160
            //      cropReferenceView.widthAnchor.constraint(equalTo: cropReferenceView.heightAnchor, multiplier: 0.8),


            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor),

            cropReferenceView.heightAnchor.constraint(equalTo: cropReferenceView.widthAnchor, multiplier: 1.3),
            cropReferenceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            cropReferenceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            cropReferenceView.centerYAnchor.constraint(equalTo: content.centerYAnchor),
        ])
    }
}
