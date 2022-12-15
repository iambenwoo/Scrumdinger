//
//  DetailView.swift
//  Scrumdinger
//
//  Display details of Scrum
//
//  Created by Ben Woo on 8/10/2022.
//

import SwiftUI

struct DailyScrumDetailView: View {
    // Binding the DailyScrum
    @Binding var dailyScrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            // Section - Meeting Info
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: DailyScrumMeetingView(scrum: $dailyScrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    // \(xx.xx) is for string interpolation
                    // e.g. Text("\(scrum.title) --")
                    // for int Text("\(scrum.lengthInMinutes)")
                    Text("\(dailyScrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(dailyScrum.theme.name)
                        .padding(4)
                        .foregroundColor(dailyScrum.theme.accentColor)
                        .background(dailyScrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            // Section - Attendees
            Section(header: Text("Attendees")) {
                ForEach(dailyScrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(dailyScrum.title)
        // ***
        // Click Edit to display the Edit View in sheet
        // ***
        .toolbar {
            Button("Edit") {
                // trigger the sheet view to display
                isPresentingEditView = true
                // binding the data just when click
                data = dailyScrum.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            // when to embed in NavigationView?
            // seems is to provide a toolbar
            NavigationView {
                // Pass the data as binding
                DailyScrumEditView(data: $data).navigationTitle(dailyScrum.title)
                    .toolbar {
                        // when to use ToolbarItem?
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                // Not exactly binding, seems just receive the update...
                                dailyScrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DailyScrumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DailyScrumDetailView(dailyScrum: .constant(DailyScrum.sampleData[0]))
    }
}
