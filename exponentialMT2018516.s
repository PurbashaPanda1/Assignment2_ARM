     AREA    exponential,CODE,READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
		;logic used to code e^x
		;e^x = 1 + x/1! + x^2/2! + x^3/3! + ...... 
		;further this is expanded to the below line
		;e^x = 1 + (x/1) (1 + (x/2) (1 + (x/3) (........) ) ) 
		;The loop in C is as
		;for (i = n - 1, sum = 1; i > 0; --i )
		;sum = 1 + x * sum / i;
		
		MOV R0,#10 ;   number of times the loop runs ,the value 'n'
	        
	    MOV R1,#1;initial value from which the loop starts 'i'
        VLDR.F32 S0,=1;Holding the sum of series elements 's'
        VLDR.F32 S1,=1;Temp Variable to hold the intermediate series elements 't'
        VLDR.F32 S2,=15;Holding 'x' Value
exp1    CMP R1,R0;Compare 'i' and 'n' 
        BLE exp;if i < n goto LOOP
        B stop;else goto stop

exp		VMUL.F32 S1,S1,S2;t = t*x
        VMOV.F32 S5,R0;Moving the bit stream in R1('i') to S5(floating point register)
        VCVT.F32.U32 S5, S5;Converting the bitstream into unsigned fp Number 32 bit
        VDIV.F32 S1,S1,S5;Divide t by 'i' and store it back in 't'
        VADD.F32 S1,S0,S1;Finally add 's' to 't' and store it in 's'
        SUB R0,R0,#1;Increment the counter variable 'i'
        B exp1;Again goto comparision

stop        B stop  ; stop program
        endfunc
      end

  
		 