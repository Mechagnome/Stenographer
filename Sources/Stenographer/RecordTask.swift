//
//  File.swift
//  
//
//  Created by linhey on 2021/10/22.
//

import Foundation
import AppKit
import Alliances

struct RecordTask: AlliancesApp {
    
    public static let appInfo: AppInfo = .init(id: "record.stenographer", name: "record.stenographer")
    var core: AlliancesUICore = .init()
    var configuration: AlliancesConfiguration
    var tasks: [AlliancesApp] = []
    var canOpenSettings: Bool = false
    
    var name: String
    
    init(_ configuration: AlliancesConfiguration, name: String) {
        self.configuration = configuration
        self.name = name
    }
    
    init(_ configuration: AlliancesConfiguration) {
        self.configuration = configuration
        self.name = ""
    }
    
    
    func run() throws {
        if let url = URL(string: name) {
            NSWorkspace.shared.open(url)
        } else {
            NSPasteboard.general.declareTypes([.string], owner: nil)
            NSPasteboard.general.setString(name, forType: .string)
        }
        
    }
    
}
