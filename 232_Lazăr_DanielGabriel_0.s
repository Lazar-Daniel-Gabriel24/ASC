.data
m: .long 0
n: .long 0
p: .long 0
k: .long 0
lin: .long 0
col: .long 0
contor: .long 0
contor0: .long 0
contor1: .long 0
contor2: .long 0
adresa: .long 0
matrice: .space 1600  
vecini: .space 1600  
fs: .asciz "%ld"
fp: .asciz "%ld "
endl: .asciz "\n"

.text
.global main

main:
    lea matrice, %edi
    lea vecini, %esi

    pushl $m
    pushl $fs
    call scanf
    addl $8, %esp

    pushl $n
    pushl $fs
    call scanf
    addl $8, %esp

    pushl $p
    pushl $fs
    call scanf
    addl $8, %esp

    movl $0, contor
citire_matrice:
    movl contor, %ecx
    cmpl %ecx, p
    je final_citire

    pushl $lin
    pushl $fs
    call scanf
    addl $8, %esp

    pushl $col
    pushl $fs
    call scanf
    addl $8, %esp

    movl lin, %eax
    incl %eax
    movl n, %edx
    addl $2, %edx
    imull %edx, %eax
    addl col, %eax
    incl %eax
    movl $1, (%edi, %eax, 4)

    incl contor
    jmp citire_matrice

final_citire:

    pushl $k
    pushl $fs
    call scanf
    addl $8, %esp

    movl $0, contor
evolution_loop:
    movl contor, %ecx
    cmp k, %ecx
    je print_result

    movl $0, contor0
zero_loop:
    movl contor0, %ecx
    cmp k, %ecx
    je final_zero

    movl $0, (%esi, %ecx, 4)

    incl contor0
    jmp zero_loop

final_zero:
    movl $0, contor1
matrix_operation1:
    movl contor1, %ecx
    cmp m, %ecx
    je print_result2
    incl contor1

    movl $1, contor2
matrix_operation2:
    xorl %eax, %eax
    xorl %ebx, %ebx
    xorl %edx, %edx
    movl contor1, %eax
    movl n, %ebx
    addl $2, %ebx
    imull %ebx, %eax
    addl contor2, %eax

    movl %eax, %edx
    subl n, %edx
    subl $3, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    movl %eax, %edx
    subl n, %edx
    subl $2, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    movl %eax, %edx
    subl n, %edx
    subl $1, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    movl %eax, %edx
    subl $1, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    movl %eax, %edx
    addl $1, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    movl %eax, %edx
    addl n, %edx
    addl $1, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    movl %eax, %edx
    addl n, %edx
    addl $2, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    movl %eax, %edx
    addl n, %edx
    addl $3, %edx
    movl (%edi, %edx, 4), %ecx
    addl (%edi, %eax, 4), %ecx
    movl %ecx, (%esi, %edx, 4)

    incl contor2
    movl contor2, %edx
    cmp n, %edx
    jbe not_increment
    jmp matrix_operation1
not_increment:
    jmp matrix_operation2

print_result2:
    movl $0, contor1
print_loop12:
    movl contor1, %ecx
    cmp m, %ecx
    je final_result
    incl contor1

    movl $1, contor2
print_loop22:
    xorl %eax, %eax
    xorl %ebx, %ebx
    xorl %edx, %edx
    movl contor1, %eax
    movl n, %ebx
    addl $2, %ebx
    imull %ebx, %eax
    addl contor2, %eax
    movl (%esi, %eax, 4), %ebx

    pushl %ebx
    pushl $fp
    call printf
    addl $8, %esp

    pushl $0
    call fflush
    addl $4, %esp

    incl contor2
    movl contor2, %edx
    cmp n, %edx
    jbe not_linear2

    movl $4, %eax
    movl $1, %ebx
    movl $endl, %ecx
    movl $2, %edx
    int $0x80

    jmp print_loop12
not_linear2:
    jmp print_loop22

final_result:
    movl $1, contor1
modify_matrix1:
    movl contor1, %ecx
    ja end_evolution
    incl contor1

    movl $0, contor2
modify_matrix2:
    xorl %eax, %eax
    xorl %ebx, %ebx
    xorl %edx, %edx
    movl contor1, %eax
    movl n, %ebx
    addl $2, %ebx
    imull %ebx, %eax
    addl contor2, %eax

    movl (%edi, %eax, 4), %ebx
    movl (%esi, %eax, 4), %ecx
    cmp $0, %ebx
    jne continue_modification
    cmp $3, %ecx
    jne continue_modification
    movl $1, %ebx
    movl %ebx, (%edi, %eax, 4)
continue_modification:
    cmp $0, %ebx
    jne continue_modification2
    cmp $2, %ecx
    je continue_modification2
    cmp $3, %ecx
    je continue_modification2
    movl $0, %ebx
    movl %ebx, (%edi, %eax, 4)
continue_modification2:
    incl contor2
    movl contor2, %ecx
    cmp n, %ecx
    jbe not_increment2
    jmp modify_matrix1
not_increment2:
    jmp modify_matrix2

end_evolution:
    incl contor
    jmp evolution_loop

print_result:
    movl $0, contor1
print_loop1:
    movl contor1, %ecx
    cmp m, %ecx
    je final_print
    incl contor1

    movl $1, contor2
print_loop2:
    xorl %eax, %eax
    xorl %ebx, %ebx
    xorl %edx, %edx
    movl contor1, %eax
    movl n, %ebx
    addl $2, %ebx
    imull %ebx, %eax
    addl contor2, %eax
    movl (%edi, %eax, 4), %ebx

    pushl %ebx
    pushl $fp
    call printf
    addl $8, %esp

    pushl $0
    call fflush
    addl $4, %esp

    incl contor2
    movl contor2, %edx
    cmp n, %edx
    jbe not_linear

    movl $4, %eax
    movl $1, %ebx
    movl $endl, %ecx
    movl $2, %edx
    int $0x80

    jmp print_loop1
not_linear:
    jmp print_loop2

final_print:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
