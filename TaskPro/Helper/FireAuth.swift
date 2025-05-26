//
//  FireAuth.swift
//  TaskPro
//
//  Created by Akram Ul Hasan on 25/5/25.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FirebaseAuth


struct FireAuth {
    static let share = FireAuth()
    
    private init() { }
    
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
                
                print("Sign in with Google sucessfully")
                
                UserDefaults.standard.set(true, forKey: "signIn")
                
            }
        }
    }
}
