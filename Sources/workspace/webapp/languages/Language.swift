//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation
import Stencil

// Class that handle the Language used using a Language Strategy design pattern for specific language
// Implements Element at Sources/workspace/template/LanguageElement.swift
class Language : NSObject, Element {
    // The language for which the Dockerfile and tree will be created
    let language: LanguageStrategy
    var tree : Tree {
        get {
            return language.tree
        }
    }

    // Set the language and the Environment for Stencil
    init(_ l: LanguageStrategy) {
        language = l
    }

    // Create Dockerfile from language. Get an error if the language is not implemented
    public func getDockerfile() -> String {
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
            let dockerfile = try Template(templateString: template).render(context)

            return dockerfile
        } catch let e {
            print(e.localizedDescription)
            exit(1)
        }
    }
}
