//
//  MainView.swift
//  UI-580
//
//  Created by nyannyan0328 on 2022/06/07.
//

import SwiftUI

struct MainView: View {
    @State var currentTab : Tab = .dashboard
    @State var showSlideBar : Bool = false
    var body: some View {
        ResponceView { props in
            
            HStack(spacing:0){
                if props.isIpad && !props.isSprit{
                
                SlideBar(props: props, currentTab: $currentTab)
                    
                }
                
                DashBoardView(props: props, showSlideBar: $showSlideBar)
                
            }
            .overlay {
                
                ZStack(alignment: .leading) {
                    
                    Color.black
                        .opacity(showSlideBar ? 0.36 : 0)
                        .ignoresSafeArea()
                        .onTapGesture {
                            
                            withAnimation(.easeInOut){
                                
                                showSlideBar = false
                            }
                        }
                    
                    if showSlideBar{
                        
                        SlideBar(props: props, currentTab: $currentTab)
                            .transition(.move(edge: .leading))
                    }
                    
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
