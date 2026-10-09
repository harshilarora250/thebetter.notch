//
//  WelcomeView.swift
//  boringNotch
//
//  Created by Richard Kunkli on 2024. 09. 26..
//

import SwiftUI
import SwiftUIIntrospect

struct WelcomeView: View {
    var onGetStarted: (() -> Void)? = nil
    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                Image("spotlight")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                    .blur(radius: 3)
                    .offset(y: -5)
                    .background(SparkleView().opacity(0.6))
                VStack(spacing: 8) {
                    BetterNotchMark()
                        .padding(.bottom, 8)
                    Text("Better Notch")
                        .font(.system(.largeTitle, design: .default))
                        .fontWeight(.semibold)
                    Text("Welcome")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 30)
                    if false {
                        Text("PRO")
                            .font(.system(size: 18, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 3)
                            .background(
                                Capsule()
                                    .fill(LinearGradient(colors: [.white.opacity(0.7), .white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .strokeBorder(LinearGradient(stops: [.init(color: .white.opacity(0.7), location: 0.3), .init(color: .clear, location: 0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .blendMode(.overlay)
                            )
                            .padding(.bottom, 30)
                    }


                    Button {
                        onGetStarted?()
                    } label: {
                        Text("Get started")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                .padding(.top)
            }
            
            Text("A calmer space for your music")
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
                .padding(.bottom, 36)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
        .background {
            VisualEffectView(material: .hudWindow, blendingMode: .behindWindow)
                .ignoresSafeArea()
        }
    }
}

private struct BetterNotchMark: View {
    private let waveformHeights: [CGFloat] = [8, 15, 21, 13, 18, 9]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 27, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.16, green: 0.21, blue: 0.32),
                            Color(red: 0.07, green: 0.09, blue: 0.15),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Circle()
                .fill(Color(red: 0.43, green: 0.73, blue: 0.91).opacity(0.34))
                .frame(width: 52, height: 52)
                .blur(radius: 24)
                .offset(x: 26, y: -28)

            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .fill(.black)
                .frame(width: 66, height: 34)
                .overlay {
                    HStack(alignment: .center, spacing: 3) {
                        ForEach(Array(waveformHeights.enumerated()), id: \.offset) { _, height in
                            Capsule()
                                .fill(Color(red: 0.72, green: 0.88, blue: 1.0))
                                .frame(width: 3, height: height)
                        }
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .strokeBorder(.white.opacity(0.14), lineWidth: 1)
                }
        }
        .frame(width: 100, height: 100)
        .overlay {
            RoundedRectangle(cornerRadius: 27, style: .continuous)
                .strokeBorder(.white.opacity(0.14), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.22), radius: 18, y: 8)
        .accessibilityLabel("Better Notch")
    }
}

#Preview {
    WelcomeView()
}
