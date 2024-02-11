ExitSuccess PROTO
WriteInteger PROTO
WriteLine PROTO
ReadInteger PROTO

.data

.code
main PROC
    call ReadInteger
    mov rdi, rax
    call WriteInteger
    call WriteLine

    call ExitSuccess
main ENDP

END
