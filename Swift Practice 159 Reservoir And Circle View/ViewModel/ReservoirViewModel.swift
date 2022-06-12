//
//  ReservoirViewModel.swift
//  Swift Practice 159 Reservoir And Circle View
//
//  Created by Dogpa's MBAir M1 on 2022/6/12.
//

import Foundation

final class ReservoirViewModel : ObservableObject {
    
    //被觀察物件，水庫資料的Array
    @Published var reservoirArray = [ReservoirInfo]()
    
    
    /// 抓取水利署API的Function
    /// 如果抓取成功將抓到的資料存入reservoirArray內
    /// 並且透過DispatchQueue.main.async完成(因為跟顯示有關)
    func fetchCurrentReservoirPersentage () {
        
        //水利署API網址
        guard let reservoirURL = URL(string: "https://fhy.wra.gov.tw/WraApi/v1/Reservoir/RealTimeInfo") else {return}
        
        let task = URLSession.shared.dataTask(with: reservoirURL) { [weak self] data, _ , error in
            guard let data = data, error == nil else {return}
            do {
                let reservoirInfo = try JSONDecoder().decode([ReservoirInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.reservoirArray = reservoirInfo
                    //print(self?.reservoirArray)
                }
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
