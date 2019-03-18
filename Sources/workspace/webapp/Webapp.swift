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
    
    enum SupportedLanguages : String {
        case php = "php"
        case js = "js"
    }
}

extension Webapp : CommandSetup {
    private static func getLanguageFlag() -> Flag {
        return Flag(shortName: "l", longName: "language", type: String.self, description: "Language used in webapp", required: true, repeatable: false, inheritable: false)
    }
    
    private static func handleLanguage(languages: Flag) {
        if let lang = languages.values.first as? String,
            let l = SupportedLanguages(rawValue: lang) {
            switch l {
            case .php:
                print(Php.test)
            case .js:
                print("LOOOOOOSEEEEERRR")
            }
        } else {
            print("Something went wrong. Expected language, got \(languages.values.first ?? "nil")")
            exit(1)
        }
    }
    
    static func getSetupFlags() -> [Flag] {
        var flags = [Flag]()
        flags.append(getLanguageFlag())
        
        return flags
    }
    
    static func getCommand() -> Command {
        let webapp = Command(usage: "webapp") {
            flags, args in
            
            Setup.checkIfInstalled()
            if let languages = flags["language"] {
                handleLanguage(languages: languages)
            }
            
            let webapp = Webapp(flags: flags, args: args)
            webapp.execute()
        }
        webapp.add(flags: getSetupFlags())
        
        return webapp
    }
}
