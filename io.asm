.data
.code
ReadConsole PROC
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, 0                  ; fileno stdin
    mov rax, 0                  ; read syscall code
    syscall
    ret
ReadConsole ENDP

ReadInteger PROC
    sub rsp, 128
    mov rdi, rsp                ; set buffer
    mov rsi, 128                ; set count to size of qword
    call ReadConsole
    sub rax, 1                  ; ignore new line
    je done
    mov rdi, rax                ; counter
    mov rax, 0                  ; reset rax
    mov rsi, 0
toreg:
    mov dl, [rsp + rsi]         ; copy next char
    sub dl, '0'                 ; subtract '0'
    cmp dl, 9                   ; ensure value between 0-9
    ja done                     ; unsigned cmp, jmp if greater than 9
    imul rax, 10                ; multiply by 10
    add al, dl                  ; add byte
    add rsi, 1
    sub rdi, 1
    jne toreg
done:
    add rsp, 128
    ret
ReadInteger ENDP

WriteConsole PROC
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, 1                  ; fileno stdout
    mov rax, 1                  ; write syscall code
    syscall
    ret
WriteConsole ENDP

WriteInteger PROC
    mov rax, rdi                ; load integer to rax
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

    mov rsi, rdi                ; set WriteConsole count
    mov rdi, rsp                ; set stack pointer to write
    push rsi                    ; save counter
    call WriteConsole
    pop rax
    add rsp, rax                ; restore stack pointer
    ret
WriteInteger ENDP

WriteLine PROC
    sub rsp, 1
    mov BYTE PTR [rsp], 10
    mov rdi, rsp
    mov rsi, 1
    call WriteConsole
    add rsp, 1
    ret
WriteLine ENDP

END
