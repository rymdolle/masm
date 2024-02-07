ExitProcess PROTO
WriteInteger PROTO
WriteLine PROTO
ReadInteger PROTO

.data

.code
main PROC
    call ReadInteger
    mov rsi, rax
    call WriteInteger
    call WriteLine

    mov rcx, 0
    call ExitProcess
main ENDP

END
