//
// Created by Hugo Medina on 2019-07-28.
//

import Foundation

struct LanguageContext : Context {
    // Need a WORKDIR line in Dockerfile
    let hasWorkdir: Bool
    // Steps that has to be executed with RUN
    let steps: [String]
    // The base image that is used to create the image used in project
    var language: String
    // The docker's CMD line
    let cmd: String?

    // Returns a [String: Any] in order to be used as Stencil context
    public func toStringAny() -> [String: Any] {
        var stringAnyzed: [String: Any] = [
            "hasWorkdir": hasWorkdir,
            "steps": steps,
            "language": language
        ]

        if let cmd = cmd {
            stringAnyzed["cmd"] = cmd
        }

        return stringAnyzed
    }
}
