//
//  LanguageElement.swift
//  Guaka
//
//  Created by Hugo Medina on 17/08/2019.
//

import Foundation

import Foundation

extension Language {
    var template : String {
        get {
            return """
            FROM {{ language }}
            
            {% if hasWorkdir %}
            WORKDIR /workspace
            {% endif %}
            ADD / .
            
            {% for step in steps %}
            RUN {{ step }}
            {% endfor %}
            
            {% if cmd %}
            CMD {{ cmd }}
            {% endif %}
            
            """
        }
    }
}
