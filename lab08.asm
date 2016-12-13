.model small
.stack 100h
.data
cout dw -1
temp dw 0
rows dw 3
cols dw 5
mas db 25 dup(?)
.code
start:
mov ax, @data
mov ds, ax
lea bx, mas
mov cx, rows
mov al, 0
@op1:
   mov al, 2
   mov [bx][si], al 
in1:
  push cx
  mov cx, cols
  mov si, 0
  inc cout
in2:
   add al, 10
   mov ax, si
   cmp ax, cout
   je @op1
   mov [bx][si], al 
   mov al, [bx][si]
   inc si
   loop in2
   add bx, cols
   pop cx
   loop in1
   

end start   
