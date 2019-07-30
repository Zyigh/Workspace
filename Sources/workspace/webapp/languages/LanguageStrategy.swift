//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation

protocol LanguageStrategy {
    var context: LanguageContext { get }
    func test()
    func generateDockerfileContext() -> [String: Any]
}
