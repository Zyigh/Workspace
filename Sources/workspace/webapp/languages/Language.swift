//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation
import Stencil

typealias Dirname = String
struct Tree {
    let filename: [String]
    let children: [Dirname: Tree]?
}

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

    public func putDockerfileAtDestination(_ dockerfile: String) {
        print(dockerfile)
    }

    public func writeDockerfile() {
        let context = language.generateDockerfileContext()
        if context.count < 1 {
            if let l = language as? NotAvailableLanguage {
                l.notImplementedError()
            } else {
                print("Error occurred, please don't do that again...")
                exit(1)
            }
        }

        do {
            let dockerfile = try environment.renderTemplate(name: "template.Dockerfile", context: context)
            putDockerfileAtDestination(dockerfile)
        } catch let e {
            print(e.localizedDescription)
        }
    }
}
