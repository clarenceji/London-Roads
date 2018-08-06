//
//  Road.swift
//  London Roads
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import Foundation

class Road {
    
    let id: String
    let displayName: String
    let statusSeverity: String
    let statusSeverityDescription: String
    
    init(id: String, name: String, severity: String, severityDescription: String) {
        self.id = id
        self.displayName = name
        self.statusSeverity = severity
        self.statusSeverityDescription = severityDescription
    }
    
}
