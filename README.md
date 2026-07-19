# MIPS_Processor-
pv <img width="1027" height="303" alt="image" src="https://github.com/user-attachments/assets/6bca5c1b-ea9f-4bcf-871f-43609ac31dbc" />
memoty instruction <img width="1624" height="283" alt="image" src="https://github.com/user-attachments/assets/7b205f7b-b4fd-4018-b915-5f24319bce01" />
registers : <img width="1608" height="401" alt="image" src="https://github.com/user-attachments/assets/85346a85-50a9-46ca-afe1-57fbc6119eb3" />

ALU  <img width="1607" height="248" alt="image" src="https://github.com/user-attachments/assets/bcb73ce9-21a2-48bf-92b4-8f472abd4a2d" />

data_memory <img width="1593" height="345" alt="image" src="https://github.com/user-attachments/assets/d262792b-3030-49df-881d-6c37814c2920" />

sign extend <img width="1604" height="159" alt="image" src="https://github.com/user-attachments/assets/35518204-ceeb-4dc9-9ef3-d51fb200bb9d" />

alu_control <img width="1593" height="206" alt="image" src="https://github.com/user-attachments/assets/3c67536e-9b1c-4233-84e2-424ff9cf8f2c" />


withput beq  <img width="1603" height="370" alt="image" src="https://github.com/user-attachments/assets/6aa1e1de-7624-4ea6-bae8-7ddee5cf0e36" />


test 1 ARITHIMETIC 
E085
E10A
0530
0531
0532
0533
0534

addi r1,r0,5
addi r2,r0,10
add  r3,r1,r2
sub  r3,r1,r2
and  r3,r1,r2
or   r3,r1,r2
slt  r3,r1,r2

simulation result 
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


Waveform Observation

The simulation verifies the following:

✅ Program Counter (PC) increments by 2 bytes after each instruction.
✅ Instruction Memory fetches the correct instruction.
✅ ALU produces the expected output for each arithmetic operation.
✅ Write-back data matches the ALU result.
✅ Register File updates the destination register correctly.
✅ Zero flag is asserted only when the ALU output equals zero (during the AND operation).

| Instruction | Operation            | 
| ----------- | -------------------- | 
| `ADDI`      | Add Immediate        |     
| `ADD`       | Register Addition    |     
| `SUB`       | Register Subtraction |     
| `AND`       | Bitwise AND          |     
| `OR`        | Bitwise OR           |     
| `SLT`       | Set Less Than        |  


# Test j2 : memory 

addi r1,r0,5
addi r2,r0,10
add  r3,r1,r2
sw   r3,0(r0)
lw   r4,0(r0)

E085
E10A
0530
A180
8480

| Hex  | Instruction   |
| ---- | ------------- |
| E085 | addi r1,r0,5  |
| E10A | addi r2,r0,10 |
| 0530 | add r3,r1,r2  |
| A180 | sw r3,0(r0)   |
| 8480 | lw r4,0(r0)   |


| PC (Hex) | Instruction (Hex) | Assembly Instruction | Expected Result    |
| :------: | :---------------: | -------------------- | ------------------ |
| `0x0000` |       `E085`      | `addi r1, r0, 5`     | `R1 = 0005`        |
| `0x0002` |       `E10A`      | `addi r2, r0, 10`    | `R2 = 000A`        |
| `0x0004` |       `0530`      | `add r3, r1, r2`     | `R3 = 000F`        |
| `0x0006` |       `A180`      | `sw r3, 0(r0)`       | `Memory[0] = 000F` |
| `0x0008` |       `8480`      | `lw r4, 0(r0)`       | `R4 = 000F`        |

<img width="1604" height="421" alt="image" src="https://github.com/user-attachments/assets/12dc7187-c1cb-42a9-b458-027d7eeba0b2" />

Waveform Observation
Register R1 and R2 are initialized using ADDI.
The ALU computes the sum (000F) and stores it in R3.
During the SW instruction, mem_write is asserted and 000F is written into Memory[0].
During the LW instruction, mem_read is asserted and the stored value (000F) is read back into register R4.
The waveform confirms correct operation of the data memory, memory control signals, and write-back path.

# test 3 

E085
E105
C287
E181
E18F 

| Hex  | Instruction   |
| ---- | ------------- |
| E085 | addi r1,r0,5  |
| E105 | addi r2,r0,5  |
| C287 | beq r1,r2,1   |
| E181 | addi r3,r0,1  |
| E18F | addi r3,r0,15 |

