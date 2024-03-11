#### Introduction
This is the second assignment of the "Assembly Language and Microcomputer" course at NSYSU.

Main targets:
- Write an ARM assembly code to implement a deasm program which can partially deassembly the instruction contents of your program.
- Your program should identify every **data processing, LDR, SDR and branch instructions** written in a given program test.s, and show its condition filed, and instruction name. 

#### Run
For example, if you execute the program as follows:  
```
deasm
```
 
Then the screen should display the following results：  
```
PC condition instruction 
0     AL        ADD 
4     EQ        SUB 
8     AL        BL 
12    EQ        LDR 
16    AL        UND 
20    LT        CMP
```
