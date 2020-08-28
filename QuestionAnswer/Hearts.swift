//
//  Hearts.swift
//  QuestionAnswer
//
//  Created by slava bily on 27/8/20.
//

import SwiftUI

struct Hearts: View {
    
    let quantity: Int
    
    var body: some View {
        HStack {
            ForEach(0..<quantity) {_ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }   
}

struct Hearts_Previews: PreviewProvider {
    
    static var previews: some View {
        Hearts(quantity: 1)
    }
}
