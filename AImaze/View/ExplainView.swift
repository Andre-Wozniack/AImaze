//
//  SwiftUIView.swift
//  
//
//  Created by André Wozniack on 23/02/24.
//

import SwiftUI

struct ExplainView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack(alignment: .center) {
            
            Image("iconMid")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
        
            List{
                DisclosureGroup(
                    content: { Text("AImaze employs a backtracking algorithm to generate mazes. Starting from an initial cell, it forges a path by marking passages and removing walls. Directions are chosen randomly and pursued if they lead to an unvisited cell. The algorithm backtracks at dead ends and continues until every cell is explored, creating a perfect maze with a unique path between any two points, ensuring a novel challenge every time.")
                            .font(.system(size: 25))
                            .padding(8)
                        
                        
                    }, label: {
                        Text("Backtracking algorithm")
                            .font(.system(size: 40))
                            .bold()
                    }
                )
                .accentColor(.blue)
                DisclosureGroup(
                    content: {
                        Text(
                            "AImaze uses the A* algorithm to quickly navigate mazes and find the shortest path. A* smartly assesses each step, focusing on moves that seem most likely to lead directly to the goal. It avoids dead-ends and unnecessary detours by prioritizing the most promising directions. This method ensures AImaze efficiently solves even the most complex puzzles, demonstrating the power and speed of A* in finding the best route through the maze.")
                            .font(.system(size: 25))
                            .padding(8)
                    },
                    label: {
                        Text("A* algorithm")
                            .font(.system(size: 40))
                            .bold()
                    }
                )
                .accentColor(.blue)
                DisclosureGroup(
                    content: {
                        Text("Note that for larger mazes, you might experience a slight decrease in performance or occasional stutters. This is a common challenge with powerful AI technologies, as they require significant computational effort to solve complex problens. The intricate process of navigating through vast labyrinths can demand more from the system, leading to these minor performance impacts. This reflects the real-world balance between the capabilities of advanced AI and the computational resources they consume.")
                            .font(.system(size: 25))
                            .padding(8)
                    },
                    label: {
                        Text("Performace")
                            .font(.system(size: 40))
                            .bold()
                    }
                )
                .accentColor(.blue)
            }
            
            Spacer()
            Button {
                navigationManager.navigate(to: .home)
                
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
        .padding(20)
    }
}

#Preview {
    ExplainView()
}
