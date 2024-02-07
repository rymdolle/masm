ExitProcess PROTO

.data

.code
main PROC
        mov rax, 0              ; reset accumulator
        mov rbx, 1              ; first value
        mov rcx, 13             ; run fib 13 times

fib:
        mov rdx, rax            ; save rax in rdx
        add rax, rbx            ; add next value to rax
        mov rbx, rdx            ; restore rdx to rbx
        sub rcx, 1              ; subtract 1 from counter
        jne fib                 ; jmp if not zero

        mov rcx, rax
        call ExitProcess

main ENDP

END
