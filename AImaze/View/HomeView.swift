import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State var complete = false
    
    var body: some View {
        
        VStack{
            
            Spacer()
            Image("bob")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom, -60)
            Text("AImaze")
                .font(.system(size: 150))
                .bold()
                .font(.title)
            
            Button(action: {
                navigationManager.navigate(to: .maze)
            }, label: {
                Text(.init(systemName: "play.fill"))
                    .font(.system(size: 100))
                    .foregroundStyle(Color.green)
            })
            Spacer()
            if navigationManager.complete {
                VStack(spacing: 20){
                    Button {
                        navigationManager.navigate(to: .freePlay)
                    } label: {
                        VStack{
                            Text(.init(systemName: "play.fill"))
                                .font(.system(size: 60))
                                .foregroundStyle(Color.green)
                            Text("FreePlay")
                                .font(.system(size: 30))
                                .bold()
                                .foregroundStyle(Color.black)
                        }
                        .padding()
                        .padding(.horizontal, 100)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        
                        
                    }
                    
                    Button {
                        navigationManager.navigate(to: .explain)
                    } label: {
                        VStack{
                            Text(.init(systemName: "questionmark"))
                                .font(.system(size: 60))
                                .foregroundStyle(Color.blue)
                            Text("How does app work?")
                                .font(.system(size: 30))
                                .bold()
                                .foregroundStyle(Color.black)
                        }
                        .padding()
                        .padding(.horizontal, 20)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .padding(.bottom, 60)
            } else {
                Text("Lock portrait mode for a better experience")
                    .font(.system(size: 30))
                    .italic()
            }
            
            
        }
    }
}

#Preview {
    HomeView()
}
