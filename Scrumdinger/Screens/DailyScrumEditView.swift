//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Ben Woo on 8/10/2022.
//

import SwiftUI

struct DailyScrumEditView: View {
    
    // Expecting "data" as the binding input
    @Binding var data: DailyScrum.Data
    
    // @State as truth of the current view
    @State private var newAttendeeName = ""
    
    var body: some View {
        // ** Use Form for editing
        Form {
            // Meeting Info section
            Section(header: Text("Meeting Info")) {
                // $ syntax to bind value
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\((Int)(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            // Attendees section
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    // Input new Attendee
                    TextField("New Attendee", text: $newAttendeeName)
                    // Compare with List to add a toolbar to add a button
                    Button(action: {
                        withAnimation {
                            let newAttendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(newAttendee)
                            // after binded, clear the input
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        // why need constant?
        DailyScrumEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
