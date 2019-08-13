//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation

protocol LanguageStrategy {
    // Define docker specific script context
    var context: LanguageContext { get }
    // Define directory structure
    var tree: Tree { get }

    // Create [String: Any] from context to be used with Stencil.
    // Not sure that it will last here as LanguageContext as a method toStringAny
    // But might have some cases where it will be usefull to have some modification here
    // Perhaps "PHP + Apache" might lead to changes such as FROM php-fpm to FROM php-apache
    func generateDockerfileContext() -> [String: Any]
}
