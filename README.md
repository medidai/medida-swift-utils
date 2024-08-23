# Medida Swift Utils

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Contributing](#contributing)
- [Installation](#installation)
- [Usage](#usage)
- [Important Information](#important-information)
- [License](#license)
- [Contact](#contact)

## Introduction
The Medida Swift Utils library provides access to main services that should be implemented in scan package and main UI app.

## Features
- Analytics service
- Logger Service
- Easy integration with SwiftUI projects

## Contributing
Guidelines:

- Make all changes through pull requests (Artem or Jonathan review and comment/approve). PR owner merges after approval.
- Add new files to the Sources folder.
- Edit the package by opening in Xcode the file at 'PackageProject/Project/MedidaSwiftUtils.xcodeproj'.
- Release changes should be made in the main branch with an incremented tag number.
- Dev process should be in separate branch from main. Ex.: dev / feature 

## Installation
To install the Medida Swift Utils library in your project, follow these steps:

1. Open your Xcode project.
2. Click on the main project file in the project navigator.
3. Select your project under the "PROJECT" section.
4. Click on the "Package Dependencies" tab.
5. Click the "+" button to add a new package dependency.
6. Enter the SSH URL of the Medida Swift Utils library repository to search: `git@github.com:medidai/medida-swift-utils.git`.
7. Add the package to your project.

## Usage

### AnalyticService

Main setup:
1. Import ```import MedidaSwiftUtils```.
2. In prj start point(`AppDelegate.swift / App.swift`) add ```AnalyticService.initialize(sendCustomEvent: <#T##Bool#>)``` 
3. After login call func ```AnalyticService.setUserAttribute(id: <#T##String?#>, name: <#T##String?#>, email: <#T##String?#>)```
4. In logout call func ```AnalyticService.logout()``` 
4.1 if you add custom attributes call ```AnalyticService.clearAttribute(key: <#T##String#>)```

Additional func:
1. Add additional attributes: ```AnalyticService.setAttribute(key: <#T##String#>, value: <#T##String?#>)```
2. Clear some specific attribute: ```AnalyticService.clearAttribute(key: <#T##String#>)```
3. Clear user attributes(id, name , email): ```AnalyticService.clearUserAttributes()```
4. Clear all predefine + user attributes: ```AnalyticService.clearAllAttributes()```
5. Send custom event: ```AnalyticService.saveEvent(event: <#T##String#>, params: <#T##[String : String]?#>)```
5.1 params is optional, by default `nil`
5.2 all custom events will be printed in debug console

Predefine attributes:
```
public enum AnalyticAttribute: String, CaseIterable {
    case name
    case email
}
```

### LoggerService

Main setup:
1. Import ```import MedidaSwiftUtils```.
2. In prj start point(`AppDelegate.swift / App.swift`) add ```LoggerService.initialize(serviceName: <#T##String#>, environment: <#T##String#>, sendLogs: <#T##Bool#>)``` 
2.1 if your app use datadog add ```dataDogToken: <#T##String?#>, dataDogRumId: <#T##String?#>```  
3. After login call func ```LoggerService.setUserAttribute(id: <#T##String?#>, name: <#T##String?#>, email: <#T##String?#>)```
4. In logout call func ```LoggerService.logout()```
4.1 if you add custom attributes call ```AnalyticService.clearAttribute(key: <#T##String#>)```

Additional func:
1. Add additional attribute: ```LoggerService.setAttribute(value: <#T##String?#>, key: <#T##String#>)```
2. Clear some specific attribute: ```LoggerService.clearAttribute(key: <#T##String#>)```
3. Clear user attributes(id, name , email): ```LoggerService.clearUserAttributes()```
4. Clear all predefine + user attributes: ```LoggerService.clearAllAttributes()```
5. Log error message: ```LoggerService.saveErrorLog(<#T##message: String##String#>, attributes: <#T##[String : String]?#>)```
5.1 attributes is optional, by default `nil`
5.2 all errors will be printed in debug console
6. Log message: ```LoggerService.saveLog(<#T##message: String##String#>, type: <#T##LogType#>, attributes: <#T##[String : String]?#>)```
6.1 type is optional, by default `.info`
6.2 attributes is optional, by default `nil`
5.2 all messages will be printed in debug console
7. Print message in debug console: ```LoggerService.printLog(<#T##message: String##String#>)```

Predefine LogTypes:
```
public enum LogType {
    case debug, info, notice, warn, error, critical
}
```

Predefine attributes:
```
public enum LogAttribute: String, CaseIterable {
    case userId
    case organizationId
    case projectId
    case measurementId
    case dimensionId
}
```

## Important Information

1. All errors should be covered by LoggerService
```
LoggerService.saveErrorLog(<#T##message: String##String#>, attributes: <#T##[String : String]?#>)
```

2. All debug console messages(print("") should be covered by LoggerService
```
LoggerService.printLog(<#T##message: String##String#>)
```

3. App that use this package, should implement main keys:
```
class AnalyticsKeys {
    class func sendCustomEvent() -> Bool {
#if DEBUG
        return false
#else
        return true
#endif
    }
}

class LoggerKeys {
    static let dataDogClientToken = "<#optional#>"
    static let dataDogRumId = "<#optional#>"
    
    class func getName() -> String {
        // name of specific app(regarding to target, env, build, ...) 
        // this name is using for properly debug from what app logs came
        // in too third party, such like DataDog
        //
        var buildType = "prod / dev"
        var appType = "name_of_specific_target_build"
        
        return "ios-\(appType)-\(buildType)"
    }
    
    class func getEnv() -> String {
        // env should be based on backend base url, 
        // but in general it can be anything.
        // 
        var buildType = "prod / dev"
        return "ios-\(buildType)"
    }
    
    class func sendLogs() -> Bool {
#if DEBUG
        return false
#else
        return true
#endif
    }
}
```

## License
This project is owned by Medida AI, LTD. and every use of it should be granted permission in writing by the company.

## Contact
For any questions or feedback, please open an issue or contact us at jonathan@medida.ai.
