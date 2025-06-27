import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/kenshin/Desktop/postal-code-api/postal-code-api/postal-code-api/ContentView.swift", line: 1)
//
//  ContentView.swift
//  postal-code-api
//
//  Created by miyamotokenshin on R 7/06/26.
//

import SwiftUI
struct ContentView: View {
    @State var postal = ""
    var body: some View {
        VStack {
            TextField(__designTimeString("#8455_0", fallback: "郵便番号を入力してください"), text: $postal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
