
import Foundation
import DatadogCore
import DatadogLogs
import DatadogCrashReporting

class DataDogService {
    
    private var logger: LoggerProtocol!
    
    init(token: String, environment: String, serviceName: String) {
        let config = Datadog.Configuration(
            clientToken: token,
            env: environment,
            service: serviceName,
            batchSize: .medium,
            uploadFrequency: .average
        )
        
        let logConfig = Logger.Configuration(
            service: serviceName,
            name: serviceName,
            networkInfoEnabled: true,
            bundleWithRumEnabled: false,
            bundleWithTraceEnabled: true,
            consoleLogFormat: .short
        )
        
        Datadog.initialize(with: config, trackingConsent: .granted)
        Datadog.verbosityLevel = .debug
        
        Logs.enable()
        CrashReporting.enable()
        
        logger = Logger.create(with: logConfig)
    }
    
    // MARK: - Interface
    
    func updateLog(message: String, type: LogType = .info, attributes: [ String : String ]? = nil) {
        switch type {
        case .debug: logger.debug(message, attributes: attributes)
        case .info: logger.info(message, attributes: attributes)
        case .notice: logger.notice(message, attributes: attributes)
        case .warn: logger.warn(message, attributes: attributes)
        case .error: logger.error(message, attributes: attributes)
        case .critical: logger.critical(message, attributes: attributes)
        }
    }
    
    func setUserAttribute(id: String?, name: String?, email: String?) {
        Datadog.setUserInfo(id: id, name: name, email: email)
    }
    
    func setAttribute(key: String?, value: String?) {
        guard let key = key, let value = value else { return }
        logger.addAttribute(forKey: key, value: value)
    }
    
    func removeAttribute(key: String?) {
        guard let key = key else { return }
        logger.removeAttribute(forKey: key)
    }
}
