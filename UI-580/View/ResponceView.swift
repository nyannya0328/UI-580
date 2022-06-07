//
//  ResponceView.swift
//  UI-580
//
//  Created by nyannyan0328 on 2022/06/07.
//

import SwiftUI

struct ResponceView<Content : View>: View {
    
    var content : (Properties) -> Content
    var body: some View {
        GeometryReader{proxy in
            
            let size = proxy.size
            let isRandSacpe = (size.width > size.height)
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            
            content(Properties(isIpad: isIpad, isLandScape: isRandSacpe, isSprit: isSprit(), size: size))
                .frame(width: size.width, height: size.height)
                .onAppear {
                    
                    updateNorification(fraction: isRandSacpe && !isSprit() ? 0.3 : 0.5)
                }
                .onChange(of: isRandSacpe) { newValue in
                    
                    updateNorification(fraction: isRandSacpe && !isSprit() ? 0.3 : 0.5)
                }
            
        }
    }
    func updateNorification(fraction : Double){
        
        
        NotificationCenter.default.post(name: NSNotification.Name("NOTIFICATION"), object: nil,userInfo: [
        
            "Fraction" : fraction
        
        ])
        
    }
    func isSprit()->Bool{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return false
        }
        return screen.windows.first?.frame.size != screen.windows.first?.frame.size
        
    }
}

struct Properties{
    var isIpad : Bool
    var isLandScape : Bool
    var isSprit : Bool
    var size : CGSize
}
