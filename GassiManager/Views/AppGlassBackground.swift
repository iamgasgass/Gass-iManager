//
//  AppGlassBackground.swift
//  Gass iManager
//
//  Sfondo identico a quello di GetMoreRam (GlassUI.swift → AppGlassBackground),
//  copiato letteralmente e usato in tutte le schermate dell'app.
//

import SwiftUI

/// Atmospheric graphite backdrop inspired by the app icon. It stays behind
/// content so Apple's glass surfaces can refract the background naturally.
struct AppGlassBackground: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black

                LinearGradient(
                    // Near-black graphite gradient keeps the native glass
                    // readable without washing the screen into grey.
                    colors: [
                        Color(red: 0.035, green: 0.038, blue: 0.045),
                        Color(red: 0.012, green: 0.014, blue: 0.018),
                        Color.black
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Circle()
                    .fill(Color(red: 0.72, green: 0.78, blue: 0.86).opacity(0.045))
                    .frame(width: proxy.size.width * 0.78)
                    .blur(radius: 100)
                    .offset(x: proxy.size.width * 0.42, y: -proxy.size.height * 0.34)

                Circle()
                    .fill(Color.white.opacity(0.022))
                    .frame(width: proxy.size.width * 0.66)
                    .blur(radius: 90)
                    .offset(x: -proxy.size.width * 0.50, y: proxy.size.height * 0.10)

                LinearGradient(
                    colors: [.clear, Color.black.opacity(0.78)],
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }
}
