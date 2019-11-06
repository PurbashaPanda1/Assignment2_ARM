     AREA    exponential,CODE,READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	

	    MOV R1,#15; the number of times loop will run n
		MOV R2,#1; initial value of the loop
		
		
;;;;;;;;;;;;;;;;  to calculate sine and cosine ;;;;;;;;;;;;;;;;;;;;;;;;;;;

        VLDR.F32 S0,=270;Value of x is stored in S0 in degress
		VLDR.F32 S9,=57 ; to convert the value entered into pi format for conversion to radian
		VLDR.F32 S17,=1;
		VDIV.F32 S0,S0,S9 ; conversion to radian :x*3.14/180 (x is approximated to be divided by 57)
		
		VMOV.F32 S1,S0 ;Sine Sum is stored in S1
		VMOV.F32 S2,S0 ;intermediate  sine Sum is stored in S2
		
		VLDR.F32 S12,=1 ; CoSine sum is stored in S12
		VLDR.F32 S14,=1 ;intermediate CosineSum is stored in S14	
        
		VLDR.F32 S3,=2; to calculate 2i	
 
;;;;;;;;;;;;;;;;equation used for calculation of sine ;;;;;;;;;;;;;;;;;;
	;x=x*3.14159/180;
    ;t=x;
    ;sum=x;
     
    ; Loop to calculate the value of Sine 
    ;for(i=1;i<=n;i++)
    ;{;
    ;    t=(t*(-1)*x*x)/(2*i*(2*i+1));
    ;    sum=sum+t;
    ;};
;;;;;;;;;;;;;;;;;;;;;;;;  logic used for cosine ;;;;;;;;;;;;;;;;;;;;;;;;;;
	;x=x*3.14159/180;
     
   ;  Loop to calculate the value of Cosine 
    ;for(i=1;i<=n;i++)
   ; {;
   ;     t=t*(-1)*x*x/(2*i*(2*i-1));
   ;     sum=sum+t;
   ; };



tan1    CMP R2,R1;to compare if the loop value i reaches n 
        BLE tan;if i < n goto 'tan' calculation loop
        B stop;else goto stop

tan		VMUL.F32 S2,S2,S0;      t = t*x for sine
        VNMUL.F32 S2,S2,S0; t = -t*x*x for sine
		
		VMUL.F32 S14,S14,S0;  t = t*x for cosine
        VNMUL.F32 S14,S14,S0; t = -t*x*x for cosine
		
		VMOV.F32 S5,R2;Moving the bit stream in R2('i') to S5(floating point register)
        VCVT.F32.U32 S5, S5;Converting the bitstream into unsigned fp Number 32 bit
		
		VMUL.F32 S4,S3,S5 ; to calculate 2i
		
		VADD.F32 S6,S4,S17 ; to calculate 2i+1 for sine term
		VSUB.F32 S7,S4,S17 ; to calculate 2i-1 for cosine term
		
		VMUL.F32 S6,S6,S4 ; to calculate 2i(2i+1)
		VMUL.F32 S7,S7,S4 ; to calculate 2i(2i-1)
		
        VDIV.F32 S2,S2,S6;    to calculate (-t*x*x)/(2i*(2i+1))
		VDIV.F32 S14,S14,S7 ; to calculate (-t*x*x)/(2i*(2i-1))
		
        VADD.F32 S1,S2,S1;     value of sine
		VADD.F32 S12,S14,S12 ; value of cosine
		
		VDIV.F32 S13,S1,S12 ;  tanx = sin x / cos x
		
        ADD R2,R2,#1;Increment the counter variable 'i'
        B tan1;Again goto comparision




stop        B stop  ; stop program
        endfunc
      end

  
		 