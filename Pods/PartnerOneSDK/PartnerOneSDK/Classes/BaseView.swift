import UIKit

private protocol BaseViewProtocol {
    func initialize()
    func installConstraints()
    func setup()
}

private extension BaseViewProtocol {
    func setup() {
        initialize()
        installConstraints()
    }
}

// MARK: - Base View
open class BaseView: UIView, BaseViewProtocol {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    required public init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    open func initialize() { fatalError("Must be overriden") }
    
    open func installConstraints() { fatalError("Must be overriden") }
}
