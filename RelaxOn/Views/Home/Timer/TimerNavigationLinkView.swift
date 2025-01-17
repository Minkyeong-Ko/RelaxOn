//
//  TimerNavigatinoView.swift
//  RelaxOn
//
//  Created by hyo on 2022/07/27.
//

import SwiftUI

struct TimerNavigationLinkView: View {
    
    @ObservedObject var timerManager = TimerManager.shared
    @State private var isPresentedByLockScreenWidget = false
    var body: some View {
        VStack(spacing: 6) {
            CustomNavigationLink(destination : TimerSettingView()) {
                label
            }
            .navigationBarTitle("CD LIBRARY") // 백버튼 텍스트 내용
            .navigationBarHidden(true)
            .buttonStyle(.plain)
            Divider()
                .background(.white)
            HStack() {
                Text("Relax on as much as you want")
                    .font(.callout)
                    .foregroundColor(.systemGrey1)
                Spacer()
            }
        }.padding(.horizontal, 20)
            .onOpenURL { url in
                self.isPresentedByLockScreenWidget = url == URL(string: "RelaxOn:///TimerSettingView")
            }
    }
    
    var label: some View {
        HStack(alignment: .bottom) {
            Text("Relax for")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.systemGrey1)
                .padding(.bottom, 2)
            Spacer()
            TimeTextView(remainedSecond : timerManager.getRemainedSecond())
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.relaxDimPurple)
            Image(systemName: "chevron.forward")
                .font(.system(size: 20))
                .foregroundColor(.relaxDimPurple)
                .opacity(0.6)
                .padding(.bottom, 8)
        }
    }
}

// MARK: - PREVIEW
struct TimerNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerNavigationLinkView()
            .background(.black)
        }
    }
}
