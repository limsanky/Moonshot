//
//  AstronautView.swift
//  Moonshot
//
//  Created by Sankarshana V on 2022/02/02.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                astronautImage
                astronautDescription
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var astronautImage: some View {
        Image(astronaut.id)
            .resizable()
            .scaledToFit()
    }
    
    var astronautDescription: some View {
        Text(astronaut.description).padding()
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
            .preferredColorScheme(.dark)
    }
}
