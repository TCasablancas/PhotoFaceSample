import Foundation

extension Bundle {
    class func getBundle() -> Bundle {
        return Bundle(for: BaseViewController.self)
    }
}
