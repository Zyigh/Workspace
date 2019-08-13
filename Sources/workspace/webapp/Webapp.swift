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
    var language: Language? = nil
    static var currentDirectory = ""

    init(flags: Flags, args: [String]) {
        self.flags = flags
        self.args = args
        Webapp.currentDirectory = FileManager.default.currentDirectoryPath
        if let newProjectName = args.first {
            newProjectName.expand.createDir()
            Webapp.currentDirectory = newProjectName
        }
    }

    func execute() {
        guard let language = language else {
            print("No language was selected")
            exit(1)
        }

        var languageTree = language.tree
        languageTree.files.append((name: "Dockerfile", content: language.getDockerfile()))
        language.createFiles(languageTree, from: Webapp.currentDirectory)
    }
    
    enum SupportedLanguages : String {
        case php = "php"
        case unrecognized
    }
}

extension Webapp : CommandSetup {
    private static func getLanguageFlag() -> Flag {
        return Flag(shortName: "l", longName: "language", type: String.self, description: "Language used in webapp", required: true, repeatable: false, inheritable: false)
    }
    
    private static func handleLanguage(languages: Flag) -> Language {
        if let lang = languages.values.first as? String {
            let l = SupportedLanguages(rawValue: lang) ?? SupportedLanguages.unrecognized
            let handler: LanguageStrategy
            switch l {
            case .php:
                handler = Php()
            case .unrecognized:
                handler = NotAvailableLanguage(lang: lang)
            }

            return Language(handler)
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
            var language: Language? = nil
            if let languages = flags["language"] {
                language = handleLanguage(languages: languages)
            }
            
            let webapp = Webapp(flags: flags, args: args)
            if let l = language {
                webapp.language = l
            }
            webapp.execute()
        }
        webapp.add(flags: getSetupFlags())
        
        return webapp
    }
}
