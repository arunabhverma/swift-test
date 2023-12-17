//
//  ContentView.swift
//  TinderDemo
//
//  Created by lkumawat on 16/12/23.
//

import SwiftUI

struct ContentView: View {
    @State var profiles: [ProfileCardModel] = [
        ProfileCardModel(userId: "1", name: "Michael Jackson", age: 50, pictures: [UIImage(named: "elon_musk")!]),
        ProfileCardModel(userId: "2", name: "Meryl Streep", age: 20, pictures: [UIImage(named: "Meryl_Streep")!]),
        ProfileCardModel(userId: "3", name: "Mories Mariya", age: 45, pictures: [UIImage(named: "elon_musk")!]),
        ProfileCardModel(userId: "4", name: "Michelle Pfeiffer", age: 50, pictures: [UIImage(named: "Michelle_Pfeiffer")!]),
        ProfileCardModel(userId: "5", name: "Jodie Foster", age: 34, pictures: [UIImage(named: "Jodie_Fo")!]),
        ProfileCardModel(userId: "6", name: "Julia Roberts", age: 60, pictures: [UIImage(named: "Julia_Rober")!]),
        ProfileCardModel(userId: "7", name: "Mariya Jyo", age: 55, pictures: [UIImage(named: "elon_musk")!]),
        ProfileCardModel(userId: "8", name: "Reyious", age: 44, pictures: [UIImage(named: "jeff_bezos")!]),
        ProfileCardModel(userId: "9", name: "Jackson", age: 33, pictures: [UIImage(named: "elon_musk")!]),
        ProfileCardModel(userId: "10", name: "Michael", age: 22, pictures: [UIImage(named: "jeff_bezos")!])
    ]
    var body: some View {
        VStack {
            SwipeView(
                profiles: $profiles,
                onSwiped: { userModel, hasLiked in
                    //homeViewModel.swipeUser(user: userModel, hasLiked: hasLiked)
                }
            )
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
