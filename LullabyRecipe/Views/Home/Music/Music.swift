//
//  Music.swift
//  LullabyRecipe
//
//  Created by hyunho lee on 2022/05/23.
//

import SwiftUI
import AVKit

struct MusicView: View {
    
    @StateObject var viewModel = MusicViewModel()
    @State var animatedValue : CGFloat = 55
    @State var maxWidth = UIScreen.main.bounds.width / 2.2
    @State var showVolumeControl: Bool = false
    
    var data: MixedSound
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            ColorPalette.background.color.ignoresSafeArea()
            
            VStack {
                MusicInfo()
                
                Divider()
                
                VStack(spacing: 20) {
                    Divider()
                        .background(.white)
                        .padding(.horizontal, 20)
                    SingleSong(song: data.baseSound!)
                    
                    Divider()
                        .background(.white)
                        .padding(.horizontal, 20)
                    SingleSong(song: data.melodySound!)
                    
                    Divider()
                        .background(.white)
                        .padding(.horizontal, 20)
                    SingleSong(song: data.naturalSound!)
                }
                
                
                Spacer()
                
                VolumeControlButton()
            }
            .onAppear {
                viewModel.fetchData(data: data)
            }
            .onDisappear {
                viewModel.stop()
            }
        }
        .sheet(isPresented: $showVolumeControl,
               content: {
            VolumeControl(showVolumeControl: $showVolumeControl,
                          baseVolume: (data.baseSound?.audioVolume)!,
                          melodyVolume: (data.melodySound?.audioVolume)!,
                          naturalVolume: (data.naturalSound?.audioVolume)!,
                          data: data)
        })
        .navigationBarTitle(Text(""),
                            // Todo :- edit 버튼 동작 .toolbar(content: { Button("Edit") { }}) }}
                            displayMode: .inline)
        
    }
    
    @ViewBuilder
    func MusicInfo() -> some View {
        HStack(alignment: .top) {
            if let thumbNailImage = UIImage(named: data.imageName) {
                Image(uiImage: thumbNailImage)
                    .resizable()
                    .frame(width: 156,
                           height: 156)
                    .cornerRadius(15)
            } else {
                // 문제시 기본이미지 영역
            }
            
            VStack(alignment: .leading) {
                WhiteTitleText(title: data.name)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.white)
                Spacer()
                MusicControlButton()
            }
            .padding(.horizontal)
            .frame(height: 156)
            
            Spacer()
        }
        .padding(20)
    }
    
    @ViewBuilder
    func MusicTitle() -> some View {
        HStack {
            Text(data.name)
                .font(.title)
                .bold()
            
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    func MusicControlButton() -> some View {
        Button(action: {
            viewModel.play()
            viewModel.isPlaying.toggle()
        }, label: {
            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       maxHeight: 50)
                .background(ColorPalette.buttonBackground.color)
                .foregroundColor(.white)
                .cornerRadius(12)
            
//            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
//                .foregroundColor(.black)
//                .frame(width: 55,
//                       height: 55)
//                .background(Color.white)
//                .clipShape(Circle())
        })
        //        }
        //        .frame(width: maxWidth,
        //               height: maxWidth)
        //        .padding(.top,30)
    }
    
    @ViewBuilder
    func SingleSong(song: Sound) -> some View {
        HStack {
            Image(song.imageName)
                .resizable()
                .frame(width: 80,
                       height: 80)
                .cornerRadius(24)
            VStack {
                Text(song.name)
                    .foregroundColor(.white)
                    .font(Font.system(size: 17))
                    .bold()
                // TODO: - type
            }
            // TODO: - X button
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func VolumeControlButton() -> some View {
        Button {
            showVolumeControl = true
            viewModel.stop()
        } label: {
            Text("Volume Control")
                .bold()
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       maxHeight: 50)
                .background(ColorPalette.buttonBackground.color)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 37)
    }
}

struct Music_Previews: PreviewProvider {
    static var previews: some View {
        let dummyMixedSound = MixedSound(id: 3,
                                         name: "test4",
                                         baseSound: dummyBaseSound,
                                         melodySound: dummyMelodySound,
                                         naturalSound: dummyNaturalSound,
                                         imageName: "r1")
        MusicView(data: dummyMixedSound)
    }
}

