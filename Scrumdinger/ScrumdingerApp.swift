//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Ben Woo on 4/10/2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    // @State private var dailyScrums = DailyScrum.sampleData
    
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DailyScrumsLandingView(dailyScrums: $store.scrums){
                    //                    ScrumStore.save(scrums: store.scrums) { result in
                    //                        if case .failure(let error) = result {
                    //                            fatalError(error.localizedDescription)
                    //                        }
                    //                    }
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        }catch{
                            errorWrapper = ErrorWrapper(error:error, guidance: "Try again later")
                        }
                    }
                }
            }
            //            .onAppear {
            //                ScrumStore.load { result in
            //                    switch result {
            //                    case .failure(let error):
            //                        fatalError(error.localizedDescription)
            //                    case .success(let scrums):
            //                        store.scrums = scrums
            //                    }
            //                }
            //            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error:error, guidance: "Scrumdinger will load sample data and continue")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {}){
                wrapper in ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
