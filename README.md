# Smart Laser Cat Toy

**Smart Laser Cat Toy** is an interactive iOS-based application that controls a laser toy for pets. This project integrates various sensors and communication protocols to create a fun and engaging experience for cats, allowing users to control the laser via a mobile app.

## Demo
<img src="Assets/App%20Demo/App%20Demo.gif" width="350px" alt="App Demo GIF" />

## Key Features
- **Full-Stack iOS App**: Developed in **Swift**, providing a seamless user interface for controlling the laser toy.
- **Hardware Integration**: Syncs with **motion sensors**, **color detection**, and **laser targeting systems** using **ESP32** and **Raspberry Pi**.
- **Bluetooth Low Energy (BLE) Communication**: Enables real-time, low-latency communication between the mobile app and the microcontroller.
- **Firebase Authentication**: Ensures secure user login and data management.

---

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Practical Demo](#practical-demo)


---

## Introduction
The **Smart Laser Cat Toy** allows pet owners to not only interact with their pets through a remotely controlled laser but also to prioritize their cat’s overall well-being. The iOS app serves as the control interface for the laser toy, while the hardware manages the laser’s movement and sensor data, including motion detection and color recognition, to provide dynamic and engaging play. In addition to the interactive features, the app also functions as a comprehensive cat care hub. Pet owners can create and update a personalized cat profile, track basic health information, and monitor their cat’s favorite play patterns. The app even logs how long each pattern has been active and tracks total daily playtime for the week, ensuring a balanced and enjoyable experience for your pet.

## Features
- **iOS App Development**:
   - Developed in **Swift** with a user-friendly interface that allows easy control over the laser toy.
   - Supports **16 different play modes**, enabling varied and engaging play sessions for pets based on motion detection and color tracking.
  
- **Hardware Control**:
   - Real-time synchronization of **motion sensors** and laser movements using **ESP32** and **Raspberry Pi** to dynamically respond to the cat's position and behavior.
  
- **Bluetooth Low Energy (BLE)**:
   - Enables efficient and reliable real-time communication between the app and the hardware, ensuring smooth interaction without delays.
  
- **Health & Play Tracking**:
   - Track your cat’s favorite play patterns and monitor total daily playtime to ensure a healthy balance of exercise and rest.
  
- **Authentication & Security**:
   - Secured by **Firebase Authentication**, ensuring user data, including cat health profiles and play history, is safely stored.


## Technologies Used
- **Languages**: Swift, Python, C
- **Frameworks & Libraries**: SwiftUI, OpenCV, Firebase
- **Hardware**: ESP32, Raspberry Pi, Fresnel Lens, Lasers
- **Communication Protocols**: Bluetooth Low Energy (BLE)

## Practical Demo
![App Demo GIF](Assets/Practical%20Demo/Practical%20Demo.gif)
The practical demo shows a user selecting a play pattern for the laser toy via the app, which then communicates the selected pattern to the device using Bluetooth Low Energy (BLE). The laser toy responds accordingly, following the chosen pattern in real-time, ensuring an interactive and engaging experience for the pet. This demo highlights the seamless interaction between the user, the app, and the hardware, emphasizing the system’s responsiveness and user-friendly design.

