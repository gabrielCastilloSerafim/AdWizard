//
//  NetworkLayer.swift
//
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

final class NetworkLayer {
    
    private let baseURL = "https://adwizardapi-production.up.railway.app"
    
    func ping() async throws -> PingResponse {
        
        guard let URL = URL(string: "\(baseURL)/event/ping") else { throw URLError(.badURL) }
        
        var request = URLRequest(url: URL)
        request.httpMethod = HttpMethods.GET.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(PingResponse.self, from: data)
    }
    
    func registerEvent(eventName: String, campaignId: String, userId: String) async throws {
        
        guard let URL = URL(string: "\(baseURL)/event") else { return }
        let requestBody = Event(name: eventName, campaignId: campaignId, userId: userId)
        
        var request = URLRequest(url: URL)
        request.httpMethod = HttpMethods.POST.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        debugPrint(data)
        debugPrint(response)
    }
}
