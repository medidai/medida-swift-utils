
import Foundation

enum LogType {
    case debug
    case info
    case notice
    case warn
    case error
    case critical
}

enum LogAttribute: String {
    case iosAppVersion
    case phoneName
}

class LoggerService: NSObject {
    
    class func clearAttributeKeys() {
        
    }
    
    class func setup(key: LogAttribute, value: String) {
        
    }
    
    class func saveError(_ message: String, attributes: [ String : String ]? = nil) {
        LoggerService.save("ERROR - \(message)", type: .error, attributes: attributes)
    }
    
    class func save(_ message: String, type: LogType = .info, attributes: [ String : String ]? = nil) {
        DispatchQueue.main.async {
            // save message in third party(ex. datadog)
        }
        
        LoggerService.saveOnlyLocaly(message)
    }
    
    class func saveOnlyLocaly(_ message: String) {
        LoggerService.printLog(message)
    }
    
    class func printLog(_ message: String) {
        if LoggerService.shouldShowDebugLogs() {
            print(LoggerModel(message).getLogText())
        }
    }
    
    class func shouldShowDebugLogs() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
