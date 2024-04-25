import Foundation
import CoreBluetooth
import SwiftUI

class BluetoothViewModel: NSObject, ObservableObject, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    private var targetPeripheral: CBPeripheral?
    
    @Published var peripheralNames: [String] = []
    @Published var isConnected: Bool = false
    @Published var isSearching: Bool = false
    @Published var isReady: Bool = false
    @Published var connectingPeripheralIndex: Int? = nil
    @Published var currentColor: String = ""
    
    private var SERVICE_UUID: String = "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
    private var OMEGA1_UUID: String = "e0a994b4-dbbc-483d-b331-ecff32e12f3a"
    private var OMEGA2_UUID: String = "bf078597-f84e-40f0-b16e-519d2f73e9e7"
    private var READY_STATE: String = "88527841-2de6-45e6-a203-280bef44801d"
    private var COLOR_UUID: String = "8183a2d7-2f56-466a-a0af-93b0ba2c2f72"

    
    var omega1Characteristic: CBCharacteristic?
    var omega2Characteristic: CBCharacteristic?
    var colorCharacteristic: CBCharacteristic?
    var readyState: CBCharacteristic?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: [CBUUID(string: SERVICE_UUID)], options: nil)
        }
    }
    
    // Add this method to handle successful connection
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "unnamed device")")
        
        DispatchQueue.main.async {
            self.isConnected = true
        }
        
        peripheral.delegate = self
        
        // Now that you're connected, you can discover the peripheral's services
        // Replace nil with an array of service UUIDs if you're looking for specific services
        peripheral.discoverServices([CBUUID(string: SERVICE_UUID)])
    }
    
    // Disconnect
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from \(peripheral.name ?? "unnamed device")")
        
        DispatchQueue.main.async {
            self.isConnected = false
            self.isReady = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unnamed device")
            print(self.peripheralNames)
        }
    }
    
    // Adjust this function to discover both OMEGA1_UUID and OMEGA2_UUID characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services where service.uuid == CBUUID(string: SERVICE_UUID) {
            peripheral.discoverCharacteristics([CBUUID(string: OMEGA1_UUID), CBUUID(string: OMEGA2_UUID), CBUUID(string: READY_STATE), CBUUID(string: COLOR_UUID)], for: service)
        }
    }

    // Adjust this function to store both omega1Characteristic and omega2Characteristic when discovered
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: OMEGA1_UUID) {
                self.omega1Characteristic = characteristic
                print("self.omega1Characteristic = characteristic")
            } else if characteristic.uuid == CBUUID(string: OMEGA2_UUID) {
                self.omega2Characteristic = characteristic
            } else if characteristic.uuid == CBUUID(string: READY_STATE) {
                self.readyState = characteristic
                print("self.readyState = characteristicc")
                peripheral.setNotifyValue(true, for: self.readyState ?? characteristic)
            } else if characteristic.uuid == CBUUID(string: COLOR_UUID) {
                self.colorCharacteristic = characteristic
                print("Color characteristic set.")
            }
        }
        
        DispatchQueue.main.async {
            self.isReady = true
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Inside didUpdateValueFor")
        
        if let error = error {
            print("Error reading characteristic: \(error.localizedDescription)")
            return
        }
        
        guard let value = characteristic.value else {
            print("\(characteristic.uuid) Value is null")
            return
        } 
        
        if characteristic.uuid == CBUUID(string: READY_STATE) {
            print("READY CHAR:")

            // Assuming the ready state is a single byte representing a boolean
            let isDeviceReady = characteristic.value?.first == 0x01

            DispatchQueue.main.async {
                self.isReady = isDeviceReady
                
                print("isReady: \(isDeviceReady)")
                if isDeviceReady {
                    print("isReady2: \(isDeviceReady)")
                }
            }

            print("Device is ready: \(isDeviceReady)")
        } else if characteristic.uuid == CBUUID(string: OMEGA1_UUID) {
            print("OMEGA1 Value")
            let omega1Value = value.withUnsafeBytes { ptr -> Int32 in
                // Ensure there's enough data for an Int32
                guard ptr.count >= MemoryLayout<Int32>.size else {
                    print("OMEGA1 data size mismatch.")
                    return 0 // Consider how to handle this scenario.
                }
                return ptr.load(as: Int32.self)
            }
            print("OMEGA1 Value: \(omega1Value)")
        } else if characteristic.uuid == CBUUID(string: OMEGA2_UUID) {
            let omega2Value = value.withUnsafeBytes { ptr -> Int32 in
                // Ensure there's enough data for an Int32
                guard ptr.count >= MemoryLayout<Int32>.size else {
                    print("OMEGA2 data size mismatch.")
                    return 0 // Consider how to handle this scenario.
                }
                return ptr.load(as: Int32.self)
            }
            print("OMEGA2 Value: \(omega2Value)")
        } else if characteristic.uuid == CBUUID(string: COLOR_UUID) {
            // Handle COLOR_UUID characteristic
            if let colorString = String(data: value, encoding: .utf8) {
                print("Received Color: \(colorString)")
                DispatchQueue.main.async {
                    // Update UI or notify other parts of your app
                     self.currentColor = colorString
                    // Optionally, update UI elements or send notifications
                }
            } else {
                print("Failed to decode color string.")
            }
        }
    }

}

