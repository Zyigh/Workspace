//
// Created by Hugo Medina on 2019-07-28.
//

import Foundation
import Guaka

//
protocol CommandSetup {
    static func getCommand() -> Command
    static func getSetupFlags() -> [Flag]
}

// Stencil context to bind template files
protocol Context {
    // Transform Struct to [String: Any] to use value in Stencil templates
    // attributes become keys of the associative array
    func toStringAny() -> [String: Any]
}

// Element of Workspace, MUST have a Docker template to bind
protocol Element {
//    self explainatory
    var template : String { get }
}
