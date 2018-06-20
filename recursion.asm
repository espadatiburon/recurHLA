; Assembly code emitted by HLA compiler
; Version 1.76 build 9932 (prototype)
; HLA compiler written by Randall Hyde
; FASM compatible output

		format	MS COFF


offset32	equ	 
ptr	equ	 

macro global [symbol]
{
 local isextrn
 if defined symbol & ~ defined isextrn
   public symbol
 else if used symbol
   extrn symbol
   isextrn = 1
 end if
}

macro global2 [symbol,type]
{
 local isextrn
 if defined symbol & ~ defined isextrn
   public symbol
 else if used symbol
   extrn symbol:type
   isextrn = 1
 end if
}


ExceptionPtr__hla_	equ	fs:0

		include	'recursion.extpub.inc'




		section	'.data' data readable writeable align 16
		include	'recursion.data.inc'

		dd	0	;dummy to keep linker happy
		section	'.bss' readable writeable align 16
		include	'recursion.bss.inc'

		rb	4	;dummy to keep linker happy
		section	'.text' code readable executable align 16
		include	'recursion.consts.inc'

		include	'recursion.ro.inc'

; Code begins here:
L807_factRec__hla_:
		mov	dword ptr [L810_tempEDX__hla_+0], edx	;/* tempEDX */
		mov	dword ptr [L811_tempECX__hla_+0], ecx	;/* tempECX */
		mov	dword ptr [L812_tempEAX__hla_+0], eax	;/* tempEAX */
		pop	dword ptr [L808_dreturnAddress__hla_+0]	;/* dreturnAddress */
		pop	edx
		mov	byte ptr [ebp+8], dl	;/* x */
		push	dword ptr [L808_dreturnAddress__hla_+0]	;/* dreturnAddress */
		push	dword ptr [L810_tempEDX__hla_+0]	;/* tempEDX */
		push	dword ptr [L811_tempECX__hla_+0]	;/* tempECX */
		push	dword ptr [L812_tempEAX__hla_+0]	;/* tempEAX */
		cmp	byte ptr [ebp+8], 1	;/* x */
		jle	L813_xIsOne__hla_
		jmp	L814_recursiveMul__hla_

L813_xIsOne__hla_:
		mov	word ptr [L809_myResult__hla_+0], 1	;/* myResult */
		jmp	L815_endRecur__hla_

L814_recursiveMul__hla_:
		mov	dl, byte ptr [ebp+8]	;/* x */
		push	edx
		dec	byte ptr [ebp+8]	;/* x */
		mov	dl, byte ptr [ebp+8]	;/* x */
		push	edx
		call	L807_factRec__hla_
		pop	ecx
		mov	al, bl
		mul	cl
		mov	word ptr [L809_myResult__hla_+0], ax	;/* myResult */

L815_endRecur__hla_:
		mov	bx, word ptr [L809_myResult__hla_+0]	;/* myResult */
		pop	eax
		pop	ecx
		pop	edx
		ret
xL807_factRec__hla___hla_:
;L807_factRec__hla_ endp




;/* HWexcept__hla_ gets called when Windows raises the exception. */

HWexcept__hla_ :
		jmp	HardwareException__hla_
;HWexcept__hla_  endp

DfltExHndlr__hla_:
		jmp	DefaultExceptionHandler__hla_
;DfltExHndlr__hla_ endp



_HLAMain       :


;/* Set up the Structured Exception Handler record */
;/* for this program. */

		call	BuildExcepts__hla_
		pushd	0		;/* No Dynamic Link. */
		mov	ebp, esp	;/* Pointer to Main's locals */
		push	ebp		;/* Main's display. */


		push	L829_str__hla_
		call	STDOUT_PUTS	; puts
		push	eax
		call	STDIN_GETI8	; geti8
		mov	byte ptr [L806_myInput__hla_+0], al	;/* myInput */
		pop	eax
		mov	dl, byte ptr [L806_myInput__hla_+0]	;/* myInput */
		push	edx
		call	L807_factRec__hla_
		push	ebx
		call	STDOUT_PUTI16	; puti16
QuitMain__hla_:
		push	dword 00h
		call	dword ptr [__imp__ExitProcess@4]
;_HLAMain        endp


