//
//  LoadingRectangle.swift
//  Stories
//
//  Created by Carlos Henrique on 13/05/21.
//

import SwiftUI

struct LoadingRectangle: View {
    var progress: CGFloat

//    public init() {}

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .cornerRadius(5)

                Rectangle()
                    .frame(width: geometry.size.width * self.progress, height: nil, alignment: .leading)
                    .foregroundColor(Color.white.opacity(0.9))
                    .cornerRadius(5)
            }
        }
    }
}

struct LoadingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRectangle(progress: 3.0)
    }
}
