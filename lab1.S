.global lab1

.syntax unified

// The character # can be used for immediates (numbers) 
// or if it stands at the first position of a line 
// the whole line is counted as a comment.
#define a #4
#define b #6
#define c #4
lab1:
	// lr - link register
	// used to hold the return address for a func call
	push {lr}
	// r0-r12 general purpose registers
	mov r0, a
	mov r1, b
	mov r2, c
	// bl - move to calc and save return address to LR
	bl calc
	// pc - program counter or r15
	pop {pc}
	
calc:
	push { r4, r5, lr }
	// adds r0 and r1. Result in r5
	add r5, r0, r1 //add a + b
	mov r4, #2 // 2
	// unsigned div
	sdiv r5, r5, r4 //(a+b)/2
	
	mov r0, r2 // mov r0, c (because bne compares r0)
	bl factorial
	add r0, r0, r5
	pop { r4, r5, pc }

factorial:
	push { r4 }
	mov r4, 1
	
.loop:
	mul r4, r4, r0
	// sub and change flags
	// N - result greater or equal to 0
	// Z - result is zero
	// C - carry (did not fit)
	// V - Overflow
	subs r0, r0, #1
	// if r0 is not zero jump to func
	bne .loop
	mov r0, r4
	pop { r4 }
	// go to link register
	bx lr
