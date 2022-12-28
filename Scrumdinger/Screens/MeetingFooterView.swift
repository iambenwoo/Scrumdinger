//
//  DailyScrumMeetingFooter.swift
//  Scrumdinger
//
//  Created by Ben Woo on 10/10/2022.
//

import SwiftUI

struct MeetingFooterView: View {
    
    // ScrumTimer have an extension of attendees
    // It assign a variables to DailyScrum attendees
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()->Void
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil}
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    var body: some View {
        VStack {
            HStack{
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction){
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel(/*@START_MENU_TOKEN@*/"Next speaker"/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct DailyScrumMeetingFooter_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