extension BluetoothViewModel {
    
    // Connect to a peripheral at a given index in the peripherals array
    func connectToPeripheral(at index: Int) {
        let peripheral = peripherals[index]
        self.targetPeripheral = peripheral
        self.connectingPeripheralIndex = index
        centralManager?.stopScan()
        centralManager?.connect(peripheral, options: nil)
    }
    
    // TODO: Does not seem to be working?
    func disconnectFromPeripheral() {
        guard let peripheral = targetPeripheral else { return }
        self.targetPeripheral = nil
        
        // TODO: Risk
        self.connectingPeripheralIndex = nil
        
        centralManager?.cancelPeripheralConnection(peripheral)
    }
    
    func readOmegaValues() {
        if let omega1Characteristic = self.omega1Characteristic {
            self.targetPeripheral?.readValue(for: omega1Characteristic)
            self.targetPeripheral?.setNotifyValue(true, for: omega1Characteristic)
        }
        
        if let omega2Characteristic = self.omega2Characteristic {
            self.targetPeripheral?.readValue(for: omega2Characteristic)
            self.targetPeripheral?.setNotifyValue(true, for: omega2Characteristic)
        }
    }

    func writeOmegaValues(omega1: Int32, omega2: Int32) {
        // Make mutable copies of the parameters
        var mutableOmega1 = omega1
        var mutableOmega2 = omega2
        
        // Prepare the data from Int32
        let omega1Data = Data(bytes: &mutableOmega1, count: MemoryLayout<Int32>.size)
        let omega2Data = Data(bytes: &mutableOmega2, count: MemoryLayout<Int32>.size)
        
        // Write to characteristics
        if let omega1Characteristic = self.omega1Characteristic {
            self.targetPeripheral?.writeValue(omega1Data, for: omega1Characteristic, type: .withResponse)
        }
        
        if let omega2Characteristic = self.omega2Characteristic {
            self.targetPeripheral?.writeValue(omega2Data, for: omega2Characteristic, type: .withResponse)
        }
    }
    
    func readColorValue() {
        if let colorCharacteristic = self.colorCharacteristic {
            self.targetPeripheral?.readValue(for: colorCharacteristic)
            self.targetPeripheral?.setNotifyValue(true, for: colorCharacteristic)
        }
    }
    
    func writeColorValue(color: String) {
        print("\(color)")
        if let colorData = color.data(using: .utf8),
           let colorCharacteristic = self.colorCharacteristic {
            self.targetPeripheral?.writeValue(colorData, for: colorCharacteristic, type: .withResponse)
        } else {
            print("Failed to encode color string to Data.")
        }
    }


    func startScanning() {
        if centralManager?.state == .poweredOn {
            DispatchQueue.main.async {
                self.isSearching = true
            }
            centralManager?.scanForPeripherals(withServices: [CBUUID(string: SERVICE_UUID)], options: nil)
        }
    }

    func stopScanning() {
        centralManager?.stopScan()
        DispatchQueue.main.async {
            self.isSearching = false
        }
    }
}
