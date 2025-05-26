//
//  SignInScreen.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 25/5/25.
//

import SwiftUI

struct SignInScreen: View {
    var body: some View {
            VStack(spacing: 32) {
                Spacer()
                VStack(spacing: 8) {
                    Image("appLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                    Text("Welcome to TaskPro")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .padding(.top, 60)

                Spacer()

                // Sign in Buttons
                VStack(spacing: 16) {
                    Button(action: {
                        FireAuth.share.signinWithGoogle(presenting: getRootViewController()) { error in
                            print("Error from signinWithGoogle: \(error?.localizedDescription ?? "")")
                        }
                    }) {
                        HStack {
                            Image("googleIcon") // Add `googleIcon` to Assets
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Sign in with Google")
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    }

                    Button(action: {
                        // Handle GitHub Sign-In
                    }) {
                        HStack {
                            Image("githubIcon") // Add `githubIcon` to Assets
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Sign in with GitHub")
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

//                    SignInWithAppleButton(
//                        .signIn,
//                        onRequest: { request in
//                            request.requestedScopes = [.fullName, .email]
//                        },
//                        onCompletion: { result in
//                            // Handle Apple Sign-In
//                        }
//                    )
//                    .signInWithAppleButtonStyle(.black)
//                    .frame(height: 50)
//                    .cornerRadius(10)
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .background(Color(.systemGroupedBackground))
//            .ignoresSafeArea()
        }
    }
#Preview {
    SignInScreen()
}
