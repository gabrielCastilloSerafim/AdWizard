//
//  AdWizard.swift
//  AppWizard
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

import Foundation

public final class AdWizard {
    
    let networkLayer: NetworkLayer
    
    public init() {
        self.networkLayer = NetworkLayer()
    }
    
    public func registerDowload() {
        
        guard UserDefaults.standard.bool(forKey: "downloadRegistered") == false else { return }
        
        Task {
            do {
                let pingResponse = try await networkLayer.ping()
                
                UserDefaults.standard.setValue(
                    pingResponse.campaignId,
                    forKey: "campaignId")
                
                UserDefaults.standard.setValue(
                    pingResponse.userId,
                    forKey: "userId")
                
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
              let userId = UserDefaults.standard.string(forKey: "userId") else { return }
        
        Task {
            do {
                try await networkLayer.registerEvent(
                    eventName: eventName,
                    campaignId: campaignId,
                    userId: userId)
            } catch {
                debugPrint(error)
            }
        }
    }
}
