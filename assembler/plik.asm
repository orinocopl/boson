	add r1,r0
	sub r2,r3
	add r3,r3
gdzies:
	move (r3),r0
	move r3,(r1)
	move r3,r2
gdzies2:
	move #40,r3
	jeq r2,gdzies
	jne r2,gdzies
	jge r2,gdzies2
	jlt r2,gdzies
	jmp gdzies
