//
//  Php.swift
//  workspace
//
//  Created by Hugo Medina on 18/03/2019.
//

import Foundation
import Guaka
import Stencil

class Php : NSObject, LanguageStrategy {
    public func test() {
        print("Péacheupait")
    }

    public func generateDockerfileContext() -> [String: Any] {
        return ["language": "PHP"]
    }
}
