import Foundation
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    private var targetPeripheral: CBPeripheral?
    
    @Published var peripheralNames: [String] = []
    @Published var isConnected: Bool = false
    @Published var isSearching: Bool = true
    
    private var SERVICE_UUID: String = "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
    private var OMEGA1_UUID: String = "e0a994b4-dbbc-483d-b331-ecff32e12f3a"
    private var OMEGA2_UUID: String = "bf078597-f84e-40f0-b16e-519d2f73e9e7"
    
    var omega1Characteristic: CBCharacteristic?
    var omega2Characteristic: CBCharacteristic?
    
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
            peripheral.discoverCharacteristics([CBUUID(string: OMEGA1_UUID), CBUUID(string: OMEGA2_UUID)], for: service)
        }
    }

    // Adjust this function to store both omega1Characteristic and omega2Characteristic when discovered
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: OMEGA1_UUID) {
                self.omega1Characteristic = characteristic
            } else if characteristic.uuid == CBUUID(string: OMEGA2_UUID) {
                self.omega2Characteristic = characteristic
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error reading characteristic: \(error.localizedDescription)")
            return
        }
        
        guard let value = characteristic.value else {
            print("\(characteristic.uuid) Value is null")
            return
        }
        
        if characteristic.uuid == CBUUID(string: OMEGA1_UUID) {
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
        }
    }

}

extension BluetoothViewModel {
    
    // Connect to a peripheral at a given index in the peripherals array
    func connectToPeripheral(at index: Int) {
        let peripheral = peripherals[index]
        self.targetPeripheral = peripheral
        centralManager?.stopScan()
        centralManager?.connect(peripheral, options: nil)
    }
    
    // TODO: Does not seem to be working?
    func disconnectFromPeripheral() {
        guard let peripheral = targetPeripheral else { return }
        self.targetPeripheral = nil
        
        centralManager?.cancelPeripheralConnection(peripheral)
        // You might want to perform additional cleanup here
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
