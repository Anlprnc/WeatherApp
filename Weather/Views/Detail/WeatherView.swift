//
//  WeatherView.swift
//  Weather
//
//  Created by Anıl on 30.09.2024.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    var searchResults: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            Color.background
                .ignoresSafeArea()
            
            // MARK: Weather Widgets
            ScrollView(showsIndicators: true) {
                VStack(spacing: 20) {
                    ForEach(searchResults) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            // MARK: Navigation Bar
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
//        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city")
    }
}

#Preview {
    NavigationView {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
