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
	mul a ; a*a -> al
	mov a, al  ;
	mov al, d ;
	sub al, a ;
	sub al, 1 ; d - a*a - 1 -> al
	mov result,al ;
		
	mov al, c ; c -> al
	div d ; c/d -> al
	mul q ; (c/d)*2 -> al
	;mov ax, ax
	add al, 2 ; (c/d)*2+2 -> al
	cwd 
	div result ; al ((c/d)*2+2) / result = (d - a*a - 1) -> al
	cbw
	mov result, al ; al -> result
	
	mov AH, 4Ch 
	int 21h 
	

Code ends
end begin