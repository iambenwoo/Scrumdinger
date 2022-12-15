//
//  DailyScrumMeetingView.swift
//  Scrumdinger
//
//  Created by Ben Woo on 4/10/2022.
//

import SwiftUI
import AVFoundation

struct DailyScrumMeetingView: View {
    
    @Binding var scrum: DailyScrum
    
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                // Circle().strokeBorder(lineWidth: 24)
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            .padding()
            .foregroundColor(scrum.theme.accentColor)
            .onAppear {
                scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
                // start counting time
                // Simulator cannot play o
                scrumTimer.speakerChangedAction = {
                    player.seek(to: .zero)
                    player.play()
                }
                scrumTimer.startScrum()
            }
            .onDisappear {
                scrumTimer.stopScrum()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct DailyScrumMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        DailyScrumMeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
