;20) (2*c/d + 2)/(d - a*a - 1)
	
Data segment
	c dw 24
	d dw 8
	a dw 2
	q dw 2
	result dw ?
Data ends
	
Code segment
assume cs: Code, ds: Data

begin:
	mov ax, Data
	mov ds, ax

	 
	mov ax, a ; a -> ax
	mul a ; a*a -> ax
	mov a, ax
	mov ax, d ; d -> ax
	sub ax, a ; d - a*a -> ax
	sub ax, 1 ; d - a*a - 1 -> ax
	mov result,ax ; ax -> result = (d - a*a - 1)	
		
	mov ax, c ; c -> ax
	div d ; c/d -> ax
	mul q ; (c/d)*2 -> ax
	add ax, 2 ; (c/d)*2+2 -> ax
	cwd 
	div result ; ax ((c/d)*2+2) / result = (d - a*a - 1) -> ax
	mov result, ax ; ax -> result
	mov ax, a ; a -> ax
	mov AH, 4Ch 
	int 21h 
	

Code ends
end begin