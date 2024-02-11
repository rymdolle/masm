ReadConsole  PROTO
WriteConsole PROTO
ExitSuccess PROTO

.data
prompt BYTE "Enter your name: "
text BYTE "Hello "
user BYTE 128 dup(0)
bytes_read QWORD ?

.code
main PROC
    lea rdi, prompt
    mov rsi, LENGTHOF prompt
    call WriteConsole

    lea rdi, user
    mov rsi, 128
    call ReadConsole
    mov [bytes_read], rax

    lea rdi, text
    mov rsi, LENGTHOF text
    call WriteConsole

    lea rdi, user
    mov rsi, [bytes_read]
    call WriteConsole

    call ExitSuccess
main ENDP

END
