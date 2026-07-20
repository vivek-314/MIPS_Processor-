# 16-bit Single Cycle MIPS Processor in Verilog

A **16-bit Single Cycle MIPS Processor** designed and implemented in **Verilog HDL**, supporting arithmetic, logical, memory access, branch, and jump instructions. The processor was developed from scratch by implementing each hardware module individually and integrating them into a complete datapath. Functionality was verified through comprehensive simulation and waveform analysis using **Xilinx Vivado**.


## Features

- 16-bit MIPS-inspired ISA
- Single-cycle datapath architecture
- Modular Verilog implementation
- Separate Control Unit and ALU Control
- Register File with 8 general-purpose registers
- Instruction Memory and Data Memory
- Sign Extension Unit
- Branch and Jump support
- Jump and Link (JAL)
- Jump Register (JR)
- Comprehensive testbenches for module-level and processor-level verification


## Supported Instructions

| Category | Instructions |
|-----------|--------------|
| Arithmetic | ADD, SUB |
| Logical | AND, OR |
| Comparison | SLT |
| Immediate | ADDI |
| Memory | LW, SW |
| Branch | BEQ |
| Jump | J |
| Function Call | JAL |
| Return | JR |



# Processor Architecture

The processor follows a **single-cycle architecture**, where every instruction is fetched, decoded, executed, accesses memory (if required), and writes back the result within one clock cycle.

Main datapath components include:

- Program Counter (PC)
- Instruction Memory
- Control Unit
- Register File
- Sign Extension Unit
- ALU Control
- Arithmetic Logic Unit (ALU)
- Data Memory
- Write-back Multiplexer

# Module Description

## Program Counter

Maintains the address of the current instruction and updates it every clock cycle using the computed next program counter value.

---

## Instruction Memory

Stores 16-bit machine instructions loaded from `program.mem`.

---

## Register File

- 8 General Purpose Registers
- Two read ports
- One write port
- Synchronous write
- Asynchronous read

---

## Control Unit

Generates all control signals required by the datapath.

Generated signals include:

- RegDst
- ALUSrc
- MemtoReg
- RegWrite
- MemRead
- MemWrite
- Branch
- Jump
- JAL
- ALUOp

---

## ALU Control

Translates the ALUOp and Function field into the required ALU operation.

Supported operations:

- ADD
- SUB
- AND
- OR
- SLT

---

## Arithmetic Logic Unit (ALU)

Performs arithmetic and logical operations while generating the Zero flag used for branch instructions.

---

## Data Memory

Supports:

- Load Word (LW)
- Store Word (SW)

---

## Sign Extension Unit

Extends the 7-bit immediate field to a 16-bit signed value before ALU execution.

---

# Instruction Formats

### R-Type

| Opcode | RS | RT | RD | Function |
|---------|----|----|----|----------|

Used by:

- ADD
- SUB
- AND
- OR
- SLT
- JR

---

### I-Type

| Opcode | RS | RT | Immediate |
|---------|----|----|-----------|

Used by:

- ADDI
- LW
- SW
- BEQ

---

### J-Type

| Opcode | Target Address |
|---------|----------------|

Used by:

- J
- JAL

---

# Verification

Each processor component was verified independently before full system integration.

| Module | 
|---------|
| Program Counter  |
| Register File |
| Instruction Memory | 
| Data Memory |
| Sign Extension | 
| ALU |
| ALU Control | 
| Control Unit |
| Complete Processor |

---

# Functional Verification

## Arithmetic Instructions 

**Waveform**

<img width="1597" height="358" alt="image" src="https://github.com/user-attachments/assets/67bc771b-9a85-4835-9e00-76ec4ef80391" />

| PC (Hex) | Instruction (Hex) | Assembly Instruction | Expected ALU Result | Register Updated |
| :------: | :---------------: | -------------------- | :-----------------: | :--------------: |
| `0x0000` |       `E085`      | `addi r1, r0, 5`     |        `0005`       |    `R1 = 0005`   |
| `0x0002` |       `E10A`      | `addi r2, r0, 10`    |        `000A`       |    `R2 = 000A`   |
| `0x0004` |       `0530`      | `add r3, r1, r2`     |        `000F`       |    `R3 = 000F`   |
| `0x0006` |       `0531`      | `sub r3, r1, r2`     |     `FFFB` (-5)     |    `R3 = FFFB`   |
| `0x0008` |       `0532`      | `and r3, r1, r2`     |        `0000`       |    `R3 = 0000`   |
| `0x000A` |       `0533`      | `or r3, r1, r2`      |        `000F`       |    `R3 = 000F`   |
| `0x000C` |       `0534`      | `slt r3, r1, r2`     |        `0001`       |    `R3 = 0001`   |

