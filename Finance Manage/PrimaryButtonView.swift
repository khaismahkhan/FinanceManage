//
//  PrimaryButtonView.swift
//  TheProject
//
//

import SwiftUI

struct PrimaryButtonView: View {
    var title:String
    var body: some View {
        
        HStack{
            Text(title.uppercased())
                .tracking(1)
                .italic()
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.white)
                .padding(.vertical,8)
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .bottom, endPoint: .top).cornerRadius(10)
        )
        .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
    }
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(title: "Title")
    }
}
