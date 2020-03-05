	.intel_syntax noprefix
	.text
	.section	.text.startup,"ax",@progbits
.LC0:
	.string	"%f\n"
	.text
        .p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
        sub rsp, 24
        fninit
        fldpi
        # Now, st(0) = pi
	# Test: FSUB1_M (32-bit memory operand)
        # Should subtract 3.0f from st(0).
        # st(0) = 0.14...
        lea rbx, three32[rip]
        fsub DWORD PTR[rbx]
        fstp QWORD PTR [rsp+8]
        movsd xmm0, QWORD PTR [rsp+8]
        lea rdi, .LC0[rip]
        call printf@PLT

        # Test: FSUBR1_M (32-bit memory operand)
        # Should store 3.0f - st(0) = -0.14... in st(0)
        fldpi
        lea rbx, three32[rip]
        fsubr DWORD PTR[rbx]
        fstp QWORD PTR[rsp+8]
        movsd xmm0, QWORD PTR[rsp+8]
        lea rdi, .LC0[rip]
        call printf@PLT

        xor eax, eax
        add rsp, 24
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	three32
	.data
	.align 4
	.type	three32, @object
	.size	three32, 4
three32:
	.long	1077936128
