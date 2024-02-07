.code
ExitProcess PROC                ; exit status in rdi register
        mov rax, 60             ; syscall exit
        syscall
ExitProcess ENDP

ExitSuccess PROC
        mov rdi, 0              ; set exit status to 0
        call ExitProcess
ExitSuccess ENDP

END
