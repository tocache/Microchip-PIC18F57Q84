    PROCESSOR 18F57Q84
    #include "cabecera.inc"
    
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
    bsf TRISA, 3, 1	    ;RA3 es entrada
    bcf ANSELA, 3, 1	    ;RA3 es digital
    bsf WPUA, 3, 1	    ;RA3 pullup activo
    bcf TRISF, 3, 1	    ;RF3 es salida
    bcf ANSELF, 3, 1	    ;RF3 es digital
inicio:
    btfsc PORTA, 3, 1	    ;Pregunto si presione el pulsador integrado
    bra no_presione
    bra si_presione
no_presione:
    bcf LATF, 3, 1	    ;enciendo el LED en RF3
    bra inicio
si_presione:
    bsf LATF, 3, 1	    ;apago el LED en RF3
    bra inicio
    
    end upcino


