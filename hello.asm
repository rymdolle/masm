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
    lea rsi, prompt
    mov rdx, LENGTHOF prompt
    call WriteConsole

    lea rsi, user
    mov rdx, 128
    call ReadConsole
    mov [bytes_read], rax

    lea rsi, text
    mov rdx, LENGTHOF text
    call WriteConsole

    lea rsi, user
    mov rdx, [bytes_read]
    call WriteConsole

    call ExitSuccess
main ENDP

END
