; a>b  (a * a - b) / a
; a=b -a
; a<b (a * b - 1) / b

.MODEL small
.Stack 100h
Datas segment 
;a>b	a dw 5 ;a dw 5
;a>b	b dw 2 ;b dw 10
; a<b	a dw -9
; a<b	b dw 3
	a dw -2
	b dw -2
	x dw ? 
	h dw ?
	xm dw ?
	mess db 'Error! Division by zero.$'
Datas ends

Codes segment 
	Assume cs:Codes, ds:Datas
First:	mov ax, Datas
	mov ds, ax
	mov ax, a;
	cmp ax, b;
	jg @greater
	jl @less
	;a==b x = -a 
	xor ax, ax
	mov ax, a
	sub ax, 0001b
	xor ax, 0FFFFh
	mov x, ax
	jmp @otv

	
@greater: ;a>b (a * a - b) / a
	xor ax, ax
	mov ax, a
	cmp ax, 0
	je @err
	mov ax, a
	mul a
	sub ax, b
	
	
	cwd
	idiv a
	mov x, ax
	jmp @otv

	
	;x = (a-b)/a
@less:	xor ax, ax ;a<b (a * b - 1) / b
	mov ax, b
	cmp ax, 0
	je @err
	mov ax, a
	mul b
	sbb ax, 1
	cwd
	idiv b
	mov x, ax
	jmp @otv

@otv:	
	xor ax, ax
	mov ax, x
	push ax
	cmp ax, 0
	jns @plus ;если знак плюс (знаковый (старший) бит результата равен 0)

	mov dl, '-'
	mov ah, 02h
	int 21h
	pop ax
	neg ax

@plus:	xor cx, cx
	mov bx, 10

@dvsn:	xor dx, dx
	div bx
	push dx
	inc cx
	test ax, ax
	jnz short @dvsn ;если нет нуля
	mov ah, 02h

@vivod: pop dx
	add dl, 30h ; +30
	int 21h
	loop @vivod
	jmp @end

@err:	mov dx, offset mess
	mov ah, 09h
	int 21h

@end:	mov ax, 4c00h
	int 21h
Codes ends
end First 
 
 
 
 
 
 
 
 