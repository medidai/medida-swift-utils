
import Foundation
import FirebaseAnalytics
import FirebaseCore

public enum AnalyticAttribute: String, CaseIterable {
    case name
    case email
}

public class AnalyticService: NSObject {
    
    private static let shared = AnalyticService()
    
    // MARK: - Initialize
    
    public class func initialize(exampleToken: String? = nil) {
        
    }
    
    // MARK: - Interface
    
    public class func logout() {
        LoggerService.clearUserAttributes()
        LoggerService.clearAllAttributes()
    }
    
    // MARK: Attributes
    
    public class func setUserAttribute(id: String?, name: String?, email: String?) {
        if AnalyticService.isFirebaseSetup() {
            Analytics.setUserID(id)
            Analytics.setUserProperty(name, forName: AnalyticAttribute.name.rawValue)
            Analytics.setUserProperty(email, forName: AnalyticAttribute.email.rawValue)
        }
    }
    
    public class func setAttribute(value: String?, key: String) {
        if AnalyticService.isFirebaseSetup() {
            Analytics.setUserProperty(value, forName: key)
        }
    }
    
    public class func clearAttribute(key: String) {
        if AnalyticService.isFirebaseSetup() {
            Analytics.setUserProperty(nil, forName: key)
        }
    }
    
    public class func clearUserAttributes() {
        if AnalyticService.isFirebaseSetup() {
            Analytics.setUserID(nil)
            Analytics.setUserProperty(nil, forName: AnalyticAttribute.name.rawValue)
            Analytics.setUserProperty(nil, forName: AnalyticAttribute.email.rawValue)
        }
    }
    
    public class func clearAllAttributes() {
        AnalyticAttribute.allCases.forEach { AnalyticService.clearAttribute(key: $0.rawValue) }
    }
    
    // MARK: Events
    
    public class func saveEvent(event: String, params: [ String : String ]? = nil) {
        AnalyticService.printEvent(event: event, params: params)
        
        if AnalyticService.isFirebaseSetup() {
            Analytics.logEvent(event, parameters: params)
        }
    }
    
    // MARK: - Actions
    
    private class func isFirebaseSetup() -> Bool {
        return FirebaseApp.app() != nil
    }
    
    private class func printEvent(event: String, params: [ String : String ]?) {
        var paramsMsg = ""
        if let params = params { paramsMsg = "\nParams - \(params)" }
        
        LoggerService.printLog("Analytic Event - \(event)\(paramsMsg)")
    }
    
    private class func shouldSendAnalytic() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
