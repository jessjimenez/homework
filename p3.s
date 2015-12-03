/******************************************************************************
* from array.s
******************************************************************************/
 
.global main
.func main
   
main:
    BL  _scanf              @ branch to scanf procedure with return
    MOV R7, R0              @ move return value R0 to register R7
    MOV R0, #0              @ initialze index variable
_generate:
    CMP R0, #20             @ check to see if we are done iterating
    BEQ writedone           @ exit loop if done
    LDR R1, =array_a        @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    ADD R8, R7, R0          @ R8=n+1
    STR R8, [R2]            @ store
    ADD R2, R2, #4          @ R2=address i+1
    ADD R8, R8, #1          @ n+i+1
    SUB R8, #0, R8          @ -(n+i+1)
    STR R8, [R2]            @ store
    ADD R0, R0, #2          @ increment index by 2
    B   _generate           @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable
readloop:
    CMP R0, #20             @ check to see if we are done iterating
    BEQ readdone            @ exit loop if done
    LDR R1, =array_a              @ get address of a
    LDR R7, =array_b
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    LDR R1, [R2]            @ read the array at address 
    MOV R2, R1              @ move array value to R2 for printf
    MOV R1, R0              @ move array index to R1 for printf
    BL  _printf             @ branch to print procedure with return
    ADD R0, R0, #1          @ increment index
    B   readloop            @ branch to next loop iteration
readdone:
    B _exit                 @ exit if done
    
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return

_scanf:
    MOV R4, LR              @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    MOV PC, R4              @ return 
    
/* _sort_ascending:*/
/*getting an error when I try git pull now so. this is where I'm at.*/
 

.data

.balign 4
array_a:        .skip       80
array_b:        .skip       80
format_str:     .asciz      "%d"
printf_str:     .asciz      "a[%d] = %d\n"
exit_str:       .ascii      "Terminating program.\n"
