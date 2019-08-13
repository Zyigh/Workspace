//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation
import Stencil

// A class that handle errors where the language asked is not implemented
class NotAvailableLanguage: NSObject, LanguageStrategy {
    // Just to implement protocol, nothin useful here
    var context = LanguageContext(hasWorkdir: false, steps: [], language: "", cmd: nil)
    let tree = Tree(files: [])
    // The language asked that is not implemented
    let wrongLanguage: String

    // The language is needed to get a specific message error
    init(lang: String) {
       wrongLanguage = lang
    }

    // Say to the user that the language is not implemented and quit the program
    public func notImplementedError() {
        print("""
              Language "\(wrongLanguage)" is not implemented yet. 
              Feel free to contribute or please submit an issue @ https://github.com/Zyigh/Workspace/ !
              """)
        exit(2)
    }

    // Useless func to conform to LanguageStrategy protocol
    public func generateDockerfileContext() -> [String: Any] {
        return [:]
    }
}
