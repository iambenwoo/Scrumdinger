//
//  DailyScrumsLandingView.swift
//  Scrumdinger
//
//  Created by Ben Woo on 8/10/2022.
//

import SwiftUI

struct DailyScrumsLandingView: View {
    // @Binding to scrums
    @Binding var dailyScrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    
    // ** Define for editing new data
    @State private var newScrumData = DailyScrum.Data()
    
    let saveAction: ()->Void
    
    var body: some View {
        // Display the list of Scrums
        // ** Use of List/ForEach
        List {
            ForEach($dailyScrums) {
                // item need to be Identifiable otherwise need an id parameter
                $dailyScrum in
                // ** Use of NavigationLink
                // ** Pass $dailyScrum as Binding for "Edit"
                NavigationLink(destination: DailyScrumDetailView(dailyScrum: $dailyScrum)) {
                    // For Card View it need not a "Binding"
                    DailyScrumCardView(dailyScrum: dailyScrum)
                }
                .listRowBackground((dailyScrum.theme.mainColor))
            }
        }
        .navigationTitle("Daily Scrums")
        // add a top toolbar
        .toolbar {
            Button(action: {isPresentingNewScrumView = true}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
        // ** Display sheet as modal
        .sheet(isPresented: $isPresentingNewScrumView) {
            NavigationView {
                DailyScrumEditView(data: $newScrumData)
                    // Toolbar is a separate item from the "View"
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newScrum = DailyScrum(data: newScrumData)
                                dailyScrums.append(newScrum)
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }
    }
}

struct DailyScrumsLandingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DailyScrumsLandingView(dailyScrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
