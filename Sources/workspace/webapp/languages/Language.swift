//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation
import Stencil

class Language {
    let language: LanguageStrategy
    let environment : Environment

    init(_ l: LanguageStrategy) {
        language = l
        let fsLoader = FileSystemLoader(paths: ["templates/"])
        environment = Environment(loader: fsLoader)
    }

    public func test() {
        return language.test()
    }

    public func writeDockerfile() {
        let context = language.generateDockerfileContext()
        do {
            let dockerfile = try environment.renderTemplate(name: "template.Dockerfile", context: context)
            print(dockerfile)
        } catch let e {
            print(e.localizedDescription)
        }
    }
}
