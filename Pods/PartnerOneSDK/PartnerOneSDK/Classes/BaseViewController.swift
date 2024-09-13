import UIKit

open class BaseViewController<View: BaseView>: UIViewController {
    
    //MARK: - Internal Variables
    
    public var baseView: View {
        return view as! View
    }
    
    // MARK: - Initializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override public func loadView() {
        view = View()
    }
}

