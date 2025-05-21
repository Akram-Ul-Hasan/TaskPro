//
//  OnboardingScreen.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 20/5/25.
//

import SwiftUI

enum OnboardingPage: Int, CaseIterable {
    case first, second, third

    var title: String {
        switch self {
        case .first: return "Welcome to TaskPro"
        case .second: return "Organize Smartly"
        case .third: return "Stay Notified"
        }
    }

    var description: String {
        switch self {
        case .first:
            return "Keep track of important things you need to get done in one place."
        case .second:
            return "Group your tasks into custom lists. Add, edit, and manage your workflow with ease and clarity."
        case .third:
            return "TaskPro can remind you about important deadlines and events. You’ll never miss what matters."
        }
    }
}

struct OnboardingScreen: View {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    @State private var currentPage = 0
    @State private var isAnimating = false
    @State private var deliveryOffset = false
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    onboardingView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring(), value: currentPage)
            
            // Page indicator
            HStack(spacing: 12) {
                ForEach(0..<OnboardingPage.allCases.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                        .animation(.easeInOut, value: currentPage)
                }
            }
            .padding(.bottom, 20)
            
            // Button
            Button {
                withAnimation(.spring()) {
                    if currentPage < OnboardingPage.allCases.count - 1 {
                        currentPage += 1
                        isAnimating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isAnimating = true
                        }
                    } else {
                        hasSeenOnboarding = true
                        ContentView()
                    }
                }
            } label: {
                Text(currentPage < OnboardingPage.allCases.count - 1 ? "Next" : "Get Started")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 30)
            .padding(.bottom)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
    }
    
    // MARK: - Onboarding View
    @ViewBuilder
    private func onboardingView(for page: OnboardingPage) -> some View {
        VStack(spacing: 20) {
            ZStack {
                switch page {
                case .first:
                    firstPageAnimation
                case .second:
                    secondPageAnimation
                case .third:
                    thirdPageAnimation
                }
            }
            Text(page.title)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
            
            Text(page.description)
                .font(.system(.title3, design: .rounded))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
        }
        .padding(.top, 50)
    }
    
    // MARK: - Animations

    private var firstPageAnimation: some View {
        Image("welcome")
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .offset(y: isAnimating ? 0 : 20)
            .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
    }

    private var secondPageAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.4), lineWidth: 2)
                .frame(width: 200, height: 200)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            
            Image("note")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .offset(y: deliveryOffset ? -20 : 0)
                .rotationEffect(.degrees(deliveryOffset ? 5 : -5))
                .opacity(isAnimating ? 1 : 0)
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimating)
            
            ForEach(0..<8) { index in
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .offset(
                        x: 120 * cos(Double(index) * .pi / 4),
                        y: 120 * sin(Double(index) * .pi / 4)
                    )
                    .animation(.easeInOut(duration: 1.5).repeatForever().delay(Double(index) * 0.1), value: isAnimating)
            }
        }
    }

    private var thirdPageAnimation: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            
            Image("notify")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .opacity(isAnimating ? 1 : 0)
                .scaleEffect(isAnimating ? 1 : 0.8)
                .rotation3DEffect(.degrees(isAnimating ? 180 : 10), axis: (x: 0, y: 1, z: 0))
                .animation(.spring(dampingFraction: 1).delay(0.2), value: isAnimating)
            
            ForEach(0..<4) { index in
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
                    .offset(
                        x: 100 * cos(Double(index) * .pi / 2),
                        y: 100 * sin(Double(index) * .pi / 2)
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0)
                    .animation(.spring(dampingFraction: 0.6).delay(Double(index) * 0.1), value: isAnimating)
            }
        }
    }
}

#Preview {
    OnboardingScreen()
}
