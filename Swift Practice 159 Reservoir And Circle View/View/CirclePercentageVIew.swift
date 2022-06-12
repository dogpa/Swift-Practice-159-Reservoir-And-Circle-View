//
//  CirclePercentageVIew.swift
//  Swift Practice 159 Reservoir And Circle View
//
//  Created by Dogpa's MBAir M1 on 2022/6/12.
//

import SwiftUI

struct CirclePercentageView: View {
    
    //因有些水庫沒有蓄水量百分比故percentage為optional
    @Binding var percentage : Double?
    
    //水庫編號
    @Binding var reservoirNo : String
    
    var body: some View {
        HStack{
            ZStack {
                //如果有蓄水百分比則顯示圓環圖
                if percentage != nil {
                    
                    //底層灰色的圓環圖透過stroke變成圓環opacity變成半透明灰
                    Circle()
                        .stroke(Color.gray, lineWidth: 17)
                        .opacity(0.3)
                    
                    //蓋上去的百分比圖透過trim保留指定的百分比顯示在畫面
                    //rotationEffect判斷從哪邊開始畫圖270為正上方0為右側
                    //透過overlay顯示水庫名稱與目前蓄水量
                    Circle()
                        .trim(from: 0, to: percentage!/100)
                        .stroke(checkColorInPersentage(percentage: percentage!), lineWidth: 17)
                        .rotationEffect(.degrees(270))
                        .overlay(
                            Text("\(reservoirDict["\(reservoirNo)"] ?? "")\n\(String(format: "%.2f", percentage!)) %")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        )
                }else {
                    //沒有百分比則顯示未有百分比資料
                    Text("\(reservoirDict["\(reservoirNo)"] ?? "")\n未有百分比資料")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(20)
            .frame(height: 230)
        }
    }
}


/// 判斷目前水庫百分比回傳不同的顏色
/// - Parameters:
///      - percentage: 水庫蓄水量百分比
/// - Returns: Color
func checkColorInPersentage (percentage: Double) -> Color {
    var color : Color
    switch percentage {
    case 0..<20 : color = .black
    case 20..<40 : color = .red
    case 40..<60 : color = .orange
    case 60..<80 : color = .green
    case 80..<110 : color = .cyan
    default : color = .cyan
    }
    return color
}

//struct CirclePercentageVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        CirclePercentageView()
//    }
//}
