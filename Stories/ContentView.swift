//
//  ContentView.swift
//  Stories
//
//  Created by Carlos Henrique on 13/05/21.
//

import SwiftUI
import KingfisherSwiftUI

public struct ContentView: View {
    var imageNames:[String] = ["https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg", "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg", "https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg","https://cdn.fakercloud.com/avatars/angelcreative_128.jpg","https://cdn.fakercloud.com/avatars/GavicoInd_128.jpg"]
    
    @ObservedObject var storyTimer: StoryTimer = StoryTimer(items: 7, interval: 3.0)

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
              ZStack(alignment: .top) {
                  KFImage(URL(string: self.imageNames[Int(self.storyTimer.progress)]))
                      .resizable()
                      .edgesIgnoringSafeArea(.all)
                      .scaledToFill()
                      .frame(width: geometry.size.width, height: nil, alignment: .center)
                      .animation(.none)
                  HStack(alignment: .center, spacing: 4) {
                      ForEach(self.imageNames.indices) { x in
                        LoadingRectangle(progress: min( max( (CGFloat(self.storyTimer.progress) - CGFloat(x)), 0.0) , 1.0) )
                              .frame(width: nil, height: 2, alignment: .leading)
                              .animation(.linear)
                      }
                  }.padding()
                
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: -1)
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: 1)
                    }
                }
              }
              .onAppear { self.storyTimer.start() }
//              .onDisappear { self.storyTimer.cancel() }
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
