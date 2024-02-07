ExitSuccess PROTO
WriteInteger PROTO
WriteLine PROTO
ReadInteger PROTO
WriteConsole PROTO

.data
prompt BYTE "Enter number to calculate Nth fibonacci number: "

.code
main PROC
        lea rsi, prompt
        mov rdx, SIZEOF prompt
        call WriteConsole       ; write prompt
        call ReadInteger        ; read user input
        mov rcx, rax            ; set counter to user input
        mov rax, 0              ; reset accumulator
        mov rbx, 1              ; first value

fib:
        mov rdx, rax            ; save rax in rdx
        add rax, rbx            ; add next value to rax
        mov rbx, rdx            ; restore rdx to rbx
        sub rcx, 1              ; subtract 1 from counter
        jg fib                  ; jmp if greater than zero

        mov rsi, rax
        call WriteInteger
        call WriteLine
        call ExitSuccess
main ENDP

END
