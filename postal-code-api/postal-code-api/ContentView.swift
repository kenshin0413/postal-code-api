//
//  ContentView.swift
//  postal-code-api
//
//  Created by miyamotokenshin on R 7/06/26.
//

import SwiftUI

struct Address: Identifiable, Decodable {
    //  Identifiableにはidが必要らしい
    var id: String { zipcode + address1 + address2 + address3 }
    var zipcode: String
    var address1: String
    var address2: String
    var address3: String
    var kana1: String
    var kana2: String
    var kana3: String
    var prefcode: String
}

struct ApiResponse: Decodable {
    let results: [Address]?
    let status: Int
}

struct ContentView: View {
    @State private var zipcode = ""
    @State private var addresses: [Address] = []
    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("郵便番号を入力してください", text: $zipcode)
                        .keyboardType(.numberPad)
                    Button("検索") {
                        search()
                    }
                }
                
                ForEach(addresses) { a in
                    LabeledContent("address1") {
                        Text(a.address1)
                    }
                    
                    LabeledContent("address2") {
                        Text(a.address2)
                    }
                    
                    LabeledContent("address3") {
                        Text(a.address3)
                    }
                    
                    LabeledContent("kana1") {
                        Text(a.kana1)
                    }
                    
                    LabeledContent("kana2") {
                        Text(a.kana2)
                    }
                    
                    LabeledContent("kana3") {
                        Text(a.kana3)
                    }
                    
                    LabeledContent("prefcode") {
                        Text(a.prefcode)
                    }
                    
                    LabeledContent("zipcode") {
                        Text(a.zipcode)
                    }
                }
            }
        }
    }
    func search() {
        let cleanedZipcode = zipcode.trimmingCharacters(in: .whitespacesAndNewlines).filter { $0.isNumber }
        let urlStr = "https://zipcloud.ibsnet.co.jp/api/search?zipcode=\(cleanedZipcode)"
        guard let url = URL(string: urlStr) else {return}
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let res = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    // 200は成功 そしたらaddressに結果を格納
                    if res.status == 200, let results = res.results {
                        self.addresses = results
                    }
                }
            }
        }
    }
}
