//
//  ForecastCard.swift
//  Weather
//
//  Created by Anıl on 30.09.2024.
//

import SwiftUI

struct ForecastCard: View {
    var foreacst: Forecast
    var foreacstPeriod: ForecastPeriod
    var isActive: Bool {
        if foreacstPeriod == ForecastPeriod.hourly {
            let isThisHour = Calendar.current.isDate(.now, equalTo: foreacst.date, toGranularity: .hour)
            return isThisHour
        } else {
            let isToday = Calendar.current.isDate(.now, equalTo: foreacst.date, toGranularity: .day)
            return isToday
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                .frame(width: 60, height: 146)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            // MARK: Content
            VStack(spacing: 16) {
                // MARK: Forecast Date
                Text(foreacst.date, format: foreacstPeriod == ForecastPeriod.hourly ? .dateTime.hour() : .dateTime.weekday())
                    .font(.subheadline.weight(.semibold))
                
                VStack(spacing: -4) {
                    // MARK: Forecast Small Icon
                    Image("\(foreacst.icon) small")
                    
                    // MARK: Forecast Probability
                    Text(foreacst.probability, format: .percent)
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(Color.probabilityText)
                        .opacity(foreacst.probability > 0 ? 1 : 0)
                }
                .frame(height: 42)
                
                // MARK: Forecast Temperature
                Text("\(foreacst.temperature)°")
                    .font(.title3)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 60, height: 146)
        }
    }
}

#Preview {
    ForecastCard(foreacst: Forecast.hourly[0], foreacstPeriod: .hourly)
}
