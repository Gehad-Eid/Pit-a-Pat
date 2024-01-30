//
//  SplashScreen.swift
//  Pit-a-Pat
//
//  Created by Faizah Almalki on 17/07/1445 AH.
//

import SwiftUI

    struct SplashScreen: View {
        @State private var showSplash = true
        @State private var isActive = false
        
        var body: some View {
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                
                if showSplash {
                    Image("PitAPat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showSplash = false
                                self.isActive = true
                            }
                        }
                } else {
                    if isActive {
                        NavigationStack {
                            MainView()
                        }
                        .navigationViewStyle(StackNavigationViewStyle())
                    }
                }
            }
        }
    }

    struct SplashScreen_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreen()
        }
    }

    

#Preview {
    SplashScreen()
}
