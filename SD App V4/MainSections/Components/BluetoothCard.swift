//
//  BluetoothCard.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/31/24.
//

import SwiftUI

struct BluetoothCard: View {
    
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel
    
    var body: some View {
        ZStack {
            
            HStack {
                
                testView
    
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.fromNeuroKit)
            .cornerRadius(20)
        }
    }
    
    private var searchingView: some View {
        Group {
            VStack(alignment: .leading) {
                Text("Searching...")
                    .font(Font.custom("Quicksand-Semibold", size: 20))
                    .padding(.horizontal)
                
                // Conditionally show LottiePlusView or the list of devices
                if bluetoothViewModel.peripheralNames.isEmpty && bluetoothViewModel.isSearching {
                    // Show LottiePlusView when no devices are found and searching is true
                    LottiePlusView(name: Constants.BluetoothLoading, loopMode: .loop)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                    
                } else {
                    // Show the list of peripherals when available
                    List(bluetoothViewModel.peripheralNames.indices, id: \.self) { index in
                        HStack {
                            
                            Text(bluetoothViewModel.peripheralNames[index])
                            
                            Spacer()
                            Button("Connect") {
                                bluetoothViewModel.connectToPeripheral(at: index)
                                
                                // Consider moving this to a function within BluetoothViewModel
                                // that gets called upon a successful connection.
                            }
                        }
                    }
                    .background(Color.clear)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
    }
    
    private var testView: some View {
        Group {
            ScrollView {
                ForEach(bluetoothViewModel.peripheralNames.indices, id: \.self) { index in
                    HStack {
                        Text(bluetoothViewModel.peripheralNames[index])
                        Spacer()
                        Button("Connect") {
                            bluetoothViewModel.connectToPeripheral(at: index)
                        }
                    }
                    .padding()
                }
            }

        }
    }
    
    // Device not connected
    private var notConnetedView: some View {
        Group {
            Text("Not connected")
                .font(Font.custom("Quicksand-Semibold", size: 20))
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                bluetoothViewModel.isSearching = true
                bluetoothViewModel.startScanning()
                print("Search button pressed. isSearching is \(bluetoothViewModel.isSearching)")
            }, label: {
                Text("Search")
            })
            .font(Font.custom("Quicksand-SemiBold", size: 18))
            .foregroundColor(Color.primary)
            .padding(15)
            .cornerRadius(20)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.red.opacity(0.9), lineWidth: 2)
                    // Apply glow effect
                    .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 0)
                    .shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 0)
                    .shadow(color: Color.red.opacity(0.3), radius: 30, x: 0, y: 0)
                    .shadow(color: Color.red.opacity(0.3), radius: 40, x: 0, y: 0)
            )
            .padding(.horizontal)
        }
    }
}

#Preview {
    BluetoothCard()
}
