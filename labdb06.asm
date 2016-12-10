;20) (2*c/d + 2)/(d - a*a - 1)
	
Data segment
	c db 24
	d db 8
	a db 2
	q db 2
	result db ?
Data ends
	
Code segment
assume cs: Code, ds: Data

begin:
	mov ax, Data
	mov ds, ax
	mov al, a
	cbw
	mul a ; a*a -> ax
	mov a, al  ;error operand types do nt match
	mov al, d ;error operand types do nt match
	sub al, a ;error operand types do nt match
	sub ax, 1 ; d - a*a - 1 -> ax
	mov result,al ;error operand types do nt match
		
	mov al, c ; c -> ax
	div d ; c/d -> al
	mul q ; (c/d)*2 -> ax
	;mov ax, ax
	add al, 2 ; (c/d)*2+2 -> ax
	cwd 
	div result ; ax ((c/d)*2+2) / result = (d - a*a - 1) -> ax
	cbw
	mov result, al ; ax -> result
	mov al, a ;error operand types do nt match
	mov AH, 4Ch 
	int 21h 
	

Code ends
end begin