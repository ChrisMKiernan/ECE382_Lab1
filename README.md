## ECE382 Lab1 - A Simple Calculator

Goal: to make a simple assembly language program that adds or subtracts values in ROM based on coded operation values that are also in ROM.

### Design

The first step in creating the calculator was to design a flowchart of how it would work. The flowchart that I created is shown below.

![alt text](https://raw.githubusercontent.com/ChrisMKiernan/ECE382_Lab1/master/Lab1Flowchart.jpg "The flowchart of basic functionality of my program")

In this flowchart, the registers used to store values are labeled below the program. The program grabs the first value, then grabs the operation value. The operation value is compared to known immediate values of the various operations. The CMP function sets the zero flag if the values are equal, so the JZ command was useful to direct the PC to the correct loop for the operation. Once in the correct loop, the operation was completed, the value stored to RAM and the program returned to the starting point.

### Implementation

The flowchart was converted to code and implemented using Code Composer Studio v6. An extra command had to be used to account for storing the operations and numbers in ROM. The byte: command was used at the beginning of the program in order to store all of the operation and numberical values in ROM starting at 0xc000. 

### Problems

One problem I had was in the use of the inc function. Since all of the values for operations and numbers are in byte format, I originally used the inc.b function to increment my memory pointer for the write location. However, when I used this function the memory pointer would clear the MSB and increment the LSB, in other words, `inc.b r6` would change r6 from 0x0200 to 0x0001. I realized the only reason I was using inc.b instead of using inc was that I only wanted r6 to be incremented by 1, however the inc function by itself only increments by one, whether using inc.w or inc.b. to increment by two, the incd command should be used. If I wanted to increment by 1 and preserve my entire word, I could use the inc function and it worked correctly.

Another problem I had involved error checking. Using unsigned numbers, any time there is a carry there is an overflow. Using this convention, I could detect if a number went above the range by detecting if there was an carry. The problem in using the function like this is that the result of a mathematical operation only uses a byte of the register, so there isnt actually an overflow if the result is above 255, instead the value just carries over into the next bit of the register and no carry is detected. Implementing successful error checking was never achieved, so the program still uses the above code in the final version.

### Functionality

Required functionality was checked by Dr York on Thursday 11 Sep 14. No other functionality was successfully achieved. 

### Documentation

I received no outside help on this assignment
