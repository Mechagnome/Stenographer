
import Alliances
import SwiftUI

public class Stenographer: AlliancesApp {
    
    public static let appInfo: AppInfo = .init(id: "stenographer", name: "stenographer")
    public var core: AlliancesUICore = .init()
    public var configuration: AlliancesConfiguration
    public let name: String = "Stenographer"
    
    public var tasks: [AlliancesApp] = []
    
    var cache: [String] {
        set { configuration.settings["cache"] = newValue }
        get { configuration.settings["cache"] as? [String] ?? [] }
    }
    
    public var canRun: Bool = false
    
    required public init(_ configuration: AlliancesConfiguration) {
        self.configuration = configuration
        self.tasks = cache.map({ RecordTask(.init(from: configuration, app: RecordTask.self), name: $0) })
    }
    
    
    public var settingsView: AnyView? {
        AnyView(SettingsView(cache, doneEvent: { names in
            self.cache = names
            self.tasks = self.cache.map({ RecordTask(.init(from: self.configuration, app: RecordTask.self), name: $0) })
            self.reload()
        }))
    }
    
    public func run() throws {
    
    }
   
}

