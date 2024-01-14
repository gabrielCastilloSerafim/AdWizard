//
//  NetworkLayer.swift
//
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

final class NetworkLayer {
    
    private let baseURL = "http://127.0.0.1:3000"
    
    func sendEvent(apiKey: String, campaingId: String?) {
        
        guard let campaingId,
              let URL = URL(string: "\(baseURL)/campaing") else { return }
        
        Task {
            
            let requestBody = Campaing(campaingId: campaingId)
            
            var request = URLRequest(url: URL)
            request.httpMethod = HttpMethods.POST.rawValue
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(requestBody)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            debugPrint(data)
            debugPrint(response)
        }
    }
}
