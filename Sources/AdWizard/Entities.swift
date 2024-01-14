//
//  Entities.swift
//
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

struct Campaing: Codable {
    let campaingId: String
}

enum HttpMethods: String {
    case POST
    case GET
    case DELETE
    case PATCH
}
