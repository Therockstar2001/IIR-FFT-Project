## Reconfigurable IIR–FFT4 Digital Signal Processing Engine on FPGA

Design and Implementation of a Reconfigurable IIR–FFT4 DSP Engine on FPGA

# Project Overview

This project implements a reconfigurable Digital Signal Processing (DSP) engine on the Altera DE2-70 FPGA, integrating two core DSP algorithms:
Second-Order IIR Filter (Time-Domain Processing)
4-Point Radix-2 FFT (Frequency-Domain Processing)
A mode-select control allows real-time switching between IIR and FFT operation using on-board inputs. The system uses ROM-based input samples, enabling deterministic testing without external ADC hardware.

# Key Objectives
Demonstrate time-domain vs frequency-domain DSP on FPGA
Implement hardware-efficient DSP architectures using fixed-point arithmetic
Enable reconfigurable processing within a unified FPGA design
Validate functionality through simulation and hardware demo

# System Architecture
Major Blocks:
Input ROM (64 × 16-bit samples)
Second-Order IIR Filter Core
4-Point Radix-2 FFT Core
Mode Selection Logic
Output Interface (LEDs / Simulation)
The FPGA reads samples sequentially from ROM and routes them to either the IIR or FFT block based on the selected mode.

# Input Signal Generation
Real audio (.wav) signals are preprocessed using Python

Audio is:
Converted to mono
Normalized
Resampled to 64 samples
Quantized to 16-bit signed fixed-point
Samples are stored in input_rom.mif and loaded into on-chip ROM
This allows realistic DSP behavior while remaining fully digital.

# IIR Filter Design
Second-order recursive filter

Design Features:
Multiplier-free implementation using bit-shifts
Fixed-point arithmetic with overflow control
Register-based feedback for deterministic timing

# FFT4 Filter Design
4-Point Radix-2 Decimation-In-Time (DIT) FFT
Processes 4 samples per frame
Outputs real and imaginary frequency bins sequentially

Design Highlights:
Frame-based buffering
Butterfly computation using add/sub operations
Resource-efficient fixed-point scaling
Valid-signal-driven output sequencing

# Functional Simulation
Verified using Quartus Functional Simulation

Observed:
Smooth recursive output for IIR mode
Discrete spectral bins for FFT mode
Output waveforms exported as .vcd files
Digital outputs reconstructed in Python to visualize signal behavior

# FPGA Implementation & Demo
Implemented on Altera DE2-70 (Cyclone II FPGA)
LED output used to demonstrate live operation
Clock divider added to slow updates for human visibilit
Mode switching performed using on-board buttons

# Tools & Technologies
Hardware Description Language: VHDL
FPGA Platform: Altera DE2-70 (Cyclone II)
Simulation: Quartus II Functional Simulation
DSP Concepts: IIR Filters, FFT, Fixed-Point Arithmetic
Software Tools: Python (NumPy, SciPy, SoundFile)

# Results & Conclusion
Successfully designed a reconfigurable FPGA-based DSP engine
Demonstrated both time-domain filtering and frequency-domain analysis
Achieved resource-efficient, deterministic hardware execution
Project highlights the power and flexibility of FPGA-based DSP systems for education and prototyping

# Future Enhancements
Integrate ADC/DAC for real-time audio I/O
Increase FFT size (8-point / 16-point)
Add configurable filter coefficients
Implement audio playback via external codec
