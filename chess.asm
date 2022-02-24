mov ax, 13h ; 320x200
int 10h ; set video mode
push 0A000h
pop es ; put video offset into es
xor di, di ; set di to 0
xor ax, ax ; init color as black
mov cx, 8  ; number big rows / squares vertically
bigSquareLoop:
    mov bx, 16 ; pixel height of single row / square
    xor ax, 0F0Fh   ; change color (black <-> white)
    rowLoop:
        mov dx, 8   ; squares per row
        push di     ; save di so we can use it in inner loop
        squareLoop: ; draw the 16 pixels for a single square
            xor si, si ; we use si for counting the pixels
            draw2Pixels:
                mov [es:di], ax ; set pixel
                add di, 2   ; incease offset
                inc si      ; increase pixel counter
                test si, 8 ; draw 2 pixels 8 times -> 16 pixels
            je draw2Pixels   
            xor ax, 0F0Fh ; change color (black <-> white)
            dec dx  ; one less square in current line
        jnz squareLoop
        pop di      ; restore di
        add di, 320 ; move di to start of next line
        dec bx      ; do next single pixel line
    jnz rowLoop
    dec cx ; big row done
jnz bigSquareLoop
xor ax, ax
int 16h ; wait for any key and exit
ret
