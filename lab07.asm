; a>b  (a * a - b) / a
; a=b -a
; a<b (a * b - 1) / b

.MODEL small
.Stack 100h
Data segment 
;a>b	a dw 5 ;a dw 5
;a>b	b dw 2 ;b dw 10
; a<b	a dw -9
; a<b	b dw 3
	a dw -9
	b dw -3
	x dw ? 
	h dw ?
	xm dw ?
	mess db 'Error! Division by zero.$'
Data ends

Code segment 
	Assume cs:Code, ds:Data
begin:	
	mov ax, Data
	mov ds, ax
	mov ax, a	; a -> ax
	cmp ax, b	; ?(a == b)
	jg @op1		; if a > b	
	jl @op2		; if a < b
	;a == b x = -a 
	xor ax, ax
	mov ax, a
	sub ax, 0001b
	xor ax, 0FFFFh
	mov x, ax
	jmp @answ

	
@op1:	;a>b (a * a - b) / a
	xor ax, ax	; clean ax
	mov ax, a	; a -> ax	
	cmp ax, 0   ; ?(a == 0)
	je @err		; if a == 0 
	mul a		; a * a -> ax
	sub ax, b	; a*a - b	
	cwd
	idiv a		; (a*a - b) / a
	mov x, ax	; ax -> x
	jmp @answ	
	
@op2:	;a<b (a * b - 1) / b
	xor ax, ax	; clean ax 
	mov ax, b	; b -> ax
	cmp ax, 0	; ?(a == 0)
	je @err		; if a == 0
	mul a		; b * a -> ax
	sbb ax, 1	; a * d - 1 -> ax
	cwd
	idiv b		; (a * b - 1) / b -> ax
	mov x, ax	; ax -> x
	jmp @answ

@answ:	
	xor ax, ax	; clean ax
	mov ax, x	; x -> ax
	push ax		; 
	cmp ax, 0	;  ?(x == 0)
	jns @plus	;  if x > 0 если знак плюс (знаковый (старший) бит результата равен 0)

	mov dl, '-' 
	mov ah, 02h
	int 21h
	pop ax 
	neg ax

@plus:	
	xor cx, cx	; clean cx
	mov bx, 10	

@dvsn:	
	xor dx, dx
	div bx
	push dx
	inc cx
	test ax, ax
	jnz short @dvsn ;если нет нуля
	mov ah, 02h

@printDispl: 
	pop dx
	add dl, 30h ; +30
	int 21h
	loop @printDispl
	jmp @end

@err:	
	mov dx, offset mess
	mov ah, 09h
	int 21h

@end:	
	mov ax, 4c00h
	int 21h
Code ends
end begin 
 
 
 
 
 
 
 
 