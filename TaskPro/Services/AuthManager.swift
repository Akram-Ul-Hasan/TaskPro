//
//  AuthManager.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 26/5/25.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import AuthenticationServices
import LocalAuthentication

final class AuthManager: ObservableObject {
    
    @Published var currentUser: UserModel? = nil
    @Published var isSignedIn: Bool = false
    
    static let shared = AuthManager()

    private init() {}
    
    func signinWithGoogle(presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    completion(error)
                    return
                }
                
                if let firebaseUser = result?.user {
                    let user = UserModel(
                        uid: firebaseUser.uid,
                        name: firebaseUser.displayName ?? "",
                        email: firebaseUser.email,
                        photoURL: firebaseUser.photoURL?.absoluteURL,
                        userType: .loggedIn)
                    
                    self.currentUser = user
                    print("Sign in with Google sucessfully")

                }
                UserDefaults.standard.set(true, forKey: "signIn")
                
            }
        }
    }
    
    func signInWithApple(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let _ = authorization.credential as? ASAuthorizationAppleIDCredential {
                UserDefaults.standard.set(true, forKey: "signIn")
            }
        case .failure(let error):
            print("Apple Id Sign in error: \(error.localizedDescription)")
        }
    }
    
    func authenticationWithBioMetries() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authentication with Face ID or Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    UserDefaults.standard.set(true, forKey: "signIn")
                } else {
                    print("Authentication with Biomatries error: \(error?.localizedDescription ?? "Biomatries Error")")
                }
            }
        } else {
            print("Authentication with Biomatries error: \(error?.localizedDescription ?? "Biomatries Error")")
        }
    }
    
    func signOut(session: UserSession) {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            UserDefaults.standard.set(false, forKey: "signIn")
        } catch {
            print("❌ Sign out error: \(error)")
        }
    }
    
    
}
