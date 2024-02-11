ExitSuccess PROTO
WriteConsole PROTO
WriteInteger PROTO
WriteLine PROTO
strnlen PROTO
strlen PROTO
memset PROTO
memcpy PROTO

.data
user BYTE "user",123 DUP(10),0
zuser BYTE 128 DUP(0)
memdata BYTE 16 DUP('b')
.code
main PROC
;; strnlen
    lea rdi, user
    mov rsi, 90
    call strnlen
    mov rdi, rax
    call WriteInteger
    call WriteLine

;; strnlen zero length
    lea rdi, zuser
    mov rsi, 128
    call strnlen
    mov rdi, rax
    call WriteInteger
    call WriteLine

;; strlen
    lea rdi, user
    call strlen
    mov rdi, rax
    call WriteInteger
    call WriteLine

;; strlen zero length
    lea rdi, zuser
    call strlen
    mov rdi, rax
    call WriteInteger
    call WriteLine


    sub rsp, 16                 ; Reserve 16 bytes on stack

;; memset
    mov rdi, rsp
    mov rsi, 'a'
    mov rdx, 8
    call memset
    mov rdi, rsp
    mov rsi, 8
    call WriteConsole
    call WriteLine

;; memcpy
    mov rdi, rsp
    lea rsi, memdata
    mov rdx, 8
    call memcpy
    mov rdi, rsp
    mov rsi, 8
    call WriteConsole
    call WriteLine

    add rsp, 16                 ; Restore stack

    call ExitSuccess
main ENDP

END
