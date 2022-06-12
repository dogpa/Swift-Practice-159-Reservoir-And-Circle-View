//
//  ContentView.swift
//  Swift Practice 159 Reservoir And Circle View
//
//  Created by Dogpa's MBAir M1 on 2022/6/12.
//

import SwiftUI

struct ContentView: View {
    //自定義的ReservoirViewModel
    @StateObject var reservoirVM = ReservoirViewModel()
    
    var body: some View {
        VStack {
            //透過ScrollView放入ForEach
            //帶入$reservoirVM.reservoirArray傳給每一個foreach顯示自定義的CirclePercentageView
            //順便傳入兩個指定的參數分別為蓄水量百分比PercentageOfStorage及水庫編號StationNo
            ScrollView() {
                ForEach($reservoirVM.reservoirArray, id: \.self) { item in
                    HStack{
                        CirclePercentageView(percentage: item.PercentageOfStorage, reservoirNo: item.StationNo)
                    }
                }
            }
        }
        .onAppear {
            //顯示時執行抓取水利署API的資料
            reservoirVM.fetchCurrentReservoirPersentage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
