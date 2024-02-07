.code
ExitProcess PROC
        mov rdi, rcx            ; set exit status
        mov rax, 60             ; syscall exit
        syscall
ExitProcess ENDP
END
