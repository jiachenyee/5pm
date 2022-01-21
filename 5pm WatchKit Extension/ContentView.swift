//
//  ContentView.swift
//  5pm WatchKit Extension
//
//  Created by Jia Chen Yee on 21/1/22.
//

import SwiftUI

struct ContentView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var is5PM = false
    
    
    var body: some View {
        VStack {
            if is5PM {
                Text("It's 5pm")
            } else {
                Text("It's not 5pm")
            }
        }
        .padding()
        .onReceive(timer) { input in
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            if hour == 17 && minutes == 0 {
                is5PM = true
            } else {
                is5PM = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
