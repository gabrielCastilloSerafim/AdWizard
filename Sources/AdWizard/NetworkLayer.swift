//
//  NetworkLayer.swift
//
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

final class NetworkLayer {
    
    private let baseURL = "https://adwizard.up.railway.app/api/v1"
    
    func performMatch(apiKey: String) async throws -> Consumer {
        
        guard let URL = URL(string: "\(baseURL)/event/match") else { throw URLError(.badURL) }
        
        var request = URLRequest(url: URL)
        request.httpMethod = HttpMethods.GET.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "apiKey")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(Consumer.self, from: data)
    }
    
    func registerEvent(eventName: String, campaignId: String, consumerId: String, apiKey: String) async throws {
        
        guard let URL = URL(string: "\(baseURL)/event") else { return }
        let requestBody = Event(name: eventName, campaignId: campaignId, relatedConsumerId: consumerId)
        
        var request = URLRequest(url: URL)
        request.httpMethod = HttpMethods.POST.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        debugPrint(data)
        debugPrint(response)
    }
}
