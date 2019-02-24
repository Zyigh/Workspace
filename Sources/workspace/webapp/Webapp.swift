//
//  Webapp.swift
//  Guaka
//
//  Created by Hugo Medina on 23/02/2019.
//

import Foundation
import Guaka

class Webapp {
    let flags: Flags
    let args: [String]
    
    init(flags: Flags, args: [String]) {
        self.flags = flags
        self.args = args
    }
    func execute() {
        print("execution !!")
    }
}

extension Webapp : CommandSetup {
    private static func getLanguage() -> Flag {
        return Flag(shortName: "l", longName: "language", type: String.self, description: "Language used in webapp", required: true, repeatable: false, inheritable: false)
    }
    
    static func getSetupFlags() -> [Flag] {
        var flags = [Flag]()
        flags.append(getLanguage())
        
        return flags
    }
    
    static func getCommand() -> Command {
        let webapp = Command(usage: "webapp") {
            flags, args in
            
            Setup.checkIfInstalled()
            print(flags)
            
            let webapp = Webapp(flags: flags, args: args)
            webapp.execute()
        }
        webapp.add(flags: getSetupFlags())
        
        return webapp
    }
}
