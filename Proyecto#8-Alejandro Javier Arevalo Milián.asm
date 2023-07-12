;Alejandro Javier Arevalo Milian/Proyecto #8
title Proyecto_8

include 'emu8086.inc'

data segment
    array dw 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    msj_despedida db 10,13, "El programa ha finalizado ...$"
    msj_please db 10,13,"Presione cualquier tecla para regresar al menu ...", 10,13,"$"
    msj_error db 10,13,"ERROR, intente otra vez ...$"
    saltoL db 10,13,"$"
    msjSL db 0
   
ends

code segment
    call main
    
        main proc
            call lista
            call QuickSort
            menu
            ret
        main endp
        
        menu macro
            printn ""
            printn "********Menu********"
            printn "* 1. Ordenar       *" 
            printn "* 2. Salir         *"
            printn "********************"
            printn ""
            print "Opcion deseada: "
            call scan_num
            cmp cx, 1
            je call imprimir1            
            cmp cx, 2
            je fin
            jmp error
            ret
        endm 
        
        lista proc
            call inicio
            call llenado
            ret
        lista endp
        
        llenado proc
            print "Introduzca un numero: "
            call scan_num
            mov [array + si],cx
            printn ""
            add si, 02
            inc dx 
            cmp dx, 8
            jne llenado
            mov si, 0
            mov dx, 0
            mov cx, 0
            ret
        llenado endp
        
        inicio proc
            lea si, array
            mov ax, @data
            mov ds, ax
            ret
        inicio endp
        
        fin proc
            printn ""
            printn "Proyecto creado  por Alejandro Javier Arevalo Milian"
            print "El programa ha finalizado, presione cualquier tecla para salir..."
            mov ah,0h
            int 16h
            mov ax,4c00h
            int 21h
            ret
        fin endp
        
        QuickSort proc 
            mov ax, array[si]
            mov bx, array[si+2]
            cmp ax, bx
            ja menor
            add si, 2
            inc cx
            cmp cx, 8
            jne QuickSort
            mov cx, 0
            mov si, 0
            call verificarMenor
            ret
        QuickSort endp
        
        menor proc
            mov array[si],bx
            mov array[si+2],ax
            add si, 2
            inc cx
            jmp call QuickSort
            ret
        menor endp
        
        verificarMenor proc
            mov ax,array[si]
            mov bx,array[si+2]
            cmp ax, bx
            ja resetMenor
            add si, 2
            inc cx
            cmp cx, 8
            jne verificarMenor
            ret
        verificarMenor endp
        
        resetMenor proc
            mov si, 0
            mov cx, 0
            jmp call QuickSort
            ret
        resetMenor endp
        
        imprimir1 proc
            printn ""
            print "Lista ordenada de menor a mayor: "
            mov si,0
            mov cx,8
            printmen1:
                mov ax, array[si]
                call print_num
                print ", "
                add si, 2
                loop printmen1
            mov si, 0
            mov cx, 0
            printn ""
            menu
            ret
        imprimir1 endp
        
        error:
            add msjSL, 10

            lea dx, saltoL
	        mov ah, 9
	        int 21h
	        lea dx, saltoL
	        mov ah, 9
	        int 21h
    
            mov dx, offset msj_error
            mov ah, 9
            int 21h
    
            jmp repetir
            
        repetir:
            mov msjSL, 0

            lea dx, saltoL
	        mov ah, 9
	        int 21h
	        lea dx, saltoL
	        mov ah, 9
	        int 21h
	
	        lea dx, msj_please
	        mov ah, 9
	        int 21h
	        mov ah, 7
	        int 21h
	
	        lea dx, saltoL
	        mov ah, 9
	        int 21h	
    
            menu
   
        
ends

define_scan_num
define_print_num
define_print_num_uns 
ret

end main

        
        
        
        