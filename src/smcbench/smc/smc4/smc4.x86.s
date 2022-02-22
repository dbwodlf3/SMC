section .text
global _start

_start:
        ; mov eax, [copy2]  (5bytes) -> gen
        mov eax, [copy1]
        mov [gen], eax
        mov eax, [copy1+1]
        mov [gen+1], eax

        ; mov [ggen], eax (5bytes) -> gen + 5
        mov eax, [copy1+5]
        mov [gen+5], eax
        mov eax, [copy1+6]
        mov [gen+6], eax

        ; mov eax, [copy2+1] (5bytes) -> gen +10
        mov eax, [copy1+10]
        mov [gen+10], eax
        mov eax, [copy1+11]
        mov [gen+11], eax

        ; mov [ggen+1], eax (5bytes) -> gen + 15
        mov eax, [copy1+15]
        mov [gen+15], eax
        mov eax, [copy1+16]
        mov [gen+16], eax

        ; mov eax, [copy2+5] (5bytes) -> gen + 20
        mov eax, [copy1+20]
        mov [gen+20], eax
        mov eax, [copy1+21]
        mov [gen+21], eax

        ; mov [ggen], eax (5bytes) -> gen + 25
        mov eax, [copy1+25]
        mov [gen+25], eax
        mov eax, [copy1+26]
        mov [gen+26], eax

        ; int 0x80 (2bytes) -> gen + 30
        mov ax, [copy1+30]
        mov [gen+30], ax

        jmp gen

copy1:
        ; mov eax, 1 (5bytes) -> ggen
        mov eax, [copy2]
        mov [ggen], eax
        mov eax, [copy2+1]
        mov [ggen+1], eax

        ; int 0x80 (2bytes) -> ggen + 5
        mov eax, [copy2+5]
        mov [ggen+5], eax

copy2:
        mov eax, 1
        int 0x80

gen:
        mov eax, 0
        mov eax, 0
        mov eax, 0
        mov eax, 0
        mov eax, 0
        mov eax, 0
ggen:
        nop