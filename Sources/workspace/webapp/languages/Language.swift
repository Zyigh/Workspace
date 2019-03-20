//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation

class Language {
    let language: LanguageStrategy

    init(_ l: LanguageStrategy) {
        language = l
    }

    public func test() {
        return language.test()
    }
}
