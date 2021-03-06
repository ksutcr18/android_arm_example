	.arch armv5te				@处理器架构
	.fpu softvfp				@协处理器类型	
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"hello.c"			@源文件名
	.section	.rodata			@声明只读数据段
	.align	2					@对齐方式为2^2=4字节
.LC0:							@标号为LC0
	.ascii	"Hello ARM!\000"    @声明字符串
	.text						@声明代码段（code section）
	.align	2
	.global	main				@全局符号main
	.type	main, %function		@main类型为函数
main:							@标号main
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}		@将fp、lr寄存器压入堆栈
	add	fp, sp, #4				@初始化fp寄存器，设置栈帧，用于访问局部变量	
	sub	sp, sp, #8				@开辟栈空间	
	str	r0, [fp, #-8]			@保存第一个参数
	str	r1, [fp, #-12]          @保存第二个参数
	ldr	r3, .L3					@取标号.L3处的内容，即“Hello ARM!”的偏移地址
.LPIC0:	
	add	r3, pc, r3              @计算字符串”Hello ARM!“的内存地址 
	mov	r0, r3                  @设置参数1 
	bl	puts(PLT)               @调用puts函数
	mov	r3, #0					@设置r3寄存器的值为0
	mov	r0, r3                  @程序返回结果为0 
	sub	sp, fp, #4              @恢复sp寄存器的值
	@ sp needed
	ldmfd	sp!, {fp, pc}		@恢复fp寄存器，并将lr寄存器值赋给pc寄存器	
.L4:
	.align	2
.L3:
	.word	.LC0-(.LPIC0+8)		@保存字符串相对“add	r3, pc, r3“的偏移量
	.size	main, .-main 		@main函数的大小为当前代码行减去main标号	
	.ident	"GCC: (GNU) 4.9.x 20150123 (prerelease)" @编译器标示
	.section	.note.GNU-stack,"",%progbits		 @定义.note.GNU-staack段
