ExitSuccess PROTO
WriteInteger PROTO
WriteLine PROTO
ReadInteger PROTO
WriteConsole PROTO

.data
prompt BYTE "Enter number to calculate Nth fibonacci number: "

.code
main PROC
        lea rdi, prompt
        mov rsi, SIZEOF prompt
        call WriteConsole       ; write prompt
        call ReadInteger        ; read user input
        mov rcx, rax            ; set counter to user input
        mov rax, 0              ; reset accumulator
        mov rdi, 1              ; first value

fib:
        mov rdx, rax            ; save rax in rdx
        add rax, rdi            ; add next value to rax
        mov rdi, rdx            ; restore rdx to rdi
        sub rcx, 1              ; subtract 1 from counter
        jg fib                  ; jmp if greater than zero

        mov rdi, rax
        call WriteInteger
        call WriteLine
        call ExitSuccess
main ENDP

END
