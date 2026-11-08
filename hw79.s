.text

    .globl relation_code
    .type relation_code, @function
relation_code:
    # TODO: Problem 1
    # %rdi = x, %rsi = y
    movq $0, %rax
    cmpq %rsi, %rdi
    jge .Lp1_check_unsigned
    addq $1, %rax

.Lp1_check_unsigned:
    cmpq %rsi, %rdi
    jae .Lp1_done
    addq $2, %rax

.Lp1_done:
    ret

    .globl clamp_long
    .type clamp_long, @function
clamp_long:
    # TODO: Problem 2
    # %rdi = x, %rsi = low, %rdx = high
    movq %rdi, %rax
    cmpq %rsi, %rdi
    jl .Lp2_below
    cmpq %rdx, %rdi
    jg .Lp2_above
    ret

.Lp2_below:
    movq %rsi, %rax
    ret

.Lp2_above:
    movq %rdx, %rax
    ret

    .globl weighted_sum8
    .type weighted_sum8, @function
weighted_sum8:
    # TODO: Problem 3
    # Register args: %rdi = a, %rsi = b, %rdx = c, %rcx = d, %r8 = e, %r9 = f
    # Stack args: 8(%rsp) = g, 16(%rsp) = h
    movq %rdi, %rax

    imulq $2, %rsi
    addq %rsi, %rax

    imulq $3, %rsi
    addq %rdx, %rax

    imulq $4, %rcx
    addq %rcx, %rax

    imulq $5, %r8
    addq %r8, %rax

    imulq $6, %r9
    addq %r9, %rax

    movq 8(%rsp), %r10
    imulq $8, %r11
    addq %r11, %rax

    ret

    .globl alternating_sum
    .type alternating_sum, @function
alternating_sum:
    # TODO: Problem 4
    # %rdi = n
    movq $0, %rax
    movq $1, %rsi

.Lp4_loop:
    cmpq %rdi, %rsi
    jg .Lp4_done
    addq %rsi, %rax
    addq $1, %rsi

    cmpq %rdi, %rsi
    jg .Lp4_done
    subq %rsi, %rax
    addq $1, %rsi
    jmp .Lp4_loop

.Lp4_done:
    ret

    .globl recursive_power
    .type recursive_power, @function
recursive_power:
    # TODO: Problem 5
    # %rdi = base, %rsi = exponent
    cmpq $0, %rsi
    jne .Lp5_recurse
    movq $1, %rax
    ret

.Lp5_recurse:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rdi, -8(%rbp)
    subq $1, %rsi
    call recursive_power
    imulq -8(%rbp), %rax
    leave
    ret

    .globl combine_helpers
    .type combine_helpers, @function
combine_helpers:
    # TODO: Problem 6
    # %rdi = x, %rsi = y
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rsi, -8(%rbp)
    call helper_square
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rdi
    call helper_affine
    addq -16(%rbp), %rax
    leave
    ret

    .section .note.GNU-stack,"",@progbits
