//
//  InstructionView.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 31/01/2024.
//
import SwiftUI

struct InstructionView: View {
    
    @ObservedObject var countdownViewModel = CountdownViewModel()
    @State private var showCounter = false
    @State private var showInstruction1 = true
    @State private var showInstruction2 = false
    @State private var showStartButton = false
    @State private var progress: CGFloat = 1.0
    @State private var remainingTime: Int = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject var profileVM = ProfileViewModel()
    @State private var showVictoryMessage = false
    @State private var victoryMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
//    @State private var textColor = Color.white
//    @State private var textOpacity = 1.0 // Start fully visible
//    @ObservedObject var overlayColorManager = OverlayColorManager()


    var body: some View {
        NavigationView{
        GeometryReader { geometry in
                ARViewRepresentable(/*overlayColorManager: overlayColorManager, */profileVM: profileVM)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                
                if showInstruction1 {
                    instructionView1(geometry: geometry)
                } else if showInstruction2 {
                    instructionView2(geometry: geometry)
                } else if showStartButton {
                    startButtonView(geometry: geometry)
                } else if showCounter && countdownViewModel.counter > 0 {
                    counterView(geometry: geometry)
                } else if showVictoryMessage {
                    Text(victoryMessage)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)           .onTapGesture {
                            showVictoryMessage = false
                        }
                } else {
                    VStack{
                        HStack{
                            ZStack{
                                Image("ball1")
                                Text("0\nMona\n")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            CircularProgressView(progress: progress, remainingTime: remainingTime)
                                .onReceive(timer) { _ in
                                    if remainingTime > 0 {
                                        progress -= 1.0 / 60.0
                                        remainingTime -= 1
                                    } else {
                                        timer.upstream.connect().cancel()
                                        showVictoryMessage = true
                                        victoryMessage = Bool.random() ? "You won! 🎉" : "You lost! 😢"
                                    }
                                }
                            Spacer()
                            
                            ZStack{
                                Image("ball2")
                                Text("0\n\(profileVM.Name)\n")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                        }.position(x: geometry.size.width / 2, y: geometry.size.height / 9)
                    }
                }
            }.onAppear {
                Task {
                    await profileVM.fetchUserProfile()
                }
            }
            
            
        }             
        .navigationBarBackButtonHidden(true)
        
        
        
   
                                

    }
    
    
    private func instructionView1(geometry: GeometryProxy) -> some View {
        Spacer()
            .frame(maxWidth: .infinity)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 9)

        return Rectangle()
            .foregroundColor(Color("Color2"))
            .frame(width: 335, height: 72)
            .cornerRadius(8)
            .overlay(
                Text("Pay attention to the pattern of colors")
                    .font(.custom("Ithra-Bold", size: 18))
                    .padding()
                    .multilineTextAlignment(.center)
            )
            .foregroundColor(.black)
            .onTapGesture {
//                ARManager.shared.ARStream.send(.removeAll)
                showInstruction1 = false
                showInstruction2 = true
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
    }
    
    private func instructionView2(geometry: GeometryProxy) -> some View {
        Rectangle()
            .foregroundColor(Color("Color2"))
            .frame(width: 335, height: 72)
            .cornerRadius(8)
            .overlay(
                Text("Pat the balls according to the colors pattern")
                    .font(.custom("Ithra-Bold", size: 18))
                    .padding()
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            )
            .frame(maxWidth: .infinity)
            .onTapGesture {
                showInstruction2 = false
                showStartButton = true
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
    }
    
    private func startButtonView(geometry: GeometryProxy) -> some View {
        Button(action: {
//            ARManager.shared.ARStream.send(.addHoles)
            showStartButton = false
            showCounter = true
            countdownViewModel.startCountdown()
        }) {
            Rectangle()
                .foregroundColor(Color("Color2"))
                .frame(width: 335, height: 72)
                .cornerRadius(8)
                .overlay(
                    Text("Place the two devices next to each other and scan the area around you")
                        .font(.custom("Ithra-Bold", size: 18))
                        .padding()
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                )
        }
        .frame(maxWidth: .infinity)
        .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
    }
    
    private func counterView(geometry: GeometryProxy) -> some View {
        VStack {
            Text("\(countdownViewModel.counter)")
                .font(.system(size: 90, weight: .bold))
                .padding()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
    }
}

//#if DEBUG
//struct InstructionView_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructionView()
//    }
//}
//#endif
