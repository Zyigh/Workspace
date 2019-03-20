//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation

class NotAvailableLanguage: NSObject, LanguageStrategy {
    let wrongLanguage: String

    init(lang: String) {
       wrongLanguage = lang
    }

    public func test() {
        print("""
              Language "\(wrongLanguage)" is not implemented yet. 
              Feel free to contribute or please submit an issue !
              """)
    }
}
