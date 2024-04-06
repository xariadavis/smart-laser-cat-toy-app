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
            
            // Remove HStack
            HStack {
                
                if !bluetoothViewModel.isSearching && !bluetoothViewModel.isConnected {
                    notConnectedView
                } else if bluetoothViewModel.isSearching && !bluetoothViewModel.isConnected {
                    SearchingView()
                } else {
                    connectedView
                }
    
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.fromNeuroKit)
            .cornerRadius(20)
        }
    }
    
    // Device not connected
    private var notConnectedView: some View {
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
    
    // Has it's own view since I use it in other places
    var searchingView: some View {
        Group {
            VStack(alignment: .leading) {
                Text("Searching...")
                    .font(Font.custom("Quicksand-Semibold", size: 20))
                    .padding(.horizontal)
                
                // Conditionally show LottiePlusView or the list of devices
                if bluetoothViewModel.peripheralNames.isEmpty && bluetoothViewModel.isSearching {
                    // Show LottiePlusView when no devices are found and searching is true
                    
                    LottiePlusView(name: Constants.BluetoothLoading, loopMode: .loop)
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 200, maxHeight: 250)
                
                } else {
                    
                    ScrollView {
                        ForEach(bluetoothViewModel.peripheralNames.indices, id: \.self) { index in
                            HStack {
                                Text(bluetoothViewModel.peripheralNames[index])
                                    .font(Font.custom("Quicksand-Regular", size: 18))
                                Spacer()
                                
                                Button {
                                    bluetoothViewModel.connectToPeripheral(at: index)
                                } label: {
                                    Text(bluetoothViewModel.connectingPeripheralIndex == index ? "Connecting..." : "Connect")
                                        .font(Font.custom("Quicksand-Regular", size: 18))
                                        .foregroundColor(Color.orange)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
        }
    }
    
    private var connectedView: some View {
        Group {
            
            VStack {
                
                HStack {
                    Text("Connected")
                        .font(Font.custom("Quicksand-Semibold", size: 20))
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("\(bluetoothViewModel.peripheralNames[0])")
                        .font(Font.custom("Quicksand-Semibold", size: 20))
                        .padding(.horizontal)
                    
                }
                
                Button {
                    bluetoothViewModel.disconnectFromPeripheral()
                    bluetoothViewModel.isSearching = false
                    bluetoothViewModel.isConnected = false
                    bluetoothViewModel.connectingPeripheralIndex = nil
                } label: {
                    Text("Disconnect")
                }

                
            }
        }
    }
}

struct SearchingView: View {
    @EnvironmentObject var bluetoothViewModel: BluetoothViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Searching...")
                .font(Font.custom("Quicksand-Semibold", size: 20))
                .padding(.horizontal)
            
            // Conditionally show LottiePlusView or the list of devices
            if bluetoothViewModel.peripheralNames.isEmpty && bluetoothViewModel.isSearching {
                LottiePlusView(name: Constants.BluetoothLoading, loopMode: .loop)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 200, maxHeight: 250)
            } else {
                ScrollView {
                    ForEach(bluetoothViewModel.peripheralNames.indices, id: \.self) { index in
                        HStack {
                            Text(bluetoothViewModel.peripheralNames[index])
                                .font(Font.custom("Quicksand-Regular", size: 18))
                            Spacer()
                            Button {
                                bluetoothViewModel.connectToPeripheral(at: index)
                            } label: {
                                Text(bluetoothViewModel.connectingPeripheralIndex == index ? "Connecting..." : "Connect")
                                    .font(Font.custom("Quicksand-Regular", size: 18))
                                    .foregroundColor(Color.orange)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
    }
} 


#Preview {
    BluetoothCard()
}
