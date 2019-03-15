    /* This function has 5 parameters, and the declaration in the
       C-language would look like:

       void matadd (int **C, int **A, int **B, int height, int width)

       C, A, B, and height will be passed in r0-r3, respectively, and
       width will be passed on the stack.

       You need to write a function that computes the sum C = A + B.

       A, B, and C are arrays of arrays (matrices), so for all elements,
       C[i][j] = A[i][j] + B[i][j]

       You should start with two for-loops that iterate over the height and
       width of the matrices, load each element from A and B, compute the
       sum, then store the result to the correct element of C. 

       This function will be called multiple times by the driver, 
       so don't modify matrices A or B in your implementation.

       As usual, your function must obey correct ARM register usage
       and calling conventions. */

	.arch armv7-a
	.text
	.align	2
	.global	matadd
	.syntax unified
	.arm
matadd: @ int **C, int **A, int **B, int height, int width
    @ v1: *C, v2: *A, v3: *B, v4: width_temp, v5: const width, v6: **C, v7: **A, v8: **B
    push {v1, v2, v3, v4, v5, v6, v7, v8, lr} 
    ldr v5, [sp, #36]
    lsr v5, v5, #2                  @ Loop unrolled 2 times. Div counter by 4
    sub v5, v5, #1                  @ const Width is 0 based counter
    sub a4, a4, #1                  @ const Width is 0 based counter
    lsl a4, a4, #2                  @ Convert #vals to #bytes
for_height:
    cmp a4, #-4
    beq endfor_height
    ldr v1, [a1, a4]
    ldr v2, [a2, a4]
    ldr v3, [a3, a4]

    mov v4, v5                      @ Set counter for_width loop
    lsl v4, v4, #2                  @ Convert #vals to #bytes
for_width:
    cmp v4, #-4
    beq endfor_width

    ldr v6, [v1, v4]
    ldr v7, [v2, v4]
    ldr v8, [v3, v4]
    add v6, v7, v8
    sub v4, v4, #4

    ldr v6, [v1, v4]
    ldr v7, [v2, v4]
    ldr v8, [v3, v4]
    add v6, v7, v8
    sub v4, v4, #4

    ldr v6, [v1, v4]
    ldr v7, [v2, v4]
    ldr v8, [v3, v4]
    add v6, v7, v8
    sub v4, v4, #4

    ldr v6, [v1, v4]
    ldr v7, [v2, v4]
    ldr v8, [v3, v4]
    add v6, v7, v8
    sub v4, v4, #4

    b   for_width
endfor_width:

    sub a4, a4, #4
    b   for_height
endfor_height:
    pop {v1, v2, v3, v4, v5, v6, v7, v8, pc}
