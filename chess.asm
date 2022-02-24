mov ax, 13h
int 10h ; set video mode
push 0A000h
pop es ; put video offset into es
xor di, di ; set di to 0
xor ax, ax ; init color
mov cx, 8  ; number big rows / squares vertically
bigSquareLoop:
    mov bx, 16 ; pixel height of single row / square
    xor ax, 0F0Fh   ; change color (black <-> white)
        rowLoop:
            mov dx, 8   ; squares per row
            push di     ; save di so we can use it in inner loop
                squareLoop: ; draw the 16 pixels for a single square
                    xor si, si
                        draw2Pixels:
                            mov [es:di], ax
                            add di, 2
                            inc si
                            test si, 8 ; draw 2 pixels 8 times -> 16 pixels
                        je draw2Pixels   
                    xor ax, 0F0Fh ; change color (black <-> white)
                    dec dx
                jnz squareLoop
            pop di      ; restore di
            add di, 320 ; move di to start of next line
            dec bx      ; do next single pixel line
        jnz rowLoop
    dec cx ; big row done
jnz bigSquareLoop
xor ah, ah
int 16h ; wait for any key and exit
ret