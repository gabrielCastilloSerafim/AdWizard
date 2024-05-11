//
//  AdWizard.swift
//  AppWizard
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

public final class AdWizard {
    
    private let networkLayer = NetworkLayer()
    private var apiKey: String?
    private init() {}
    
    public static let shared = AdWizard()
    
    public func configure(apiKey: String) {
        self.apiKey = apiKey
        registerDowloadIfNeeded()
    }
    
    public func sendEvent(eventName: String) {
        
        guard let apiKey else {
            debugPrint("⚠️ AdWizard Warning: Trying to send event with no API Key available, please execute configure method and provide an API Key.")
            return
        }
        
        guard let campaignId = UserDefaults.standard.string(forKey: "campaignId"),
              let consumerId = UserDefaults.standard.string(forKey: "consumerId") else { return }
        
        Task {
            try? await networkLayer.registerEvent(
                eventName: eventName,
                campaignId: campaignId,
                consumerId: consumerId,
                apiKey: apiKey)
        }
    }
    
    private func registerDowloadIfNeeded() {
        
        guard let apiKey, UserDefaults.standard.bool(forKey: "downloadRegistered") == false else { return }
        
        Task {
            guard let pingResponse = try? await networkLayer.performMatch(apiKey: apiKey) else { return }
            
            UserDefaults.standard.setValue(pingResponse.campaignId, forKey: "campaignId")
            UserDefaults.standard.setValue(pingResponse.consumerId, forKey: "consumerId")
            UserDefaults.standard.setValue(true, forKey: "downloadRegistered")
        }
    }
}
