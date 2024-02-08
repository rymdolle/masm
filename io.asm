.data
buffer BYTE 128 dup(?)
nl BYTE 10

.code
ReadConsole PROC
    mov rdi, 0
    mov rax, 0
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
    mov rbx, 0                  ; buffer offset
    mov rcx, 10                 ; set multiplier
toreg:
    mul rcx                     ; multiply by 10
    mov dl, [rsi + rbx]         ; copy next char
    sub dl, '0'                 ; subtract '0'
    add al, dl                  ; add byte
    add rbx, 1
    cmp rbx, rdi
    jl toreg
done:
    ret
ReadInteger ENDP

WriteConsole PROC
    mov rdi, 1
    mov rax, 1
    syscall
    ret
WriteConsole ENDP

WriteInteger PROC
    mov rax, rsi                ; load integer to rax
    mov rcx, 10                 ; set divisor
    mov rbx, 0                  ; reset len

len:
    mov rdx, 0                  ; reset remainder
    div rcx                     ; rax/rbx
    add rdx, '0'                ; add '0'
    sub rsp, 1                  ; reserve 1 byte on stack
    mov [rsp], dl               ; copy byte to stack
    add rbx, 1                  ; increment length
    cmp rax, 0
    jne len

    mov rdx, rbx                ; set WriteConsole count
    mov rsi, rsp                ; set stack pointer to write
    call WriteConsole
    add rsp, rbx                ; restore stack pointer
    ret
WriteInteger ENDP

WriteLine PROC
    lea rsi, nl
    mov rdx, 1
    call WriteConsole
    ret
WriteLine ENDP

END
