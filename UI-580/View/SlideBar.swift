//
//  SlideBar.swift
//  UI-580
//
//  Created by nyannyan0328 on 2022/06/07.
//

import SwiftUI

struct SlideBar: View {
    var props : Properties
    @Binding var currentTab : Tab
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:15){
                
                
                HStack{
                    
                    Image("icloud")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                    
                    Text("icloud")
                        .font(.caption.bold())
                }
                
                
                Rectangle()
                    .fill(.white.opacity(0.1))
                    .frame(height: 1)
                    .padding(.horizontal,-15)
                
                
                ForEach(Tab.allCases,id:\.rawValue){tab in
                    
                    
                    Button {
                        withAnimation(.easeInOut){currentTab = tab}
                    } label: {
                        
                        
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height:20)
                        
                        Text(tab.rawValue)
                            .font(.caption2.bold())
                    }
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.6))
                      .frame(maxWidth: .infinity,alignment: .leading)

                }
                .padding(.top)
                
                
            }
            .padding(13)
            
            
            
        }
        .frame(width: 220)
         .background{
        
             RoundedRectangle(cornerRadius: 10, style: .continuous)
                 .fill(Color("Overlay")).ignoresSafeArea()
        }
    }
}

struct SlideBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
