//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation

protocol LanguageStrategy {
    var context: LanguageContext { get }
    var tree: Tree { get }

    func test()
    func generateDockerfileContext() -> [String: Any]
}
