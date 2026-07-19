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

