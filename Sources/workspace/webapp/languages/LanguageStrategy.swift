//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation

protocol LanguageStrategy {
    func test()
    func generateDockerfile() -> String
}