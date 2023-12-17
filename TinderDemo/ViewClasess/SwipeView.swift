//
//  SwipeView.swift
//  TinderDemo
//
//  Created by lkumawat on 16/12/23.
//

import SwiftUI

// Design Card View
struct SwipeView: View {
    @Binding var profiles: [ProfileCardModel]
    var onSwiped: (ProfileCardModel, Bool) -> ()
    @State var offset: CGFloat = 0
    @State var endSwipe: Bool = false
    @GestureState var isDragging = false
    var body: some View {
        VStack{
            Spacer()
            VStack{
                ZStack{
                    Text("no-more-profiles").font(.title3).fontWeight(.medium).foregroundColor(Color(UIColor.systemGray)).multilineTextAlignment(.center)
                    ForEach(profiles.indices, id: \.self){ index  in
                        let model: ProfileCardModel = profiles[index]
                        StackCardView(model: model, indx: getIndex(profile: model), profiles: $profiles)

                    }
                }
            }.padding()

        }
    }
    
    func getIndex(profile:ProfileCardModel) -> Int {
        let index = profiles.firstIndex { model in
            return model.userId == profile.userId
        }
        return index ?? 0
    }
}
// Design a single Card and animation for swipe 
struct StackCardView : View {
    let model: ProfileCardModel
    let indx : Int
    @State var offset: CGFloat = 0
    @State var endSwipe: Bool = false
    @GestureState var isDragging = false
    @Binding var profiles: [ProfileCardModel]
    @State private var flipped: Bool = false

    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            let topOffset = (indx <= 2 ? indx : 2) * 15
            ZStack(alignment: .bottom) {
                if !flipped {
                    // Card front view
                    Image(uiImage: model.pictures.first!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width,height: size.height)
                        .cornerRadius(15)
                        .offset(y:CGFloat(topOffset))
                    VStack{
                        HStack(alignment: .firstTextBaseline){
                            Text(model.name).font(.largeTitle).fontWeight(.semibold)
                            Text("\(model.age)").font(.title).fontWeight(.medium)
                            Spacer()
                        }.foregroundGradient(colors: [Color.white])
                            
                    }.padding()
                } else {
                    // Card Back view
                    VStack{
                        Text("Name : \(model.name)")
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        Text("User ID :- \(model.userId)")
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        Text("Age : \(model.age)")
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        Text("Image sizes vary widely, from single-pixel PNG files to digital photography images with millions of pixels. Because device sizes also vary, apps commonly need to make runtime adjustments to image sizes so they fit within the visible user interface. SwiftUI provides modifiers to scale, clip, and transform images to fit your interface perfectly.\n\nScale a large image to fit its container using resizing\n\nConsider the image Landscape_4.jpg, a photograph with the dimensions 4032 x 3024, showing a water wheel, the surrounding building, and the sky above.")
                            .frame(width: getRect().size.width-60)
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        Spacer()
                    }.background(Color(UIColor.brown))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width,height: size.height)
                        .cornerRadius(15)
                        .offset(y:CGFloat(topOffset))
                }
                
            }.frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.center)
                .onTapGesture {
                    flipped.toggle()
                }
                
            
        }.offset(x:offset)
            .rotationEffect(.init(degrees: getRotation(angle: 8)))
            .contentShape(Rectangle().trim(from: 0.0, to: endSwipe ? 0:1))
            .rotation3DEffect(
                flipped ? Angle(degrees: 180) : .zero,
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(.default, value: flipped)
            .gesture(
                DragGesture()
                    .updating($isDragging, body: { value, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        let translation = value.translation.width
                        offset = (isDragging ? translation :.zero)
                    })
                    .onEnded({ value in
                        let width = getRect().width - 50
                        let translation = value.translation.width
                        let checkingStatus = (translation > 0 ? translation : -translation)
                        
                        withAnimation {
                            if checkingStatus > (width/2) {
                                offset = (translation > 0 ? width: -width) * 2
                                endSwipe = true
                            } else {
                                offset = .zero
                            }
                        }
                    })
            )
    }
    func getRotation(angle:Double) -> Double {
        let rotation = (offset / (getRect().width - 50)) * angle
        return rotation
    }
    
    func endSwipeAction()  {
        withAnimation(.none) {
            endSwipe = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            if let _ = profiles.first {
                let _ = withAnimation {
                    profiles.removeFirst()
                }
            }
        }
    }
    
}

