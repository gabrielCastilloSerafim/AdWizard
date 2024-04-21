//
//  AdWizard.swift
//  AppWizard
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

public final class AdWizard {
    
    let networkLayer = NetworkLayer()
    let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func registerDowload(apiKey: String) {
        
        guard UserDefaults.standard.bool(forKey: "downloadRegistered") == false else { return }
        
        Task {
            do {
                let pingResponse = try await networkLayer.performMatch(apiKey: apiKey)
                
                UserDefaults.standard.setValue(
                    pingResponse.campaignId,
                    forKey: "campaignId")
                
                UserDefaults.standard.setValue(
                    pingResponse.consumerId,
                    forKey: "consumerId")
                
                UserDefaults.standard.setValue(
                    true,
                    forKey: "downloadRegistered")
                
            } catch {
                debugPrint(error)
            }
        }
    }
    
    public func sendEvent(eventName: String) {
        
        guard let campaignId = UserDefaults.standard.string(forKey: "campaignId"),
              let consumerId = UserDefaults.standard.string(forKey: "consumerId") else { return }
        
        Task {
            do {
                try await networkLayer.registerEvent(
                    eventName: eventName,
                    campaignId: campaignId,
                    consumerId: consumerId,
                    apiKey: apiKey)
            } catch {
                debugPrint(error)
            }
        }
    }
}
