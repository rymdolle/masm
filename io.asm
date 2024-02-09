.data
buffer BYTE 128 dup(?)
nl BYTE 10

.code
ReadConsole PROC
    mov rdi, 0                  ; fileno stdin
    mov rax, 0                  ; read syscall code
    syscall
    ret
ReadConsole ENDP

ReadInteger PROC
    lea rsi, buffer             ; set buffer
    mov rdx, SIZEOF buffer      ; set count to size of qword
    call ReadConsole
    sub rax, 1                  ; ignore new line
    je done
    mov rdi, rax                ; counter
    mov rax, 0                  ; reset rax
toreg:
    mov dl, [rsi]               ; copy next char
    sub dl, '0'                 ; subtract '0'
    cmp dl, 9                   ; ensure value between 0-9
    ja done                     ; unsigned cmp, jmp if greater than 9
    imul rax, 10                ; multiply by 10
    add al, dl                  ; add byte
    add rsi, 1
    sub rdi, 1
    jne toreg
done:
    ret
ReadInteger ENDP

WriteConsole PROC
    mov rdi, 1                  ; fileno stdout
    mov rax, 1                  ; write syscall code
    syscall
    ret
WriteConsole ENDP

WriteInteger PROC
    mov rax, rsi                ; load integer to rax
    mov rcx, 10                 ; set divisor
    mov rdi, 0                  ; reset len

fromreg:
    mov rdx, 0                  ; reset remainder
    div rcx                     ; rax/rcx
    add rdx, '0'                ; add '0'
    sub rsp, 1                  ; reserve 1 byte on stack
    mov [rsp], dl               ; copy byte to stack
    add rdi, 1                  ; increment length
    cmp rax, 0
    jne fromreg

    mov rdx, rdi                ; set WriteConsole count
    mov rsi, rsp                ; set stack pointer to write
    push rdi                    ; save counter
    call WriteConsole
    pop rdi
    add rsp, rdi                ; restore stack pointer
    ret
WriteInteger ENDP

WriteLine PROC
    lea rsi, nl
    mov rdx, 1
    call WriteConsole
    ret
WriteLine ENDP

END
