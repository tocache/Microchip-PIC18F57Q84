    PROCESSOR 18F57Q84
    #include "cabecera.inc"
    
x_var EQU 500H
y_var EQU 501H
z_var EQU 502H 
 
    PSECT upcino, class=CODE, reloc=2, abs
upcino:
    ORG 000000H
    bra configuro
    
    ORG 00050H
configuro:
    ;configuracion de la fuente de reloj
    movlb 0H		    ;cambio a Bank0
    movlw 60H
    movwf OSCCON1, 1	    ;NOSC=EXTOSC NDIV=1:1
    movlw 02H
    movwf OSCFRQ, 1	    ;HFINTOSC a 4MHz
    movlw 40H
    movwf OSCEN, 1	    ;HFINTOSC enabled
    ;configuracion de las E/S
    movlb 4H		    ;cambio a Bank4
    bcf TRISF, 3, 1	    ;RF3 es salida
    bcf ANSELF, 3, 1	    ;RF3 es digital
inicio:
    bcf LATF, 3, 1	    ;enciendo el LED en RF3
    call retardado
    bsf LATF, 3, 1	    ;apago el LED en RF3
    call retardado
    goto inicio
    
retardado:
    movlb 5H		;al Bank5
    movlw 30
    movwf x_var, 1
punto_tres:    
    movlw 30
    movwf y_var, 1
punto_dos:
    movlw 30
    movwf z_var, 1
punto_uno:    
    nop
    movf z_var, 1, 1
    movlb 4H		;Al Bank4
    btfss STATUS, 2, 1	;pregunto si z_var llego a cero
    bra zvar_noescero	;falso zvar no llego a cero
    movlb 5H		;Al bank5
    movf y_var, 1, 1	;verdad y prosigo a ls siguiente pregunta
    movlb 4H		;Al Bank4
    btfss STATUS, 2, 1	;pregunto si y_var llego a cero
    bra yvar_noescero	;falso yvar no llego a cero
    movlb 5H		;Al bank5
    movf x_var, 1, 1
    movlb 4H		;Al Bank4
    btfss STATUS, 2, 1	;pregunto si x_var llego a cero
    bra xvar_noescero	;falso xvar no llego a cero
    return
zvar_noescero:
    movlb 5H		;Al bank5
    decf z_var, 1, 1	;decremento z_var
    bra punto_uno
yvar_noescero:
    movlb 5H		;Al bank5
    decf y_var, 1, 1	;decremento y_var
    bra punto_dos
xvar_noescero:
    movlb 5H		;Al bank5
    decf x_var, 1, 1	;decremtno x_var
    bra punto_tres
    
    end upcino





