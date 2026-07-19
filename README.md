# 16-bit Single Cycle MIPS Processor in Verilog

A **16-bit Single Cycle MIPS Processor** designed and implemented in **Verilog HDL**, supporting arithmetic, logical, memory access, branch, and jump instructions. The processor was developed from scratch by implementing each hardware module individually and integrating them into a complete datapath. Functionality was verified through comprehensive simulation and waveform analysis using **Xilinx Vivado**.

---

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

---

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

---

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

> **Insert Datapath Diagram Here**

```
screenshots/datapath.png
```

---

# Project Structure

```
MIPS_Processor
│
├── src/
│   ├── alu.v
│   ├── alu_control.v
│   ├── control_unit.v
│   ├── data_memory.v
│   ├── instruction_memory.v
│   ├── mips_processor.v
│   ├── pc.v
│   ├── register.v
│   └── sign_extend.v
│
├── simulation/
│   ├── mips_processor_tb.v
│   ├── program.mem
│   └── waves.tcl
│
├── screenshots/
│
├── README.md
├── LICENSE
└── .gitignore
```

---

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

| Module | Status |
|---------|--------|
| Program Counter | ✅ |
| Register File | ✅ |
| Instruction Memory | ✅ |
| Data Memory | ✅ |
| Sign Extension | ✅ |
| ALU | ✅ |
| ALU Control | ✅ |
| Control Unit | ✅ |
| Complete Processor | ✅ |

---

# Functional Verification

## Arithmetic Instructions

Verified:

- ADD
- SUB
- AND
- OR
- SLT
- ADDI

**Waveform**

```
screenshots/arithmetic_test.png
```

---

## Memory Instructions

Verified:

- LW
- SW

**Waveform**

```
screenshots/memory_test.png
```

---

## Branch Instruction

Verified:

- BEQ

**Waveform**

```
screenshots/beq_test.png
```

---

## Jump Instruction

Verified:

- J

**Waveform**

```
screenshots/jump_test.png
```

---

## Jump and Link

Verified:

- JAL

Return address correctly stored in Register R7.

**Waveform**

```
screenshots/jal_test.png
```

---

## Jump Register

Verified:

- JR

Successfully returned execution using the address stored in Register R7.

**Waveform**

```
screenshots/jr_test.png
```

---

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

# Author

**Vivek Chaurasia**

B.Tech, Integrated Circuit Design and Technology  
Indian Institute of Technology Gandhinagar

```

---

## I have one suggestion

Instead of simply showing filenames like:

```markdown
screenshots/jump_test.png
```

GitHub can display the images directly. Use:

```markdown
## Jump Instruction Verification

![Jump Waveform](screenshots/jump_test.png)
```

The same for the other waveform screenshots and your datapath diagram. It makes the README much more engaging and professional.

I also recommend adding a small **processor block diagram** near the top of the README. A clean architecture figure gives readers an immediate understanding of the design and significantly improves the presentation.