## Memory Instructions

- LW
- SW


**Waveform**

<img width="1604" height="421" alt="image" src="https://github.com/user-attachments/assets/12dc7187-c1cb-42a9-b458-027d7eeba0b2" />

| PC (Hex) | Instruction (Hex) | Assembly Instruction | Expected Result    |
| :------: | :---------------: | -------------------- | ------------------ |
| `0x0000` |       `E085`      | `addi r1, r0, 5`     | `R1 = 0005`        |
| `0x0002` |       `E10A`      | `addi r2, r0, 10`    | `R2 = 000A`        |
| `0x0004` |       `0530`      | `add r3, r1, r2`     | `R3 = 000F`        |
| `0x0006` |       `A180`      | `sw r3, 0(r0)`       | `Memory[0] = 000F` |
| `0x0008` |       `8480`      | `lw r4, 0(r0)`       | `R4 = 000F`        |

## Branch Instruction

Verified:

- BEQ

**Waveform**

<img width="1592" height="473" alt="image" src="https://github.com/user-attachments/assets/a21ebbc9-139f-4e0d-ade2-6dd38d22019a" />

| PC (Hex) | Instruction (Hex) | Assembly Instruction | Expected Result |
|----------|-------------------|----------------------|-----------------|
| 0x0000 | E085 | addi r1,r0,5 | R1 = 0005 |
| 0x0002 | E105 | addi r2,r0,5 | R2 = 0005 |
| 0x0004 | C287 | beq r1,r2,1 | Branch Taken |
| 0x0014 | 0000 | Branch Target | PC Updated |

## Jump Instruction

Verified:

- J

**Waveform**

<img width="1601" height="367" alt="image" src="https://github.com/user-attachments/assets/17115ed8-f9fe-4051-870e-beba1a63b1ab" />


| PC     | Instruction | Operation         | Expected Result                |
| ------ | ----------- | ----------------- | ------------------------------ |
| 0x0000 | 4003        | `j 3`             | Jump to instruction index 3    |
| 0x0006 | E18F        | `addi r3, r0, 15` | `R3 = 15`                      |
| 0x0008 | 0000        | NOP               | Sequential execution continues |

## Jump and Link

Verified:

- JAL

Return address correctly stored in Register R7.

<img width="1611" height="451" alt="image" src="https://github.com/user-attachments/assets/f93f6c1f-fffa-4b8c-8017-35686cbaf892" />

| PC          | Instruction | Assembly        | Expected Result                                                   |
| ----------- | ----------- | --------------- | ----------------------------------------------------------------- |
| 0x0000      | 6003        | `jal 3`         | Jump to address `0x0006`, store return address (`0x0002`) in `R7` |
| 0x0006      | E18F        | `addi r3,r0,15` | `R3 = 15`                                                         |
| Register R7 | —           | Link Register   | `0002`                                                            |

## Jump Register

Verified:

- JR

Successfully returned execution using the address stored in Register R7.

**Waveform**
<img width="1604" height="346" alt="image" src="https://github.com/user-attachments/assets/183f01bb-c49f-4ae8-9138-679dd2a409ed" />


| PC     | Instruction | Assembly       | Result                                     |
| ------ | ----------- | -------------- | ------------------------------------------ |
| 0x0000 | 6003        | `jal 3`        | Stores `0x0002` in `R7`, jumps to `0x0006` |
| 0x0006 | 1C08        | `jr r7`        | Loads PC with value in `R7`                |
| 0x0002 | E085        | `addi r1,r0,5` | `R1 = 5`                                   |
| 0x0004 | 0000        | NOP            | Sequential execution                       |
| 0x0006 | 1C08        | Loop repeats   | Return verified                            |

# Simulation

Simulation was performed using:

- Xilinx Vivado 2019.2
- Behavioral Simulation
- Custom Verilog Testbench

Waveforms were analyzed to verify:

- Program Counter updates
- Instruction Fetch
- ALU operations
- Register Writes
- Memory Access
- Branch Decisions
- Jump Operations
- Return Address Handling

---

# Future Improvements

The current implementation is a complete single-cycle processor. Possible future extensions include:

- Multi-cycle datapath
- Five-stage pipelined processor
- Hazard Detection Unit
- Forwarding Unit
- Branch Prediction
- Interrupt Handling
- Cache Memory
- UART Interface
- FPGA deployment on Basys-3/Artix-7

---

# Tools Used

- Verilog HDL
- Xilinx Vivado 2019.2
- Git & GitHub

---


# References

- David A. Patterson and John L. Hennessy, **Computer Organization and Design: The Hardware/Software Interface**, Morgan Kaufmann.
- ES 336: Computer Organization and Architecture slides, IIT Gandhinagar 
