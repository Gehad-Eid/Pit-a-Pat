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

    var body: some View {
        GeometryReader { geometry in
            ARViewRepresentable()
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
                
            if showInstruction1 {
                Spacer()
                    .frame(maxWidth: .infinity)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 9)

                Rectangle()
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
                        Manager.shared.ARStream.send(.removeAll)
                        showInstruction1 = false
                        showInstruction2 = true
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
            } else if showInstruction2 {
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
            } else if showStartButton {
                Button(action: {
                    Manager.shared.ARStream.send(.generateHoles(difficulty: 5))
                    showStartButton = false
                    showCounter = true
                    countdownViewModel.startCountdown()
                }) {
                    Rectangle()
                        .foregroundColor(Color("Color2"))
                        .frame(width: 335, height: 72)
                        .cornerRadius(8)
                        .overlay(
                            Text("Set the phone in the middle of the playing zone and press to start")
                                .font(.custom("Ithra-Bold", size: 18))
                                .padding()
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                        )
                }
                .frame(maxWidth: .infinity)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
            } else if showCounter {
                VStack {
                    Text("\(countdownViewModel.counter)")
                        .font(.system(size: 90, weight: .bold))
                        .padding()
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
            }
        }
    }
}

#if DEBUG
struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
#endif
