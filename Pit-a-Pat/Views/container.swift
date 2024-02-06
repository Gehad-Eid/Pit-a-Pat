////
////  container.swift
////  Pit-a-Pat
////
////  Created by Gehad Eid on 29/01/2024.
////
//
//import SwiftUI
////import AuthenticationServices
//
//struct container: View {
//    @State var tt = false
//    var body: some View {
//        
//        //ZStack{
//        ARViewRepresentable(blurred: true, profileVM: ProfileViewModel)
//            .edgesIgnoringSafeArea(.all)
//            .overlay(
//                tt ? AnyView(HostAGame()) 
//                : AnyView(JoinAGame())
//
//                
//                
////                NavigationStack {
////                    VStack {
////                        Image("PitAPat")
////                            .resizable()
////                            .aspectRatio(contentMode: .fill)
////                            .frame(width: 200, height: 200)
////                            .clipped()
////                        
////                        NavigationLink(destination: InstructionView()) {
////                            Rectangle()
////                                .foregroundColor(Color("Color1"))
////                                .cornerRadius(12)
////                                .frame(width: 280, height: 44)
////                                .overlay(
////                                    Text("Play")
////                                        .foregroundColor(.white)
////                                        .font(.headline)
////                                )
////                        }
////                        
////                        NavigationLink(destination: Leaderboared()) {
////                            Rectangle()
////                                .foregroundColor(Color("Color1"))
////                                .cornerRadius(12)
////                                .frame(width: 280, height: 44)
////                                .overlay(
////                                    Text("LeaderBoard")
////                                        .foregroundColor(.white)
////                                        .font(.headline)
////                                )
////                        }
////                        
////                        
////                        SignInWithAppleButton(
////                            onRequest: { request in
////                                // Handle request if needed
////                            },
////                            onCompletion: { result in
////                                // Handle result if needed
////                            }
////                        )
////                        .frame(width: 280, height: 44)
////                        .cornerRadius(12)
////                        .padding()
////                    }
////                    
////                    //.blur(radius: 10)
////                }
////                    .navigationViewStyle(StackNavigationViewStyle())
////                    .edgesIgnoringSafeArea(.all)
//            )
//    }
//}
//
//
//#Preview {
//    container()
//}
