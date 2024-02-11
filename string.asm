.data
.code

;; arg0 rdi = data
;; ret  rax = len
;; Calculate the length of string
strlen PROC
        mov rax, -1
len:
        add rax, 1
        cmp BYTE PTR [rdi + rax], 0
        jne len
done:
        ret
strlen ENDP

;; arg0 rdi = data
;; arg1 rsi = n
;; ret  rax = len
;; Calculate the length of string with fixed size
strnlen PROC
        xor rax, rax
len:
        cmp BYTE PTR [rdi + rax], 0
        je done
        add rax, 1
        sub rsi, 1
        jne len
done:
        ret
strnlen ENDP

;; arg0 rdi = data
;; arg1 rsi = c
;; arg2 rdx = n
;; ret  rax = data
;; Set n first bytes in data to c
memset PROC
        cmp rdx, rdx
        jne done
set:
        sub rdx, 1
        mov [rdi + rdx], sil
        test rdx, rdx
        jne set
done:
        mov rax, rdi
        ret
memset ENDP

;; arg0 rdi = dst
;; arg1 rsi = src
;; arg2 rdx = n
;; ret  rax = dst
;; Copy n bytes from src to dst
memcpy PROC
        cmp rdx, rdx
        jne done
cpy:
        sub rdx, 1
        mov al, [rsi + rdx]
        mov [rdi + rdx], al
        test rdx, rdx
        jne cpy
done:
        mov rax, rdi
        ret
memcpy ENDP

END
