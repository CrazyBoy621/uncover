//
//  CheckNetworkReachability.swift
//  uncover
//
//  Created by Bekzod Rakhmatov on 17/06/23.
//

import Network
import SwiftUI

class NetworkManager: ObservableObject {
    @Published var isOnline = true
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                withAnimation {
                    self?.isOnline = path.status == .satisfied
                }
            }
        }
        
        monitor.start(queue: queue)
    }
}

