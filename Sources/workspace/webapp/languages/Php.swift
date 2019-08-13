//
//  Php.swift
//  workspace
//
//  Created by Hugo Medina on 18/03/2019.
//

import Foundation
import Guaka

// Strategy for PHP language
class Php : NSObject, LanguageStrategy {
    // Base for Stencil context to generate PHP Dockerfile
    var context = LanguageContext(
            hasWorkdir: true,
            steps: [
                "apt-get -y update --fix-missing",
                "apt-get upgrade -y",
                "apt-get -y install apt-utils nano wget dialog",
                "apt-get -y install --fix-missing apt-utils build-essential git curl libssl-dev libcurl4 libcurl4-openssl-dev zip",
                "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer",
                "apt-get -y install libmcrypt-dev argon2 libargon2-0 libargon2-0-dev libsqlite3-dev libsqlite3-0",
                "docker-php-ext-install pdo_mysql mbstring",
                "apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev",
                "docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/",
                "docker-php-ext-install -j$(nproc) gd",
            ],
            language: "php:7.3.7-fpm-buster",
            cmd: nil
    )

    // The file tree of a project that uses PHP
    var tree = Tree(
        files: [(name: "index.php", content: "<?php\n")],
        children: [(
            dirname: "public", 
            tree: Tree(files: [(name: "index.php", content: """
            <?php
                                                        
            require_once __DIR__ . "../index.php";

            """)])
        )]
    )

    // @Todo handle appropriate changes if PHP AND Apache are selected at the same time.
    // Might disappear
    public func generateDockerfileContext() -> [String: Any] {
        return context.toStringAny()
    }
}
