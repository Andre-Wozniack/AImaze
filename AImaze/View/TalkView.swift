//
//  SwiftUIView.swift
//  
//
//  Created by André Wozniack on 23/02/24.
//

import SwiftUI

struct TalkView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var isText1Expanded = false
    @State private var isText2Expanded = false
    @State private var isText3Expanded = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Image("iconMid")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
        
            List{
                DisclosureGroup(
                    content: { Text("You've just experienced the power of AI navigating through mazes in IAmaze. Now, picture this in your everyday life. AI is there every time your phone recognizes your face to unlock the screen, with technology working in milliseconds to identify your features.")
                            .font(.system(size: 30))
                        
                        
                    }, label: {
                        Text("AI in Everyday Life")
                            .font(.system(size: 40))
                            .bold()
                    }
                )
                .accentColor(.blue)
                DisclosureGroup(
                    content: {
                        Text("Those movie and series recommendations that seem to know exactly what you'd like to watch next? That's AI too, analyzing your past choices and preferences to predict your next interest.")
                            .font(.system(size: 30))
                    },
                    label: {
                        Text("Movie and Series Recommendations")
                            .font(.system(size: 40))
                            .bold()
                    }
                )
                .accentColor(.blue)
                DisclosureGroup(
                    content: {
                        Text("AI is already a part of our daily lives, simplifying tasks, enhancing security, and optimizing our time. IAmaze is just a small demonstration of this reality, a glimpse into the vast potential AI holds to transform our lives.")
                            .font(.system(size: 30))
                    },label: {
                        Text("AI in Our Daily Lives")
                            .font(.system(size: 40))
                            .bold()
                    }
                )
                .accentColor(.blue)
            }
            Spacer()
            Button {
                navigationManager.navigate(to: .home)
                navigationManager.complete = true
            } label: {
                VStack{
                    Text("Back to home")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundStyle(Color.blue)
                }
                .padding()
                .padding(.horizontal, 80)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                
                
            }
        }
        .padding()
    }
}


#Preview {
    TalkView()
}
