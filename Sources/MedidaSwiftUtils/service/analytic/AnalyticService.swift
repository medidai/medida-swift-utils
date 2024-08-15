
import Foundation

public enum AnalyticAttribute: String, CaseIterable {
    case customKey
}

public class AnalyticService: NSObject {
    
    private static let shared = AnalyticService()
    
    // MARK: - Initialize
    
    public class func initialize(token: String? = nil) {
        
    }
    
    // MARK: - Interface
    
    public class func logout() {
        AnalyticService.clearAllAttributes()
    }
    
    // MARK: Attributes
    
    public class func setUserAttribute(id: String?, name: String?, email: String?) {
        
    }
    
    public class func setAttribute(key: AnalyticAttribute, value: String) {
        
    }
    
    public class func clearAttribute(key: AnalyticAttribute) {
        
    }
    
    public class func clearAllAttributes() {
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
