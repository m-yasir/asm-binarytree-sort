.model tiny
.stack 100h
; Written By Yasir Nadeem - during the course Microprocessor and Assembly Language
.data
arr db 5,4,7,2,11,14
len = $-arr
nArr db len*4 dup ('$') ; Multiply by 4 because there are two nodes for a root and each node has two children
nArrLen = $-nArr ; newArr Length
sorted db len dup ('$') ; resultant Array
.code                 
main proc           
    mov dl, arr[0]
    mov nArr[0], dl
    
    xor bx, bx
    mov bl, 1
    ; Forming a binary tree
    binaryLoop:
        cmp bl, len
        je exitLoop
        mov si, 0
        mov dl, arr[bx]
        call comparison
        mov nArr[di], dl
        inc bl
        jmp binaryLoop
    exitLoop:
    mov si, 0
    mov di, 0
    xor bl, bl
    push dx
    call inOrder
    pop dx
    ; Inorder traversal for sorted array
    ret
endp main
    
; 1st Param -> SI - rootIndex
; 2nd Param -> DL = element    
; result in DI
comparison proc
    cmp nArr[si], '$'
    jne cont
    mov di, si
    ret              
    
    cont:
    
    cmp dl, nArr[si]
    jg rightComp
    
    sal si, 1
    inc si
    call comparison
    jmp endL
    rightComp:
    sal si, 1
    add si, 2 
    call comparison
    endL:          
    mov di, si
    ret          
endp comparison

; 1st Param - rootIndex - SI
; uses DI as an index for resultant array
inOrder proc         
    cmp si, nArrLen
    jge exitInOrder
    
contt:
    push si
    sal si, 1
    inc si
    call inOrder  
    pop si
    
    cmp nArr[si], '$'
    je cont2   
    xor dl, dl
    mov dl, nArr[si]
    mov sorted[di], dl
    inc di
cont2:
    push si
    sal si, 1
    add si, 2
    call inOrder
    pop si
    exitInOrder:
    ret
endp inOrder
end main