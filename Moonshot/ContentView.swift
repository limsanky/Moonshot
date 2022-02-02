//
//  ContentView.swift
//  Moonshot
//
//  Created by Sankarshana V on 2022/02/01.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isGridView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isGridView { gridView }
                else { listView }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                changeViewButton
            }
        }
    }
    
    var listView: some View {
        VStack {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        VStack {
                            missionName(of: mission)

                            missionLaunchDate(of: mission)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        customVerticalDivider
                        
                        missionImage(of: mission)
                            .padding(.horizontal)
                    }
                    .overlay(
                        Capsule()
                            .strokeBorder(.lightBackground, lineWidth: 3)
                    )
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    var customVerticalDivider: some View {
        Rectangle()
            .frame(width: 3)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        missionImage(of: mission)
                        
                        VStack {
                            missionName(of: mission)
                            missionLaunchDate(of: mission)
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    func missionLaunchDate(of mission: Mission) -> some View {
        Text(mission.formattedLaunchDate)
            .font(.caption)
            .foregroundColor(.white.opacity(0.5))
    }
    
    func missionName(of mission: Mission) -> some View {
        Text(mission.displayName)
            .font(.headline)
            .foregroundColor(.white)
    }
    
    func missionImage(of mission: Mission) -> some View {
        Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding()
    }
    
    var changeViewButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 1)) {
                isGridView.toggle()
            }
        } label: {
            Image(systemName: isGridView ? "list.dash" : "rectangle.grid.2x2")
               .foregroundColor(.white.opacity(0.6))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