<img width="1592" height="473" alt="image" src="https://github.com/user-attachments/assets/a21ebbc9-139f-4e0d-ade2-6dd38d22019a" />

## Branch Instruction Verification

| PC (Hex) | Instruction (Hex) | Assembly Instruction | Expected Result |
|----------|-------------------|----------------------|-----------------|
| 0x0000 | E085 | addi r1,r0,5 | R1 = 0005 |
| 0x0002 | E105 | addi r2,r0,5 | R2 = 0005 |
| 0x0004 | C287 | beq r1,r2,1 | Branch Taken |
| 0x0014 | 0000 | Branch Target | PC Updated |


Waveform Observation
Register R1 and R2 are initialized with the value 0005.


# test 4 

j    10
addi r1,r0,5      // skipped
addi r2,r0,10     // skipped
addi r3,r0,15     // executed


500A
E085
E10A
E18F

| Hex  | Instruction   |
| ---- | ------------- |
| 500A | j 10          |
| E085 | addi r1,r0,5  |
| E10A | addi r2,r0,10 |
| E18F | addi r3,r0,15 |

The ALU compares both registers using subtraction and produces 0000.
The Zero flag is asserted, indicating the operands are equal.
The Control Unit asserts the Branch signal for the BEQ instruction.
The Program Counter selects the computed branch address (pc_next) instead of the sequential address (PC + 2), confirming correct branch execution.


<img width="1601" height="367" alt="image" src="https://github.com/user-attachments/assets/17115ed8-f9fe-4051-870e-beba1a63b1ab" />

| PC     | Instruction | Operation         | Expected Result                |
| ------ | ----------- | ----------------- | ------------------------------ |
| 0x0000 | 4003        | `j 3`             | Jump to instruction index 3    |
| 0x0006 | E18F        | `addi r3, r0, 15` | `R3 = 15`                      |
| 0x0008 | 0000        | NOP               | Sequential execution continues |


observation 
• The Jump instruction is fetched at PC = 0x0000.
• The jump target address is calculated as 0x0006.
• The Program Counter is updated with the jump target instead of PC + 2.
• Instructions at addresses 0x0002 and 0x0004 are skipped.
• Register R3 is updated to 15, confirming successful execution at the jump target.

# test 5

6003
E085
E10A
E18F

<img width="1611" height="451" alt="image" src="https://github.com/user-attachments/assets/f93f6c1f-fffa-4b8c-8017-35686cbaf892" />

| PC          | Instruction | Assembly        | Expected Result                                                   |
| ----------- | ----------- | --------------- | ----------------------------------------------------------------- |
| 0x0000      | 6003        | `jal 3`         | Jump to address `0x0006`, store return address (`0x0002`) in `R7` |
| 0x0006      | E18F        | `addi r3,r0,15` | `R3 = 15`                                                         |
| Register R7 | —           | Link Register   | `0002`                                                            |

Waveform Observation

The jal instruction stores the return address (PC + 2) in the link register (R7) before updating the Program Counter to the jump target. The skipped instructions are not executed, and the target instruction correctly updates R3 to 15, confirming proper Jump and Link functionality.

# Test 6
6003
E085
0000
1C08


<img width="1604" height="346" alt="image" src="https://github.com/user-attachments/assets/183f01bb-c49f-4ae8-9138-679dd2a409ed" />


| PC     | Instruction | Assembly       | Result                                     |
| ------ | ----------- | -------------- | ------------------------------------------ |
| 0x0000 | 6003        | `jal 3`        | Stores `0x0002` in `R7`, jumps to `0x0006` |
| 0x0006 | 1C08        | `jr r7`        | Loads PC with value in `R7`                |
| 0x0002 | E085        | `addi r1,r0,5` | `R1 = 5`                                   |
| 0x0004 | 0000        | NOP            | Sequential execution                       |
| 0x0006 | 1C08        | Loop repeats   | Return verified                            |


Waveform Observation

The jal instruction stores the return address (PC + 2) in register R7 and jumps to the target instruction. The subsequent jr r7 instruction loads the Program Counter with the value stored in R7, returning execution to the instruction immediately following the original jal. The repeating PC sequence (0 → 6 → 2 → 4 → 6) confirms correct implementation of both Jump and Link and Jump Register instructions.
