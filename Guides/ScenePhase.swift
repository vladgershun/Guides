//
//  ScenePhase.swift
//  Guides
//
//  Created by Vlad Gershun on 9/2/23.
//

import SwiftUI

struct ScenePhase: View {
    
    @Environment(\.scenePhase) var schenePhase
    
    var body: some View {
        Text("Hello, World!")
            .padding()
            .onChange(of: schenePhase) { newPhase in
                if newPhase == .active {
                    print("App is open")
                } else if newPhase == .background {
                    print("App is in background")
                } else if newPhase == .inactive {
                    print("App is inactive")
                }
            }
    }
}

struct ScenePhase_Previews: PreviewProvider {
    static var previews: some View {
        ScenePhase()
    }
}
