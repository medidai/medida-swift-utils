
import Foundation

enum AnalyticAttribute: String, CaseIterable {
    case customKey
}

class AnalyticService: NSObject {
    
    private static let shared = AnalyticService()
    
    // MARK: - Initialize
    
    class func initialize(token: String? = nil) {
        
    }
    
    // MARK: - Interface
    
    class func logout() {
        AnalyticService.clearAllAttributes()
    }
    
    // MARK: Attributes
    
    class func setUserAttribute(id: String?, name: String?, email: String?) {
        
    }
    
    class func setAttribute(key: AnalyticAttribute, value: String) {
        
    }
    
    class func clearAttribute(key: AnalyticAttribute) {
        
    }
    
    class func clearAllAttributes() {
        AnalyticAttribute.allCases.forEach { AnalyticService.clearAttribute(key: $0) }
    }
    
    // MARK: - Actions
    
    private class func shouldSendAnalytic() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
