//
//  DailyScrumsCardView.swift
//  Scrumdinger
//
//  Created by Ben Woo on 5/10/2022.
//

import SwiftUI

struct DailyScrumsCardView: View {
    // Input parameter of Daily Scrum
    let dailyScrum: DailyScrum
    var body: some View {
        VStack(alignment: .leading) {
            Text(dailyScrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(dailyScrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(dailyScrum.attendees.count) attendees")
                Spacer()
                // use a customized lable style - .trailingIcon
                Label("\(dailyScrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(dailyScrum.lengthInMinutes) minute meeting")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(dailyScrum.theme.accentColor)
    }
}

struct DailyScrumsCardView_Previews: PreviewProvider {
    static var dailyScrum = DailyScrum.sampleData[0]
    static var previews: some View {
        DailyScrumsCardView(dailyScrum: dailyScrum)
            .background(dailyScrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
