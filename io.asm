.data
.code
ReadConsole PROC
    mov rdi, 0
    mov rax, 0
    syscall
    ret
ReadConsole ENDP

WriteConsole PROC
    mov rdi, 1
    mov rax, 1
    syscall
    ret
WriteConsole ENDP

END
