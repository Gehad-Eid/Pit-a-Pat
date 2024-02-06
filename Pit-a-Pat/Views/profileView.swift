
//

import SwiftUI
import PhotosUI
import CloudKit

struct ProfileView: View {
    
    @StateObject var profileVM = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            ZStack {
                //                ARViewRepresentable(blurred: true)
//                Rectangle()
                CameraView()
                    .edgesIgnoringSafeArea(.all)
                
                Image("Subtract")
                    .offset(y: -370)
                
                Text("Profile")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color.white)
                    .offset(y: -340)
                
                
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(width: 353, height: 480)
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            ZStack(alignment: .bottom) {
                                Image("avatar\(Int.random(in: 1..<7))")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .padding(.vertical)
                                    .padding(.horizontal, 2)
                            }.offset(y: -70)
                            
                            
                            Text(profileVM.Name)
                                .bold()
                                .offset(x: 0 , y: -70 )
                            Rectangle()
                                .foregroundColor(Color.white)
                                .frame(width: 338, height: 83)
                                .cornerRadius(12)
                                .overlay(
                                    HStack {
                                        Text("Your Level")
                                            .foregroundColor(.black)
                                            .padding(.leading,20)
                                        Spacer()
                                        Text(String(profileVM.level))
                                            .padding(.trailing, 10)
                                        
                                        
                                    }
                                )
                                .offset(y: -50)
                            
                            
                            Rectangle()
                                .foregroundColor(Color.white)
                                .frame(width: 338, height: 83)
                                .cornerRadius(12)
                                .overlay(
                                    HStack {
                                        HStack {
                                            Text("Your Score")
                                                .foregroundColor(.black)
                                                .padding(.leading,20)
                                            Spacer()
                                            Text(String(profileVM.score))
                                                .padding(.trailing, 10)
                                        }
                                        .foregroundColor(.black)
                                        
                                    }
                                ).offset(y: -50)
                        }
                        
                    )
                
                    .cornerRadius(10)
                    .padding(.bottom, -70)
                
                
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading:
                                            Button(action: {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                        
                        
                        
                    }
                    )
//                    .toolbar {
//                        ToolbarItem(placement: .topBarTrailing) {
//                            Button {
//                                Task {
//                                    await profileVM.saveProfile()
//                                }
//                            } label: {
//                                Text("Save")
//                                    .font(.headline)
//                                    .foregroundColor(Color.white) // تحديد لون النص هنا
//                            }
//                        }
//                    }
                    .task {
                        await profileVM.fetchUserProfile()
                    }
            }
        }
        
    }
}


#Preview {
    ProfileView()
}
