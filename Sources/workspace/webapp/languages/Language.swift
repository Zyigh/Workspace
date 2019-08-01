//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation
import Stencil

typealias Dirname = String
// The files Tree for the project which is created
struct Tree {
    let filename: [String]
    let children: [Dirname: Tree]?
}

// Class that handle the Language used using a Language Strategy design pattern for specific language
class Language {
    // The language for which the Dockerfile and tree will be created
    let language: LanguageStrategy
    // Stencil prerequisit
    let environment : Environment

    // Set the language and the Environment for Stencil
    init(_ l: LanguageStrategy) {
        language = l
        let fsLoader = FileSystemLoader(paths: ["templates/"])
        environment = Environment(loader: fsLoader)
    }

    // Useless method to check that the basic is working
    public func test() {
        return language.test()
    }

    // @Todo put the Dockerfile at his destination in the tree created
    public func putDockerfileAtDestination(_ dockerfile: String) {
        print(dockerfile)
    }

    // Create Dockerfile from language. Get an error if the language is not implemented
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
