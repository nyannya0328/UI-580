//
//  DashBoardView.swift
//  UI-580
//
//  Created by nyannyan0328 on 2022/06/07.
//

import SwiftUI

struct DashBoardView: View {
    var props : Properties
    @Binding var showSlideBar : Bool
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            let showDetails = (props.isIpad && !props.isSprit && props.isLandScape)
            
            VStack(spacing:15){
                
                TopNavBar()
               
                
                HStack{
                    
                    Text("My files")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            
                            Text("Add Now")
                                
                            
                        } icon: {
                            
                            Image(systemName: "plus")
                        }
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.vertical,9)
                        .padding(.horizontal)
                        .background{
                         
                            RoundedRectangle(cornerRadius: 13, style: .continuous)
                                .fill(Color("Blue"))
                        }

                    }

                }
                .padding(.vertical)
                
                
                OnlineStorageView()
                
               
                
                
                FileView()
                    .padding(.vertical)
                   
                if !showDetails{
                    
                    StorageView()
                }
                
                
            }
            .padding(.trailing,showDetails ? (props.size.width / 4) + 15 : 0)
            .overlay(alignment: .trailing) {
                
                if showDetails{
                    
                    StorageView()
                        .frame(width: props.size.width / 4)
                    
                }
            }
           
        }
        .padding()
          .frame(maxWidth: .infinity,alignment: .center)
          .background{
           
              Color("BG").ignoresSafeArea()
          }
    }
    
    func getIndex(item : StorageDetail)->Int{
        
        return sampleStorageDetails.firstIndex { ICtem in
            ICtem.id == item.id
        } ?? 0
        
    }
    
    func getAngle(item : StorageDetail)->Angle{
        
        let index = getIndex(item: item)
        let prefix = sampleStorageDetails.prefix(index)
        var angel : Angle = .zero
        
        for item in prefix{
            
            angel += .init(degrees: item.progress * 360)
        }
        
        return angel
        
        
    }
    @ViewBuilder
    func StorageView()->some View{
        
        
        VStack(alignment: .leading, spacing: 14) {
            
              Text("Storage Details")
                .font(.title2.weight(.semibold))
                .foregroundColor(.white)
            
            
            ZStack{
                
                
                Circle()
                    .stroke(Color("BG"),lineWidth: 25)
                
                ForEach(sampleStorageDetails){storage in
                    
                    
                    let index = CGFloat(getIndex(item: storage))
                    let progress = index / CGFloat(sampleStorageDetails.count)
                    
                    
                    Circle()
                        .trim(from: 0, to: storage.progress)
                        .stroke(storage.progressColor,lineWidth: 35 - (10 * progress))
                        .rotationEffect(.init(degrees: -90))
                        .rotationEffect(getAngle(item: storage))
                    
                }
                
            }
            .frame(height: 250)
            .padding()
            
            
            ForEach(sampleStorageDetails){item in
                
                
                HStack(spacing:15){
                    
                    
                    Image(item.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        
                        Text(item.type)
                            .font(.caption.bold())
                        
                        
                        Text(item.files + " Files")
                            .font(.callout)
                        
                            .foregroundColor(.gray)
                        
                    }
                      .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    Text(item.size)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(.vertical,15)
                .padding(.horizontal)
                .background{
                 
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(.white.opacity(0.8))
                }
                .padding(.top)
                
            }
            
            
            
        }
          .frame(maxWidth: .infinity,alignment: .leading)
          .padding()
          .background{
           
              
              RoundedRectangle(cornerRadius: 10, style: .continuous)
                  .fill(Color("Overlay"))
          }
        
        
    }
    @ViewBuilder
    func FileView()->some View{
        
        
        VStack(alignment: .leading, spacing: 13) {
            
            
              Text("Recent Files")
                .font(.title.bold())
                .foregroundColor(.white)
            
            
          
                
                HStack{
                    
                    ForEach(["File Name","Date","Size"],id: \.self){type in
                    Text(type)
                        .italic().bold()
                        .frame(maxWidth: .infinity,alignment:type == "File Name" ? .leading :  .center)
                }
                    
                  
            }
            
            Rectangle()
                .fill(.white.opacity(0.2))
                .frame(height: 1)
                .padding(.horizontal,-15)
            
            
            ForEach(sampleFiles){file in
                
                
                HStack{
                    
                    Image(file.fileIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    
                    
                    Text(file.fileType)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Text(file.fileDate)
                        .frame(maxWidth: .infinity,alignment: .center)
                    
                    Text(file.fileSize)
                        .frame(maxWidth: .infinity,alignment: .center)
                }
                .font(.system(size:props.isIpad ? 18 : 15))
                Rectangle()
                    .fill(.white.opacity(0.2))
                    .frame(height: 1)
                    .padding(.horizontal,-15)
                
                
                
            }
         
            
            
        }
          .frame(maxWidth: .infinity,alignment: .leading)
          .padding()
          .background{
           
              RoundedRectangle(cornerRadius: 10, style: .continuous)
                  .fill(Color("Overlay"))
          }
    }
    
    @ViewBuilder
    func OnlineStorageView()->some View{
        
        let count = (props.isIpad && !props.isSprit ? 1 : 2)
        
        
        ScrollView(count == 1 ? .horizontal : .vertical, showsIndicators: false) {
            DyanaminLazyContent(count: count) {
                
                
                ForEach(sampleStorages){storage in
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        HStack{
                            
                            Image(storage.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(10)
                                .background{
                                 
                                  Circle()
                                        .fill(storage.progressColor.opacity(0.1))
                                }
                            
                            Spacer(minLength: 5)
                            
                            
                            Button {
                                
                            } label: {
                                
                                  Image(systemName: "ellipsis")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .rotationEffect(.init(degrees: -90))
                            }

                            
                        }
                        
                        Text(storage.title)
                            .font(.caption.bold())
                        
                        
                        GeometryReader{proxy in
                            
                             let size = proxy.size
                            
                            ZStack(alignment: .leading) {
                                
                                Capsule()
                                    .fill(.white.opacity(0.1))
                                
                                Capsule()
                                    .fill(storage.progressColor)
                                    .frame(width:storage.progress * size.width)
                            }
                            .frame(height: 2)
                        }
                        
                        
                        HStack{
                            
                            Text("\(storage.fileCount) Files")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                            
                            
                            Spacer()
                            
                            
                            Text(storage.maxSize)
                                .font(.callout)
                        }
                        
                    }
                    .padding()
                    .background{
                     
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("Overlay"))
                    }
                }
                
            }
            
            
        }
        
        
    }
    @ViewBuilder
    func DyanaminLazyContent<Content : View>(count : Int,content : @escaping()->Content)->some View{
        
        let columns1 = Array(repeating: GridItem(.flexible(),spacing: 10), count: 1)
        
        let columns2 = Array(repeating: GridItem(.flexible(),spacing: 10), count: 2)
        
        
        
        if count == 1{
            
            LazyHGrid(rows: columns1, spacing: 13) {
                
                content()
            }
            
        }
        else{
            
            LazyVGrid(columns: columns2, spacing: 13) {
                
                content()
            }
            
        }
        
    }
    @ViewBuilder
    func TopNavBar()->some View{
        
        HStack{
            
            if props.isIpad && !props.isSprit{
                
                
                Text("DashBoad")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.white)
            }
            else{
                
                
                Button {
                    withAnimation(.easeInOut){showSlideBar = true}
                } label: {
                    
                    
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.white)
                }

            }
            
       
            HStack{
                
                
                TextField("Search", text: .constant(""))
                    .padding(.leading,15)
                
                Button {
                    
                } label: {
                    
                    
                    Image(systemName: "magnifyingglass")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(10)
                        .background{
                         
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("Blue"))
                        }
                    

                }
                
            }
            .background{
             
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("Overlay"))
            }
            .frame(width: 220)
            .frame(maxWidth: .infinity,alignment: .trailing)
            
            
            Button {
                
            } label: {
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }


        }
        
        
        
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
