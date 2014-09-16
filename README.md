## ECE382 Lab1 - A Simple Calculator

Goal: to make a simple assembly language program that adds or subtracts values in ROM based on coded operation values that are also in ROM.

### Design

The first step in creating the calculator was to design a flowchart of how it would work. The flowchart that I created is shown below.

![alt text](https://raw.githubusercontent.com/ChrisMKiernan/ECE382_Lab1/master/Lab1Flowchart.jpg "The flowchart of basic functionality of my program")

In this flowchart, the registers used to store values are labeled below the program. The program grabs the first value, then grabs the operation value. The operation value is compared to known immediate values of the various operations. The CMP function sets the zero flag if the values are equal, so the JZ command was useful to direct the PC to the correct loop for the operation. Once in the correct loop, the operation was completed, the value stored to RAM and the program returned to the starting point.

### Implementation

The flowchart was converted to code and implemented using Code Composer Studio v6. An extra command had to be used to account for storing the operations and numbers in ROM. The byte: command was used at the beginning of the program in order to store all of the operation and numberical values in ROM starting at 0xc000. 
