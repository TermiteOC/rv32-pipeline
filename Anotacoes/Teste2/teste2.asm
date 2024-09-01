.data 
arrayA:	     .word 0, 0

.text
main:
        la    s0, arrayA      # carrega o endereco de arrayA em s0, 
                              # o endereco-base
        addi  s1, zero, 1     # s1 = 1
        addi  s2, zero, 0     # i = 0
        addi  s3, zero, 5     # s3 = 5
        addi  s4, zero, 10    # s4 = 10
        
    	or    t0, s3, s4      # t0 = s3 or s4
    	and   t0, t0, s1      # t0 = t0 and s1
    	
Loop:   add   t1, s2, s2      # t1 = i*2
    	add   t1, t1, t1      # t1 = i*4
    	add   t1, s0, t1      # t1 = addr_base + i*4 = A[i]
    	sw    t0, 0(t1)       # A[i] = t0 = 1
    	lw    t2, 0(t1)       # t2 = A[i] = 1
    	sub   s4, s4, t2      # s4 = s4 - t2
    	
    	slt   t3, s2, s1      # se i < 1, t3 = 1, se não, t3 = 0
    	addi  s2, s2, 1       # i = i + 1
    	beq   t3, s1, Loop    # se t3 = 1, vai para Loop
    	
    	add   s4, s4, s3      # s4 = s4 + s3

  	nop                   # sem operacao
