import SwiftUI


struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack{
                ARViewRepresentable()
                
                VStack {
                    NavigationLink(destination: ConnectWithSomeone()) {
                        
                        // نحط بدالها ايميج او ثري دي عادي ماهو بالاي ار
                        Rectangle()
                            .fill(.orange)
                            .frame(width: 200,height: 150)
                            .padding()
                            .overlay( Text("play"))
                    }
                    
                    NavigationLink(destination: Leaderboared()) {
                        // نحط بدالها ايميج او ثري دي عادي ماهو بالاي ار
                        Rectangle()
                            .fill(.red)
                            .frame(width: 200,height: 150)
                            .padding()
                            .overlay( Text("LeaderBoard"))
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    MainView()
}

