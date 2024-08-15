
import Foundation

public enum LogType {
    case debug, info, notice, warn, error, critical
}

public enum LogAttribute: String, CaseIterable {
    case userId
    case organizationId
    case projectId
    case measurementId
    case dimensionId
}

public class LoggerService: NSObject {
    
    private static let shared = LoggerService()
    
    private var sendLogs: Bool = false
    private var dataDogService: DataDogService?
    
    // MARK: - Initialize
    
    public class func initialize(serviceName: String,
                                 environment: String,
                                 sendLogs: Bool,
                                 dataDogToken: String? = nil) {
        LoggerService.shared.sendLogs = sendLogs
        
        if sendLogs {
            // if sendLogs == true
            // service should initialize third party
            // otherwise no need to initialize,
            // because logs should not be saved
            //
            if let dataDogToken = dataDogToken {
                LoggerService.shared.dataDogService = DataDogService(token: dataDogToken,
                                                                     environment: environment,
                                                                     serviceName: serviceName)
            }
        }
    }
    
    // MARK: - Interface
    
    public class func logout() {
        LoggerService.clearUserAttributes()
        LoggerService.clearAllAttributes()
    }
    
    // MARK: Attributes
    
    public class func setUserAttribute(id: String?, name: String?, email: String?) {
        if let dataDogService = LoggerService.shared.dataDogService {
            dataDogService.setUserAttribute(id: id, name: name, email: email)
        }
    }
    
    public class func setAttribute(key: LogAttribute, value: String) {
        if let dataDogService = LoggerService.shared.dataDogService {
            dataDogService.setAttribute(key: key.rawValue, value: value)
        }
    }
    
    public class func clearAttribute(key: LogAttribute) {
        if let dataDogService = LoggerService.shared.dataDogService {
            dataDogService.removeAttribute(key: key.rawValue)
        }
    }
    
    public class func clearUserAttributes() {
        if let dataDogService = LoggerService.shared.dataDogService {
            dataDogService.setUserAttribute(id: nil, name: nil, email: nil)
        }
    }
    
    public class func clearAllAttributes() {
        LogAttribute.allCases.forEach { LoggerService.clearAttribute(key: $0) }
    }
    
    // MARK: Logs
    
    public class func saveErrorLog(_ message: String, attributes: [ String : String ]? = nil) {
        LoggerService.saveLog("ERROR - \(message)", type: .error, attributes: attributes)
    }
    
    public class func saveLog(_ message: String, type: LogType = .info, attributes: [ String : String ]? = nil) {
        if LoggerService.shared.sendLogs {
            DispatchQueue.main.async {
                if let dataDogService = LoggerService.shared.dataDogService {
                    dataDogService.updateLog(message: message, type: type, attributes: attributes)
                }
            }
        }
        
        LoggerService.printLog(message)
    }
    
    public class func printLog(_ message: String) {
        if LoggerService.shouldShowDebugLogs() {
            print(LoggerModel(message).getLogText())
        }
    }
    
    // MARK: - Actions
    
    private class func shouldShowDebugLogs() -> Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
}
