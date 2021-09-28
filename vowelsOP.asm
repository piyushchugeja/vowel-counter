VARIABLE SEGMENT
    string DB 15 dup(10H)
    len DB ?
    printCount DB ?, '$'
    count DB ?
    message DB 'Enter your string: $'
    vowelMessage DB 'Number of vowels in your string is $'
VARIABLE ENDS

CODE SEGMENT
    START:
        ASSUME CS:CODE, DS:VARIABLE
        MOV DX, VARIABLE
        MOV DS, DX
        CALL getString
        MOV printCount, 48
        MOV  SI, offset string+2
        MOV CL, [string+1]
        MOV len, CL
        countVowel:
            MOV AL, [SI]
            CMP AL, 'a'
            JZ PLUS

            CMP AL, 'e'
            JZ PLUS

            CMP AL, 'i'
            JZ PLUS

            CMP AL, 'o'
            JZ PLUS

            CMP AL, 'u'
            JZ PLUS

            CMP AL, 'A'
            JZ PLUS

            CMP AL, 'E'
            JZ PLUS

            CMP AL, 'I'
            JZ PLUS

            CMP AL, 'O'
            JZ PLUS

            CMP AL, 'U'
            JZ PLUS
            INC SI
            LOOP countVowel
            CALL endProgram
        PLUS:
            INC count
            INC printCount
            INC SI
            LOOP countVowel
        CALL endProgram

        getString PROC
            LEA DX, message         
            MOV AH, 09H     
            INT 21H
            MOV AH, 0AH
            LEA DX, string
            INT 21H
            RET
        getString ENDP

        endProgram PROC
            POP DX
            LEA DX, vowelMessage           
            MOV AH, 09H     
            INT 21H
            LEA DX, printCount
            INT 21H
            MOV AH, 4CH
            INT 21H
        endProgram ENDP
CODE ENDS
END START