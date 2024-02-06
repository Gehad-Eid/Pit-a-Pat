////
////  ConnectWithSomeone.swift
////  Pit-a-Pat
////
////  Created by Gehad Eid on 27/01/2024.
////
//
//import SwiftUI
//
//struct HostAGame: View {
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        NavigationView {
//            //ZStack{
//            ARViewRepresentable()
//                .edgesIgnoringSafeArea(.all)
//                .overlay(
//                    TabView(selection: $selectedTab) {
//                        // Replace these with instructions for the game and how to play .. when finished it will connect with some one in ConnectWithSomeone view
//                        
//                        // TRASH CODE
//                        Rectangle()
//                            .fill(.blue)
//                            .frame(width: 100,height: 100)
//                            .padding()
//                            .overlay(
//                                VStack{
//                                    Text("fghj")
////                                     1. host or join ?
////                                    
////                                     Host:
////                                     1. set the phone on the meddel of the playing zone and press start
////                                     2. connect with someone who's joining
////                                     3. press start
////                                    
////                                    Join:
////                                     1. go to the host and peer with them
////                                    
//                                    Button{
//                                        ARManager.shared.ARStream.send(.removeAll)
//                                    } label: {
//                                        Image (systemName: "trash")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 40, height: 40)
//                                            .padding()
//                                            .background (.regularMaterial)
//                                            .cornerRadius (16)
//                                    }
//                                    
//                                    
//                                }
//                            )
//                            .tag(0)
//                        
//                        
//                        Rectangle()
//                            .fill(.orange)
//                            .frame(width: 100,height: 100)
//                            .padding()
//                            .overlay(
//                                Button{
////                                    ARManager.shared.ARStream.send(.addHoles)
//                                } label: {
//                                    Image (systemName: "star")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 40, height: 40)
//                                        .padding()
//                                        .background (.regularMaterial)
//                                        .cornerRadius (16)
//                                }
//                            )
//                            .tag(1)
//                        
//                        
//                        
//                        Rectangle()
//                            .fill(.red)
//                            .frame(width: 100,height: 100)
//                            .padding()
//                            .overlay(
////                                NavigationLink(destination: ConnectWithSomeone().navigationBarBackButtonHidden(true)) {
//                                    Button{
//                                        ARManager.shared.ARStream.send(.throwBalls)
//                                    } label: {
//                                        Image (systemName: "pin")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 40, height: 40)
//                                            .padding()
//                                            .background (.regularMaterial)
//                                            .cornerRadius (16)
//                                    }
////                                }
//                                
//                            )
//                            .tag(2)
//                    }
//                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//                        .background(Color.clear)
//                        .frame(maxWidth: .infinity, maxHeight: 150)
//                )
//            //}
//            //.navigationBarHidden(true)
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//#Preview {
//    HostAGame()
//}
//
//
//
//
//////
//////  HostAGame.swift
//////  Pit-a-Pat
//////
//////  Created by Gehad Eid on 30/01/2024.
//////
////
////import SwiftUI
////
////struct HostAGame: View {
////    @State private var selectedTab = 0
////    
////    var body: some View {
////        NavigationStack{
////            ARViewRepresentable()
////                .edgesIgnoringSafeArea(.all)
////                .overlay(
////                    TabView(selection: $selectedTab) {
////                        VStack{
////                            Text("set the phone on the meddel of the playing zone and press start")
////                            
////                            Button{
////                                Manager.shared.ARStream.send(.generateHoles(difficulty: 5))
////                            } label: {
////                                // change this of course
////                                Image (systemName: "star")
////                                    .resizable()
////                                    .scaledToFit()
////                                    .frame(width: 40, height: 40)
////                                    .padding()
////                                    .background (.regularMaterial)
////                                    .cornerRadius (16)
////                            }
////                            
////                        }
////                        .tag(0)
////                        
////                        VStack{
////                            Text("set the phone on the meddel of the playing zone and press start")
////                            
////                            Button{
////                                Manager.shared.ARStream.send(.generateHoles(difficulty: 5))
////                            } label: {
////                                // change this of course
////                                Image (systemName: "star")
////                                    .resizable()
////                                    .scaledToFit()
////                                    .frame(width: 40, height: 40)
////                                    .padding()
////                                    .background (.regularMaterial)
////                                    .cornerRadius (16)
////                            }
////                            
////                        }
////                        .tag(1)
////                        
////                        VStack{
////                            Text("set the phone on the meddel of the playing zone and press start")
////                            
////                            Button{
////                                Manager.shared.ARStream.send(.generateHoles(difficulty: 5))
////                            } label: {
////                                // change this of course
////                                Image (systemName: "star")
////                                    .resizable()
////                                    .scaledToFit()
////                                    .frame(width: 40, height: 40)
////                                    .padding()
////                                    .background (.regularMaterial)
////                                    .cornerRadius (16)
////                            }
////                            
////                        }
////                        .tag(2)
////                    }
////                       
////                )
////        }
////        .edgesIgnoringSafeArea(.all)
////    }
////    
////}
////
////#Preview {
////    HostAGame()
////}
