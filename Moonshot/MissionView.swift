//
//  MissionView.swift
//  Moonshot
//
//  Created by Sankarshana V on 2022/02/01.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
        
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)!")
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    missionImage(of: geometry.size.width)
                    launchDate
                    
                    VStack(alignment: .leading) {
                     
                        
                        customHorizontalDivider
                        
                        highlightsTitle
                        
                        Text(mission.description)
                        
                        customHorizontalDivider
                        
                        crewTitle
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        information(of: crewMember)
                                        
                                        if crewMember.role != crew.last?.role {
                                            customVerticalDivider
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .background(.darkBackground)
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var launchDate: some View {
        Text(mission.formattedLaunchDate)
            .font(.headline)
            .foregroundColor(.white.opacity(0.6))
            .padding(.top)
    }
        
    func missionImage(of width: CGFloat) -> some View {
        Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: width * 0.7)
            .padding(.top)
    }
    
    func information(of crewMember: CrewMember) -> some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundColor(.white)
                    .font(.headline)
                    
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
    
    var customHorizontalDivider: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
    
    var customVerticalDivider: some View {
        Rectangle()
            .frame(width: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
    
    var highlightsTitle: some View {
        Text("Mission Highlights")
            .font(.title.bold())
            .padding(.bottom, 5)
    }
    
    var crewTitle: some View {
        Text("Crew").font(.title.bold())
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
