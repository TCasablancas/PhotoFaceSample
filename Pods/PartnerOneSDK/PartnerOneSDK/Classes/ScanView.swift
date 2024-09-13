import UIKit

open class ScanView: BaseView {
    
    var didTapTakePicture: (() -> Void)?
    var didTapBack: (() -> Void)?
    public static var doc_frente = UIImage.loadImageBundle(named: "ilustracao_frente");
    public static var doc_verso = UIImage.loadImageBundle(named: "ilustracao_verso");
    
    let photoPreviewContainer: CapturedImageView = {
        let view = CapturedImageView()
        return view
    }()
    
    let transparentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = doc_frente
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = false
        imageView.alpha = 0.2
        return imageView
    }()
    
    
    let background: CroppingView = {
        let view = CroppingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cameraContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "A foto ficou boa?"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.isHidden = true
        return label
    }()
    
    lazy var takePicBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#01ea5e")
        button.setTitle("Fotografar", for: .normal)
        button.layer.borderColor = UIColor(hexString: "#221c46").cgColor
        button.setTitleColor(UIColor(hexString: "#221c46"), for: .normal)
        button.layer.borderWidth = 4
        button.addTarget(self, action: #selector(takePictureAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var returnBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.setTitle("Voltar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor =  UIColor.white.cgColor
        button.layer.borderWidth = 4
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialize
    
    open override func initialize() {
        backgroundColor = .black
        
        addSubview(viewTitle)
        addSubview(takePicBtn)
        addSubview(returnBtn)
        addSubview(cameraContainer)
        addSubview(confirmationLabel)
        cameraContainer.addSubview(background)
        addSubview(transparentImageView)
        bringSubview(toFront: transparentImageView)
    }
    
    open override func installConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                cameraContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
                cameraContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
                cameraContainer.topAnchor.constraint(equalTo: topAnchor),
                cameraContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                background.leadingAnchor.constraint(equalTo: cameraContainer.leadingAnchor),
                background.trailingAnchor.constraint(equalTo: cameraContainer.trailingAnchor),
                background.topAnchor.constraint(equalTo: cameraContainer.topAnchor),
                background.bottomAnchor.constraint(equalTo: cameraContainer.bottomAnchor),
                
                transparentImageView.heightAnchor.constraint(equalTo: background.cropReferenceView.heightAnchor, multiplier: 0.9),
                transparentImageView.widthAnchor.constraint(equalTo: background.cropReferenceView.widthAnchor, multiplier: 0.9),
                transparentImageView.centerYAnchor.constraint(equalTo: background.content.centerYAnchor),
                transparentImageView.centerXAnchor.constraint(equalTo: background.content.centerXAnchor),
                
                viewTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                viewTitle.widthAnchor.constraint(equalTo: widthAnchor),
                
                confirmationLabel.bottomAnchor.constraint(equalTo: takePicBtn.topAnchor, constant: -40),
                confirmationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                /*
                takePicBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
                takePicBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
                takePicBtn.heightAnchor.constraint(equalToConstant: 50),
                takePicBtn.bottomAnchor.constraint(equalTo: returnBtn.topAnchor, constant: -20),
                
                returnBtn.heightAnchor.constraint(equalToConstant: 30),
                returnBtn.heightAnchor.constraint(equalToConstant: 50),
                returnBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
                returnBtn.widthAnchor.constraint(equalTo: widthAnchor),*/
                
                // Restrições para ambos os botões
  
                takePicBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
                takePicBtn.heightAnchor.constraint(equalToConstant: 50),
                takePicBtn.widthAnchor.constraint(equalToConstant: 150), // Largura fixa de 150 pixels
                takePicBtn.bottomAnchor.constraint(equalTo: returnBtn.topAnchor, constant: -20),

                returnBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
                returnBtn.heightAnchor.constraint(equalToConstant: 50),
                returnBtn.widthAnchor.constraint(equalToConstant: 150), // Largura fixa de 150 pixels
                returnBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
                
                background.content.topAnchor.constraint(equalTo: viewTitle.bottomAnchor),
                background.content.bottomAnchor.constraint(equalTo: takePicBtn.topAnchor),
                
              
                
            ])
        }
    }
    
    func setupMaskLayer() {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = background.bounds
        maskLayer.lineWidth = 5
        maskLayer.cornerRadius = 15
        
        let path = UIBezierPath(roundedRect: background.bounds,
                                byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 0, height: 0))
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        background.cropReferenceView.addDashedBorder(radius: 10, pattern: [4,4], color: UIColor.white.cgColor)
        background.cropReferenceView.layer.borderWidth = 10
        background.cropReferenceView.layer.cornerRadius = 10
        
        path.append(UIBezierPath(rect: background.cropReferenceView.frame))
        maskLayer.path = path.cgPath
        
        background.layer.mask = maskLayer
    }
}

private extension ScanView {
    @objc
    func takePictureAction() {
        self.didTapTakePicture?()
    }
    
    @objc
    func backAction() {
        self.didTapBack?()
    }
}
