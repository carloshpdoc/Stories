//
//  ContentView.swift
//  Stories
//
//  Created by Carlos Henrique on 13/05/21.
//

import SwiftUI
import KingfisherSwiftUI

public struct ContentView: View {

    public init() { }

    public var body: some View {
            Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var imageNames:[String] = ["https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg", "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg", "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg"]


public struct Home: View {
    
    public init() {}
    
    @State var show = false
    @State var current : Post!
    
    @State var data = [
        Post(id: 0, name: "iJustine", url: "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg", seen: false, proPic: "https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg", loading: false),
       
        Post(id: 1, name: "iJustine", url: "https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg", seen: false, proPic: "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg", loading: false),
        
        Post(id: 2, name: "iJustine" , url: "https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg", seen: false, proPic: "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg", loading: false),
        
        Post(id: 3, name: "test", url: "https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg", seen: false, proPic: "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg", loading: false),
        
        Post(id: 4, name: "test", url: "https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg", seen: false, proPic: "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg", loading: false)
    ]
    
    public var body: some View {
        
        ZStack{
            
            Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
            
            ZStack{
                
                VStack{
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 22){
                            
                            Button(action: {
                                
                            }) {
                                
                                VStack(spacing: 8){
                                    
                                    ZStack(alignment: .bottomTrailing){
                                        
                                        let url = URL(string: data[0].proPic)
                                        KFImage(url)
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .clipShape(Circle())
                                        
                                        
                                        Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .offset(x: 6)
                                    }
                                    
                                    Text("You")
                                        .foregroundColor(.black)
                                }
                            }
                            
                            ForEach(0..<self.data.count) { i in
                                
                                VStack(spacing: 8){
                                    
                                    ZStack{
                                        let url = URL(string: self.data[i].proPic)
                                        KFImage(url)
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .clipShape(Circle())
                                        
                                        if !self.data[i].seen{
                                            
                                            Circle()
                                            .trim(from: 0, to: 1)
                                                .stroke(AngularGradient(gradient: .init(colors: [.red,.orange,.red]), center: .center), style: StrokeStyle(lineWidth: 4, dash: [self.data[i].loading ? 7 : 0]))
                                            .frame(width: 74, height: 74)
                                            .rotationEffect(.init(degrees: self.data[i].loading ? 360 : 0))
                                        }

                                    }
                                    
                                    Text(self.data[i].name)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                }
                                .frame(width: 75)
                                .onTapGesture {
                                    
                                    withAnimation(Animation.default.speed(0.35).repeatForever(autoreverses: false)) {
                                        
                                        self.data[i].loading.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + (self.data[i].seen ? 0 : 1.2)) {
                                            
                                            self.current = self.data[i]
                                            
                                            withAnimation(.default){
                                                
                                               self.show.toggle()
                                            }
                                            
                                            self.data[i].loading = false
                                            self.data[i].seen = true
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    
                    Spacer()
                    
                }
                
                if self.show {
                    
                    ZStack {
                        
                        Color.black.edgesIgnoringSafeArea(.all)
                        
                        ZStack(alignment: .topLeading) {
                            
                            GeometryReader { _ in
                                let url = URL(string: self.current.url)
                                VStack{
                                    KFImage(url)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                }
                            }
                            
                            VStack(spacing: 15) {
                                
                                Loader(show: self.$show)
                                
                                HStack(spacing: 15) {
                                    let url = URL(string: self.current.proPic)
                                    KFImage(url)
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                    .clipShape(Circle())
                                    
                                    Text(self.current.name)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                }
                                .padding(.leading)
                            }
                            .padding(.top)
                        }
                    }
                    .transition(.move(edge: .trailing))
                    .onTapGesture {
                        
                        self.show.toggle()
                    }
                }
            }
        }
    }
}

struct Loader: View {
    
    @State var width : CGFloat = 100
    @Binding var show : Bool
    var time = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var secs : CGFloat = 0
    
    var body: some View {
        
        ZStack(alignment: .leading){
            
            Rectangle()
                .fill(Color.white.opacity(0.6))
                .frame(height: 3)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: self.width, height: 3)
        }
        .onReceive(self.time) { (_) in
            
            self.secs += 0.1
            
            if self.secs <= 6 { //6 seconds.....
                
                let screenWidth = UIScreen.main.bounds.width
                
                self.width = screenWidth * (self.secs / 6)
            }
            else{
                
                self.show = false
            }

        }
    }
}

struct Post : Identifiable {
    
    var id : Int
    var name : String
    var url : String
    var seen : Bool
    var proPic : String
    var loading : Bool
}
