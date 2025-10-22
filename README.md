# Computer-Aided-Design-F2024

This repository contains a series of hardware design projects implemented as part of the Computer-Aided Design (CAD) course in the Department of Electrical and Computer Engineering.
Each project explores neural network architectures and digital system design using Verilog HDL and ModelSim simulation.

- ## [CA1](https://github.com/MobinaMhr/Computer-Aided-Design-F2024/tree/main/CA1-Maxnet). MaxNet Neural Network
Implemented a competitive neural network (MaxNet) capable of identifying the neuron with the maximum activation value among all inputs.
The design includes multiple Processing Units (PUs) with ReLU activation, weight initialization, and parallel computations using datapath and controller modules.

- ## [CA3](https://github.com/MobinaMhr/Computer-Aided-Design-F2024/tree/main/CA3/trunk-P1/trunk) - Phase 1. Convolutional Neural Network (Layer 1)
Designed and implemented the first convolutional layer of a CNN using multiple Multiply-Accumulate (MAC) units operating in parallel.
Focused on convolutional filtering, feature map generation, and parameterized hardware design verified via ModelSim simulation.

- ## [CA3](https://github.com/MobinaMhr/Computer-Aided-Design-F2024/tree/main/CA3/trunk-P2/trunk) - Phase 2. Multi-Layer Convolutional Neural Network
Extended the single-layer CNN architecture to a multi-layer design by connecting multiple convolutional layers sequentially.
Implemented memory management between layers, parameterized processing elements (PEs), and verified multi-stage data flow using simulation outputs.


- ## Tools and Technologies
- Languages: Verilog HDL
- Simulation Environment: ModelSim
- Design Focus: Datapath, Controller, Memory Organization
- Concepts: Neural Networks, CNNs, Parallel Processing, Digital Hardware Design
