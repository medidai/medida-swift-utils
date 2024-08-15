
import Foundation

class LoggerModel: NSObject {
    var date: Date = Date() // utc zero
    var text: String!
    
    init(_ text: String) {
        self.text = text
    }
    
    func getLogFileName() -> String {
        let formatter = LoggerModel.isoFull()
        formatter.dateFormat = "yyyy_MM_dd"
        let dateStr = formatter.string(from: date)
        
        if let info = Bundle.main.infoDictionary, let appName = info["CFBundleName"] as? String {
            return "\(dateStr) - \(appName)"
        }
        
        return dateStr
    }
    
    func getLogText() -> String {
        let dateStr = LoggerModel.isoFull().string(from: date)
        let message = "\(dateStr) - \(text ?? "NoMessage")"
        return "\n\n\(message)"
    }
    
    // MARK: - isoFull
    
    private class func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar.timeZone = ISO8601DateFormatter().timeZone
        formatter.timeZone = ISO8601DateFormatter().timeZone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }
    
    private class func isoFull() -> DateFormatter {
        let formatter = LoggerModel.dateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }
    
    private func isoFullString() -> String {
        let formatter = DateFormatter()
        formatter.calendar.timeZone = ISO8601DateFormatter().timeZone
        formatter.timeZone = ISO8601DateFormatter().timeZone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.string(from: date)
    }
}
