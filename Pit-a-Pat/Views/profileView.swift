//
//  ProfileView.swift
//  AutoAuthInCloudKit
//
//  Created by Khawlah Khalid on 29/10/2023.
//

import SwiftUI
import PhotosUI
import CloudKit

struct ProfileView: View {
    
    @StateObject var profileVM = ProfileViewModel()

    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    Spacer()
                    ZStack(alignment: .bottom){
                        profileVM.avatarImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .clipShape(Circle())
                        PhotosPicker(selection: $profileVM.selectedImage, matching: .images) {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.white)
                        }
                    }
                    .onChange(of: profileVM.selectedImage) { _ in
                        Task {
                            if let data = try? await profileVM.selectedImage?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    profileVM.avatarImage = Image(uiImage: uiImage)
                                    return
                                }
                            }
                            
                            print("Failed")
                        }
                        
                    }
                    Spacer()
                }
                TextField("Name", text: $profileVM.Name)
                //                TextField("Score", Int($profileVM.score)
                
                TextField("Score", text: Binding<String>(
                    get: { String(profileVM.score) },
                    set: { if let value = Int($0) { profileVM.score = value } }
                ))
                
                
                TextField("Level", text: Binding<String>(
                    get: { String(profileVM.level) },
                    set: { if let value = Int($0) { profileVM.level = value } }
                ))
                
                //                TextField("Level", Int($profileVM.level)
                
                //                Picker("Age", selection: $profileVM.age) {
                //                    ForEach(20..<80){ age in
                //                        Text("\(age)")
                //                            .tag(age)
                //                    }
                //                }
                
                NavigationLink(destination:PlayersView()) {
                                  Image(systemName: "photo")
                                      .resizable()
                                      .aspectRatio(contentMode: .fit)
                                      .frame(width: 100, height: 100)
                                      .foregroundColor(.blue)
                              }
            }
            .navigationTitle("Profile")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        Task{
                            await profileVM.saveProfile()
                        }
                    }
                }
            }
            .task {
               await profileVM.fetchUserProfile()
            }
        }
    }

}

#Preview {
    ProfileView()
}
