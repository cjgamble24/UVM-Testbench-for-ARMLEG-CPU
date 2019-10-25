module InstructionMemory
(	
  input [63:0] programCounter,
  output reg [31:0] CPU_Instruction
);

  reg [8:0] instructionMemoryData[63:0];

  initial begin
  
        //Load Operations
        
        //LDUR X1, [X31, #8]
        //Data[0-3] = 'b11111000;010_00000;1000_00_11;111_00001
        instructionMemoryData[0] = 'b11111000; //'hf8
        instructionMemoryData[1] = 'b01000000; //'h40
        instructionMemoryData[2] = 'b10000011; //'h83
        instructionMemoryData[3] = 'b11100001; //'he1
        
        //LDUR X2, [X31, #16]
        //Data[4-7] = 'b11111000;010_00001;0000_00_11;111_00010
        instructionMemoryData[4] = 'b11111000; //'hf8
        instructionMemoryData[5] = 'b01000001; //'h41
        instructionMemoryData[6] = 'b00000011; //'h03
        instructionMemoryData[7] = 'b11100010; //'he2
        
        //LDUR X3, [X31, #24]
        //Data[8-11] = 'b11111000;010_00001;1000_00_11;111_00011
        instructionMemoryData[8] = 'b11111000; //'hf8
        instructionMemoryData[9] = 'b01000001; //'h41
        instructionMemoryData[10] = 'b10000011; //'h83
        instructionMemoryData[11] = 'b11100011; //'he3
        
        //LDUR X4, [X31, #32]
        //Data[12-15] = 'b11111000;010_00010;000_00_11;111_00100
        instructionMemoryData[12] = 'b11111000; //'hf8
        instructionMemoryData[13] = 'b01000010; //'h42
        instructionMemoryData[14] = 'b00000011; //'h03
        instructionMemoryData[15] = 'b11100100; //'he4
        
        //LDUR X5, [X31, #40]
        //Data[16-19] = 'b11111000;010_00010;1000_00_11;111_00101
        instructionMemoryData[16] = 'b11111000; //'hf8
        instructionMemoryData[17] = 'b01000010; //'h42
        instructionMemoryData[18] = 'b10000011; //'h83
        instructionMemoryData[19] = 'b11100101; //'he5
        
        //LDUR X6, [X31, #48]
        //Data[20-23] = 'b11111000;010_00011;0000_00_11;111_00110
        instructionMemoryData[20] = 'b11111000; //'hf8
        instructionMemoryData[21] = 'b01000011; //'h43
        instructionMemoryData[22] = 'b00000011; //'h03
        instructionMemoryData[23] = 'b11100110; //'he6
        
        //LDUR X7, [X31, #56] 
        //Data[24-27] = 'b11111000;010_00011;1000_00_11;111_00111
        instructionMemoryData[24] = 'b11111000; //'hf8
        instructionMemoryData[25] = 'b01000011; //'h43
        instructionMemoryData[26] = 'b10000011; //'h83
        instructionMemoryData[27] = 'b11100111; //'he7
        
        //LDUR X8, [X31, #64] 
        //Data[28-31] = 'b11111000;010_00100;0000_00_11;111_01000
        instructionMemoryData[28] = 'b11111000; //'hf8
        instructionMemoryData[29] = 'b01000100; //'h44
        instructionMemoryData[30] = 'b00000011; //'h03
        instructionMemoryData[31] = 'b11101000; //'he8
        
        //LDUR X9, [X31, #72] 01001000
        //Data[32-35] = 'b11111000;010_00100;1000_00_11;111_01001
        instructionMemoryData[32] = 'b11111000; //'hf8
        instructionMemoryData[33] = 'b01000100; //'h44
        instructionMemoryData[34] = 'b10000011; //'h83
        instructionMemoryData[35] = 'b11101001; //'he9
        
        //LDUR X10, [X31, #80] 01001000
        //Data[36-39] = 'b11111000;010_00101;0000_00_11;111_01010
        instructionMemoryData[36] = 'b11111000; //'hf8
        instructionMemoryData[37] = 'b01000101; //'h45
        instructionMemoryData[38] = 'b00000011; //'h03
        instructionMemoryData[39] = 'b11101010; //'hea
        
        //LDUR X11, [X31, #88] 01011000
        //Data[40-43] = 'b11111000;010_00101;1000_00_11;111_01011
        instructionMemoryData[40] = 'b11111000; //'hf8
        instructionMemoryData[41] = 'b01000101; //'h45
        instructionMemoryData[42] = 'b10000011; //'h83
        instructionMemoryData[43] = 'b11101011; //'heb
        
        //LDUR X12, [X31, #96] 0110 0000
        //Data[44-47] = 'b11111000;010_00110;0000_00_11;111_01100
        instructionMemoryData[44] = 'b11111000; //'hf8
        instructionMemoryData[45] = 'b01000110; //'h46
        instructionMemoryData[46] = 'b00000011; //'h03
        instructionMemoryData[47] = 'b11101100; //'hec
        
        

        // Arithmetic Operations
        
        //ADD X2, X1, X3
        //Data[48-51] = 'b10001011;000_00011;_000000_00;001_00010
        instructionMemoryData[48] = 'b10001011; //'h8b
        instructionMemoryData[49] = 'b00000011; //'h03
        instructionMemoryData[50] = 'b00000000; //'h00
        instructionMemoryData[51] = 'b00100010; //'h22
          
        
        //SUB X6, X5, X4
        //Data[52-55] = 'b11001011;000_00100;_000000_00;101_00110
        instructionMemoryData[52] = 'b11001011; //'hcb                                  
        instructionMemoryData[53] = 'b00000100; //'h04                                  
        instructionMemoryData[54] = 'b00000000; //'h00                                 
        instructionMemoryData[55] = 'b10100110; //'ha6  
        
             
        //Logical Operations
        
        //ORR X9, X7, X8
        //Data[56-59] = 'b10101010;000_01000;_000000_00;111_01001
        instructionMemoryData[56] = 'b10101010; //'haa                                  
        instructionMemoryData[57] = 'b00001000; //'h08                                  
        instructionMemoryData[58] = 'b00000000; //'h00                                  
        instructionMemoryData[59] = 'b11101001; //'he9 
        
        //AND X12, X10, X11    
        //Data[60-63] = 'b10001010;000_01011;_000000_01;010_01100
        instructionMemoryData[60] = 'b10001010; //'h8a                                  
        instructionMemoryData[61] = 'b00001011; //'h0b                                  
        instructionMemoryData[62] = 'b00000001; //'h01                                  
        instructionMemoryData[63] = 'b01001100; //'h4c  

  end

  always @(programCounter) begin
    CPU_Instruction[8:0] = instructionMemoryData[programCounter+3];
    CPU_Instruction[16:8] = instructionMemoryData[programCounter+2];
    CPU_Instruction[24:16] = instructionMemoryData[programCounter+1];
    CPU_Instruction[31:24] = instructionMemoryData[programCounter];
  end
endmodule
