//
//  Entities.swift
//
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

struct PingResponse: Decodable {
    let userId: String
    let campaignId: String
}

struct Event: Encodable {
    let name: String
    let campaignId: String
    let userId: String
}

enum HttpMethods: String {
    case POST
    case GET
    case DELETE
    case PATCH
}
