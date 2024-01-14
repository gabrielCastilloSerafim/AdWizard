//
//  AdWizard.swift
//  AppWizard
//
//  Created by Gabriel Castillo Serafim on 14/1/24.
//

public final class AdWizard {
    
    let apiKey: String
    let netWorkLayer = NetworkLayer()
    
    public var campaingId: String? {
        didSet {
            registerUserDowload()
        }
    }
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func registerUserDowload() {
        netWorkLayer.sendEvent(apiKey: apiKey, campaingId: campaingId)
    }
}
