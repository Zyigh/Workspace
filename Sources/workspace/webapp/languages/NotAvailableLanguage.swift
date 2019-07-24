//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation
import Stencil

class NotAvailableLanguage: NSObject, LanguageStrategy {
    let wrongLanguage: String

    init(lang: String) {
       wrongLanguage = lang
    }

    public func test() {
        print("""
              Language "\(wrongLanguage)" is not implemented yet. 
              Feel free to contribute or please submit an issue @ https://github.com/Zyigh/Workspace/ !
              """)
        exit(2)
    }

    public func generateDockerfileContext() -> [String: Any] {
        return [:]
    }
}
