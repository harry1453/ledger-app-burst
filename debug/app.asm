
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

__attribute__((section(".boot"))) int main(void) {
c0d00000:	b5b0      	push	{r4, r5, r7, lr}
c0d00002:	b0aa      	sub	sp, #168	; 0xa8
    // exit critical section
    __asm volatile("cpsie i");
c0d00004:	b662      	cpsie	i

    current_text_pos = 0;
c0d00006:	4828      	ldr	r0, [pc, #160]	; (c0d000a8 <_nvram_data_size+0x68>)
c0d00008:	2400      	movs	r4, #0
c0d0000a:	6004      	str	r4, [r0, #0]
c0d0000c:	4827      	ldr	r0, [pc, #156]	; (c0d000ac <_nvram_data_size+0x6c>)
c0d0000e:	2101      	movs	r1, #1
c0d00010:	7001      	strb	r1, [r0, #0]
    text_y = 60;
    hashTainted = 1;
    uiState = UI_IDLE;
c0d00012:	4827      	ldr	r0, [pc, #156]	; (c0d000b0 <_nvram_data_size+0x70>)
c0d00014:	7004      	strb	r4, [r0, #0]

    // ensure exception will work as planned
    os_boot();
c0d00016:	f002 fdfd 	bl	c0d02c14 <os_boot>

    UX_INIT();
c0d0001a:	4826      	ldr	r0, [pc, #152]	; (c0d000b4 <_nvram_data_size+0x74>)
c0d0001c:	22b0      	movs	r2, #176	; 0xb0
c0d0001e:	4621      	mov	r1, r4
c0d00020:	f002 fea8 	bl	c0d02d74 <os_memset>
c0d00024:	ad1f      	add	r5, sp, #124	; 0x7c

    BEGIN_TRY {
        TRY {
c0d00026:	4628      	mov	r0, r5
c0d00028:	f004 fd2e 	bl	c0d04a88 <setjmp>
c0d0002c:	8528      	strh	r0, [r5, #40]	; 0x28
c0d0002e:	4922      	ldr	r1, [pc, #136]	; (c0d000b8 <_nvram_data_size+0x78>)
c0d00030:	4208      	tst	r0, r1
c0d00032:	d002      	beq.n	c0d0003a <main+0x3a>
c0d00034:	a81f      	add	r0, sp, #124	; 0x7c

            ui_idle();

            sample_main();
        }
        CATCH_OTHER(e) {
c0d00036:	8504      	strh	r4, [r0, #40]	; 0x28
c0d00038:	e024      	b.n	c0d00084 <_nvram_data_size+0x44>
c0d0003a:	a81f      	add	r0, sp, #124	; 0x7c
    os_boot();

    UX_INIT();

    BEGIN_TRY {
        TRY {
c0d0003c:	f002 fded 	bl	c0d02c1a <try_context_set>

c0d00040 <_nvram_data_size>:
            io_seproxyhal_init();
c0d00040:	f003 f88c 	bl	c0d0315c <io_seproxyhal_init>
            // Create the private key if not initialized
            if (N_initialized != 0x01) {
                unsigned char canary;
                cx_ecfp_private_key_t privateKey;
                cx_ecfp_public_key_t publicKey;
                cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey,
c0d00044:	2021      	movs	r0, #33	; 0x21
c0d00046:	a901      	add	r1, sp, #4
c0d00048:	ad14      	add	r5, sp, #80	; 0x50
c0d0004a:	2400      	movs	r4, #0
c0d0004c:	462a      	mov	r2, r5
c0d0004e:	4623      	mov	r3, r4
c0d00050:	f003 fc10 	bl	c0d03874 <cx_ecfp_generate_pair>
                                      0);
                nvm_write((void*) &N_privateKey, &privateKey,
c0d00054:	4819      	ldr	r0, [pc, #100]	; (c0d000bc <_nvram_data_size+0x7c>)
c0d00056:	4478      	add	r0, pc
c0d00058:	2228      	movs	r2, #40	; 0x28
c0d0005a:	4629      	mov	r1, r5
c0d0005c:	f003 fbaa 	bl	c0d037b4 <nvm_write>
c0d00060:	a91e      	add	r1, sp, #120	; 0x78
c0d00062:	2501      	movs	r5, #1
                          sizeof(privateKey));
                canary = 0x01;
c0d00064:	700d      	strb	r5, [r1, #0]
                nvm_write((void*) &N_initialized, &canary, sizeof(canary));
c0d00066:	4816      	ldr	r0, [pc, #88]	; (c0d000c0 <_nvram_data_size+0x80>)
c0d00068:	4478      	add	r0, pc
c0d0006a:	462a      	mov	r2, r5
c0d0006c:	f003 fba2 	bl	c0d037b4 <nvm_write>
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00070:	4620      	mov	r0, r4
c0d00072:	f004 fb3d 	bl	c0d046f0 <USB_power>
            USB_power(1);
c0d00076:	4628      	mov	r0, r5
c0d00078:	f004 fb3a 	bl	c0d046f0 <USB_power>

            ui_idle();
c0d0007c:	f002 fb3e 	bl	c0d026fc <ui_idle>

            sample_main();
c0d00080:	f002 fb8c 	bl	c0d0279c <sample_main>
        }
        CATCH_OTHER(e) {
        }
        FINALLY {
c0d00084:	f002 ff38 	bl	c0d02ef8 <try_context_get>
c0d00088:	a91f      	add	r1, sp, #124	; 0x7c
c0d0008a:	4288      	cmp	r0, r1
c0d0008c:	d103      	bne.n	c0d00096 <_nvram_data_size+0x56>
c0d0008e:	f002 ff35 	bl	c0d02efc <try_context_get_previous>
c0d00092:	f002 fdc2 	bl	c0d02c1a <try_context_set>
c0d00096:	a81f      	add	r0, sp, #124	; 0x7c
        }
    }
    END_TRY;
c0d00098:	8d00      	ldrh	r0, [r0, #40]	; 0x28
c0d0009a:	2800      	cmp	r0, #0
c0d0009c:	d102      	bne.n	c0d000a4 <_nvram_data_size+0x64>
}
c0d0009e:	2000      	movs	r0, #0
c0d000a0:	b02a      	add	sp, #168	; 0xa8
c0d000a2:	bdb0      	pop	{r4, r5, r7, pc}
        CATCH_OTHER(e) {
        }
        FINALLY {
        }
    }
    END_TRY;
c0d000a4:	f002 ff23 	bl	c0d02eee <os_longjmp>
c0d000a8:	20001934 	.word	0x20001934
c0d000ac:	20001938 	.word	0x20001938
c0d000b0:	20001930 	.word	0x20001930
c0d000b4:	20001880 	.word	0x20001880
c0d000b8:	0000ffff 	.word	0x0000ffff
c0d000bc:	00004f2a 	.word	0x00004f2a
c0d000c0:	00004f14 	.word	0x00004f14

c0d000c4 <core25519>:
	t[0]++;
	mul25519(y2, t, x);
}

/* P = kG   and  s = sign(P)/k  */
void core25519(k25519 Px, k25519 s, const k25519 k, const k25519 Gx) {
c0d000c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000c6:	b0f1      	sub	sp, #452	; 0x1c4
c0d000c8:	4617      	mov	r7, r2
c0d000ca:	9105      	str	r1, [sp, #20]
c0d000cc:	9004      	str	r0, [sp, #16]
	i25519 dx, x[2], z[2], t1, t2, t3, t4;
	unsigned i, j;

	/* unpack the base */
	if (Gx)
c0d000ce:	2b00      	cmp	r3, #0
c0d000d0:	d07c      	beq.n	c0d001cc <core25519+0x108>
#define X(i) ((int64_t) x[i])
#define m64(arg1,arg2) ((int64_t) (arg1) * (arg2))

/* Convert to internal format from little-endian byte format */
static void unpack25519(i25519 x, const k25519 m) {
	x[0] =  M( 0)         | M( 1)<<8 | M( 2)<<16 | (M( 3)& 3)<<24;
c0d000d2:	7818      	ldrb	r0, [r3, #0]
c0d000d4:	7859      	ldrb	r1, [r3, #1]
c0d000d6:	0209      	lsls	r1, r1, #8
c0d000d8:	4301      	orrs	r1, r0
c0d000da:	7898      	ldrb	r0, [r3, #2]
c0d000dc:	0400      	lsls	r0, r0, #16
c0d000de:	4308      	orrs	r0, r1
c0d000e0:	78d9      	ldrb	r1, [r3, #3]
c0d000e2:	2203      	movs	r2, #3
c0d000e4:	400a      	ands	r2, r1
c0d000e6:	0612      	lsls	r2, r2, #24
c0d000e8:	4302      	orrs	r2, r0
c0d000ea:	9267      	str	r2, [sp, #412]	; 0x19c
	x[1] = (M( 3)&~ 3)>>2 | M( 4)<<6 | M( 5)<<14 | (M( 6)& 7)<<22;
c0d000ec:	0888      	lsrs	r0, r1, #2
c0d000ee:	7919      	ldrb	r1, [r3, #4]
c0d000f0:	0189      	lsls	r1, r1, #6
c0d000f2:	4301      	orrs	r1, r0
c0d000f4:	7958      	ldrb	r0, [r3, #5]
c0d000f6:	0382      	lsls	r2, r0, #14
c0d000f8:	430a      	orrs	r2, r1
c0d000fa:	7999      	ldrb	r1, [r3, #6]
c0d000fc:	2007      	movs	r0, #7
	x[2] = (M( 6)&~ 7)>>3 | M( 7)<<5 | M( 8)<<13 | (M( 9)&31)<<21;
c0d000fe:	08cc      	lsrs	r4, r1, #3
#define m64(arg1,arg2) ((int64_t) (arg1) * (arg2))

/* Convert to internal format from little-endian byte format */
static void unpack25519(i25519 x, const k25519 m) {
	x[0] =  M( 0)         | M( 1)<<8 | M( 2)<<16 | (M( 3)& 3)<<24;
	x[1] = (M( 3)&~ 3)>>2 | M( 4)<<6 | M( 5)<<14 | (M( 6)& 7)<<22;
c0d00100:	4001      	ands	r1, r0
c0d00102:	0589      	lsls	r1, r1, #22
c0d00104:	4311      	orrs	r1, r2
c0d00106:	9168      	str	r1, [sp, #416]	; 0x1a0
	x[2] = (M( 6)&~ 7)>>3 | M( 7)<<5 | M( 8)<<13 | (M( 9)&31)<<21;
c0d00108:	79d9      	ldrb	r1, [r3, #7]
c0d0010a:	0149      	lsls	r1, r1, #5
c0d0010c:	4321      	orrs	r1, r4
c0d0010e:	7a1a      	ldrb	r2, [r3, #8]
c0d00110:	0352      	lsls	r2, r2, #13
c0d00112:	430a      	orrs	r2, r1
c0d00114:	7a59      	ldrb	r1, [r3, #9]
c0d00116:	241f      	movs	r4, #31
c0d00118:	400c      	ands	r4, r1
c0d0011a:	0564      	lsls	r4, r4, #21
c0d0011c:	4314      	orrs	r4, r2
c0d0011e:	9469      	str	r4, [sp, #420]	; 0x1a4
	x[3] = (M( 9)&~31)>>5 | M(10)<<3 | M(11)<<11 | (M(12)&63)<<19;
c0d00120:	0949      	lsrs	r1, r1, #5
c0d00122:	7a9a      	ldrb	r2, [r3, #10]
c0d00124:	00d2      	lsls	r2, r2, #3
c0d00126:	430a      	orrs	r2, r1
c0d00128:	7ad9      	ldrb	r1, [r3, #11]
c0d0012a:	02cc      	lsls	r4, r1, #11
c0d0012c:	4314      	orrs	r4, r2
c0d0012e:	7b1a      	ldrb	r2, [r3, #12]
c0d00130:	213f      	movs	r1, #63	; 0x3f
	x[4] = (M(12)&~63)>>6 | M(13)<<2 | M(14)<<10 |  M(15)    <<18;
c0d00132:	0995      	lsrs	r5, r2, #6
/* Convert to internal format from little-endian byte format */
static void unpack25519(i25519 x, const k25519 m) {
	x[0] =  M( 0)         | M( 1)<<8 | M( 2)<<16 | (M( 3)& 3)<<24;
	x[1] = (M( 3)&~ 3)>>2 | M( 4)<<6 | M( 5)<<14 | (M( 6)& 7)<<22;
	x[2] = (M( 6)&~ 7)>>3 | M( 7)<<5 | M( 8)<<13 | (M( 9)&31)<<21;
	x[3] = (M( 9)&~31)>>5 | M(10)<<3 | M(11)<<11 | (M(12)&63)<<19;
c0d00134:	400a      	ands	r2, r1
c0d00136:	04d2      	lsls	r2, r2, #19
c0d00138:	4322      	orrs	r2, r4
c0d0013a:	926a      	str	r2, [sp, #424]	; 0x1a8
	x[4] = (M(12)&~63)>>6 | M(13)<<2 | M(14)<<10 |  M(15)    <<18;
c0d0013c:	7b5a      	ldrb	r2, [r3, #13]
c0d0013e:	0092      	lsls	r2, r2, #2
c0d00140:	432a      	orrs	r2, r5
c0d00142:	7b9c      	ldrb	r4, [r3, #14]
c0d00144:	02a4      	lsls	r4, r4, #10
c0d00146:	4314      	orrs	r4, r2
c0d00148:	7bda      	ldrb	r2, [r3, #15]
c0d0014a:	0492      	lsls	r2, r2, #18
c0d0014c:	4322      	orrs	r2, r4
c0d0014e:	926b      	str	r2, [sp, #428]	; 0x1ac
	x[5] =  M(16)         | M(17)<<8 | M(18)<<16 | (M(19)& 1)<<24;
c0d00150:	7c1a      	ldrb	r2, [r3, #16]
c0d00152:	7c5c      	ldrb	r4, [r3, #17]
c0d00154:	0224      	lsls	r4, r4, #8
c0d00156:	4314      	orrs	r4, r2
c0d00158:	7c9a      	ldrb	r2, [r3, #18]
c0d0015a:	0412      	lsls	r2, r2, #16
c0d0015c:	4322      	orrs	r2, r4
c0d0015e:	7cdc      	ldrb	r4, [r3, #19]
c0d00160:	2501      	movs	r5, #1
c0d00162:	4025      	ands	r5, r4
c0d00164:	062d      	lsls	r5, r5, #24
c0d00166:	4315      	orrs	r5, r2
c0d00168:	956c      	str	r5, [sp, #432]	; 0x1b0
	x[6] = (M(19)&~ 1)>>1 | M(20)<<7 | M(21)<<15 | (M(22)& 7)<<23;
c0d0016a:	0862      	lsrs	r2, r4, #1
c0d0016c:	7d1c      	ldrb	r4, [r3, #20]
c0d0016e:	01e4      	lsls	r4, r4, #7
c0d00170:	4314      	orrs	r4, r2
c0d00172:	7d5a      	ldrb	r2, [r3, #21]
c0d00174:	03d2      	lsls	r2, r2, #15
c0d00176:	4322      	orrs	r2, r4
c0d00178:	7d9c      	ldrb	r4, [r3, #22]
c0d0017a:	4020      	ands	r0, r4
c0d0017c:	05c0      	lsls	r0, r0, #23
c0d0017e:	4310      	orrs	r0, r2
c0d00180:	906d      	str	r0, [sp, #436]	; 0x1b4
	x[7] = (M(22)&~ 7)>>3 | M(23)<<5 | M(24)<<13 | (M(25)&15)<<21;
c0d00182:	08e0      	lsrs	r0, r4, #3
c0d00184:	7dda      	ldrb	r2, [r3, #23]
c0d00186:	0152      	lsls	r2, r2, #5
c0d00188:	4302      	orrs	r2, r0
c0d0018a:	7e18      	ldrb	r0, [r3, #24]
c0d0018c:	0340      	lsls	r0, r0, #13
c0d0018e:	4310      	orrs	r0, r2
c0d00190:	7e5a      	ldrb	r2, [r3, #25]
c0d00192:	240f      	movs	r4, #15
c0d00194:	4014      	ands	r4, r2
c0d00196:	0564      	lsls	r4, r4, #21
c0d00198:	4304      	orrs	r4, r0
c0d0019a:	946e      	str	r4, [sp, #440]	; 0x1b8
	x[8] = (M(25)&~15)>>4 | M(26)<<4 | M(27)<<12 | (M(28)&63)<<20;
c0d0019c:	0910      	lsrs	r0, r2, #4
c0d0019e:	7e9a      	ldrb	r2, [r3, #26]
c0d001a0:	0112      	lsls	r2, r2, #4
c0d001a2:	4302      	orrs	r2, r0
c0d001a4:	7ed8      	ldrb	r0, [r3, #27]
c0d001a6:	0300      	lsls	r0, r0, #12
c0d001a8:	4310      	orrs	r0, r2
c0d001aa:	7f1a      	ldrb	r2, [r3, #28]
c0d001ac:	4011      	ands	r1, r2
c0d001ae:	0509      	lsls	r1, r1, #20
c0d001b0:	4301      	orrs	r1, r0
c0d001b2:	916f      	str	r1, [sp, #444]	; 0x1bc
	x[9] = (M(28)&~63)>>6 | M(29)<<2 | M(30)<<10 |  M(31)    <<18;
c0d001b4:	0990      	lsrs	r0, r2, #6
c0d001b6:	7f59      	ldrb	r1, [r3, #29]
c0d001b8:	0089      	lsls	r1, r1, #2
c0d001ba:	4301      	orrs	r1, r0
c0d001bc:	7f98      	ldrb	r0, [r3, #30]
c0d001be:	0280      	lsls	r0, r0, #10
c0d001c0:	4308      	orrs	r0, r1
c0d001c2:	7fd9      	ldrb	r1, [r3, #31]
c0d001c4:	0489      	lsls	r1, r1, #18
c0d001c6:	4301      	orrs	r1, r0
c0d001c8:	9170      	str	r1, [sp, #448]	; 0x1c0
c0d001ca:	e006      	b.n	c0d001da <core25519+0x116>
}

/* Set a number to value, which must be in range -185861411 .. 185861411 */
static void set25519(i25519 out, const int32_t in) {
	int i;
	out[0] = in;
c0d001cc:	2009      	movs	r0, #9
c0d001ce:	9067      	str	r0, [sp, #412]	; 0x19c
c0d001d0:	a867      	add	r0, sp, #412	; 0x19c
	for (i = 1; i < 10; i++)
c0d001d2:	1d00      	adds	r0, r0, #4
		out[i] = 0;
c0d001d4:	2124      	movs	r1, #36	; 0x24
c0d001d6:	f004 fbc1 	bl	c0d0495c <__aeabi_memclr>
}

/* Set a number to value, which must be in range -185861411 .. 185861411 */
static void set25519(i25519 out, const int32_t in) {
	int i;
	out[0] = in;
c0d001da:	2001      	movs	r0, #1
c0d001dc:	9013      	str	r0, [sp, #76]	; 0x4c
c0d001de:	9053      	str	r0, [sp, #332]	; 0x14c
c0d001e0:	ad53      	add	r5, sp, #332	; 0x14c
	for (i = 1; i < 10; i++)
c0d001e2:	1d28      	adds	r0, r5, #4
		out[i] = 0;
c0d001e4:	2124      	movs	r1, #36	; 0x24
c0d001e6:	9116      	str	r1, [sp, #88]	; 0x58
c0d001e8:	f004 fbb8 	bl	c0d0495c <__aeabi_memclr>
c0d001ec:	ac3f      	add	r4, sp, #252	; 0xfc
c0d001ee:	2128      	movs	r1, #40	; 0x28
c0d001f0:	4620      	mov	r0, r4
c0d001f2:	9112      	str	r1, [sp, #72]	; 0x48
c0d001f4:	f004 fbb2 	bl	c0d0495c <__aeabi_memclr>
}

/* Copy a number */
static void cpy25519(i25519 out, const i25519 in) {
	int i;
	for (i = 0; i < 10; i++)
c0d001f8:	3528      	adds	r5, #40	; 0x28
c0d001fa:	a867      	add	r0, sp, #412	; 0x19c
c0d001fc:	9503      	str	r5, [sp, #12]
		out[i] = in[i];
c0d001fe:	4629      	mov	r1, r5
c0d00200:	c82c      	ldmia	r0!, {r2, r3, r5}
c0d00202:	c12c      	stmia	r1!, {r2, r3, r5}
c0d00204:	c82c      	ldmia	r0!, {r2, r3, r5}
c0d00206:	c12c      	stmia	r1!, {r2, r3, r5}
c0d00208:	c86c      	ldmia	r0!, {r2, r3, r5, r6}
c0d0020a:	c16c      	stmia	r1!, {r2, r3, r5, r6}
}

/* Set a number to value, which must be in range -185861411 .. 185861411 */
static void set25519(i25519 out, const int32_t in) {
	int i;
	out[0] = in;
c0d0020c:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d0020e:	9049      	str	r0, [sp, #292]	; 0x124
	for (i = 1; i < 10; i++)
c0d00210:	4620      	mov	r0, r4
c0d00212:	302c      	adds	r0, #44	; 0x2c
		out[i] = 0;
c0d00214:	9916      	ldr	r1, [sp, #88]	; 0x58
c0d00216:	f004 fba1 	bl	c0d0495c <__aeabi_memclr>
	set25519(x[0], 1);
	set25519(z[0], 0);

	/* 1G = G */
	cpy25519(x[1], dx);
	set25519(z[1], 1);
c0d0021a:	3428      	adds	r4, #40	; 0x28
c0d0021c:	9402      	str	r4, [sp, #8]
c0d0021e:	201f      	movs	r0, #31

	for (i = 32; i--; ) {
c0d00220:	9707      	str	r7, [sp, #28]
c0d00222:	9008      	str	r0, [sp, #32]
c0d00224:	1838      	adds	r0, r7, r0
c0d00226:	9009      	str	r0, [sp, #36]	; 0x24
c0d00228:	2000      	movs	r0, #0
c0d0022a:	9006      	str	r0, [sp, #24]
c0d0022c:	43c1      	mvns	r1, r0
c0d0022e:	2507      	movs	r5, #7
c0d00230:	910a      	str	r1, [sp, #40]	; 0x28
		for (j = 8; j--; ) {
			/* swap arguments depending on bit */
			const int bit1 = k[i] >> j & 1;
c0d00232:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d00234:	7806      	ldrb	r6, [r0, #0]
			const int bit0 = ~k[i] >> j & 1;
c0d00236:	4630      	mov	r0, r6
c0d00238:	4048      	eors	r0, r1
c0d0023a:	40e8      	lsrs	r0, r5
c0d0023c:	9913      	ldr	r1, [sp, #76]	; 0x4c
c0d0023e:	4008      	ands	r0, r1
			int32_t *const ax = x[bit0];
c0d00240:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d00242:	4348      	muls	r0, r1
c0d00244:	a953      	add	r1, sp, #332	; 0x14c
c0d00246:	9115      	str	r1, [sp, #84]	; 0x54
c0d00248:	180c      	adds	r4, r1, r0
c0d0024a:	a93f      	add	r1, sp, #252	; 0xfc
			int32_t *const az = z[bit0];
c0d0024c:	9116      	str	r1, [sp, #88]	; 0x58
c0d0024e:	180f      	adds	r7, r1, r0


/* t1 = ax + az
 * t2 = ax - az  */
static inline void mont_prep(i25519 t1, i25519 t2, i25519 ax, i25519 az) {
	add25519(t1, ax, az);
c0d00250:	970c      	str	r7, [sp, #48]	; 0x30
c0d00252:	a835      	add	r0, sp, #212	; 0xd4
c0d00254:	900d      	str	r0, [sp, #52]	; 0x34
c0d00256:	4621      	mov	r1, r4
c0d00258:	9511      	str	r5, [sp, #68]	; 0x44
c0d0025a:	463a      	mov	r2, r7
c0d0025c:	f001 f92f 	bl	c0d014be <add25519>
c0d00260:	a82b      	add	r0, sp, #172	; 0xac
	sub25519(t2, ax, az);
c0d00262:	900b      	str	r0, [sp, #44]	; 0x2c
c0d00264:	4621      	mov	r1, r4
c0d00266:	463a      	mov	r2, r7
c0d00268:	f001 fc52 	bl	c0d01b10 <sub25519>
	set25519(z[1], 1);

	for (i = 32; i--; ) {
		for (j = 8; j--; ) {
			/* swap arguments depending on bit */
			const int bit1 = k[i] >> j & 1;
c0d0026c:	40ee      	lsrs	r6, r5
c0d0026e:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d00270:	4006      	ands	r6, r0
			const int bit0 = ~k[i] >> j & 1;
			int32_t *const ax = x[bit0];
			int32_t *const az = z[bit0];
			int32_t *const bx = x[bit1];
c0d00272:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d00274:	4346      	muls	r6, r0
c0d00276:	9610      	str	r6, [sp, #64]	; 0x40
c0d00278:	9815      	ldr	r0, [sp, #84]	; 0x54
c0d0027a:	1981      	adds	r1, r0, r6
			int32_t *const bz = z[bit1];
c0d0027c:	9816      	ldr	r0, [sp, #88]	; 0x58
c0d0027e:	1985      	adds	r5, r0, r6


/* t1 = ax + az
 * t2 = ax - az  */
static inline void mont_prep(i25519 t1, i25519 t2, i25519 ax, i25519 az) {
	add25519(t1, ax, az);
c0d00280:	950f      	str	r5, [sp, #60]	; 0x3c
c0d00282:	a821      	add	r0, sp, #132	; 0x84
c0d00284:	9015      	str	r0, [sp, #84]	; 0x54
c0d00286:	460e      	mov	r6, r1
c0d00288:	960e      	str	r6, [sp, #56]	; 0x38
c0d0028a:	462a      	mov	r2, r5
c0d0028c:	f001 f917 	bl	c0d014be <add25519>
c0d00290:	a817      	add	r0, sp, #92	; 0x5c
	sub25519(t2, ax, az);
c0d00292:	9014      	str	r0, [sp, #80]	; 0x50
c0d00294:	4631      	mov	r1, r6
c0d00296:	462a      	mov	r2, r5
c0d00298:	f001 fc3a 	bl	c0d01b10 <sub25519>
 *  X(Q) = (t3+t4)/(t3-t4)
 *  X(P-Q) = dx
 * clobbers t1 and t2, preserves t3 and t4  */
static inline void mont_add(i25519 t1, i25519 t2, i25519 t3, i25519 t4,
			i25519 ax, i25519 az, const i25519 dx) {
	mul25519(ax, t2, t3);
c0d0029c:	4620      	mov	r0, r4
c0d0029e:	9f0b      	ldr	r7, [sp, #44]	; 0x2c
c0d002a0:	4639      	mov	r1, r7
c0d002a2:	9a15      	ldr	r2, [sp, #84]	; 0x54
c0d002a4:	f000 fbee 	bl	c0d00a84 <mul25519>
c0d002a8:	9d0c      	ldr	r5, [sp, #48]	; 0x30
	mul25519(az, t1, t4);
c0d002aa:	4628      	mov	r0, r5
c0d002ac:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d002ae:	4631      	mov	r1, r6
c0d002b0:	9a14      	ldr	r2, [sp, #80]	; 0x50
c0d002b2:	f000 fbe7 	bl	c0d00a84 <mul25519>
	add25519(t1, ax, az);
c0d002b6:	4630      	mov	r0, r6
c0d002b8:	4621      	mov	r1, r4
c0d002ba:	462a      	mov	r2, r5
c0d002bc:	f001 f8ff 	bl	c0d014be <add25519>
	sub25519(t2, ax, az);
c0d002c0:	4638      	mov	r0, r7
c0d002c2:	4621      	mov	r1, r4
c0d002c4:	462a      	mov	r2, r5
c0d002c6:	f001 fc23 	bl	c0d01b10 <sub25519>
	sqr25519(ax, t1);
c0d002ca:	4620      	mov	r0, r4
c0d002cc:	4631      	mov	r1, r6
c0d002ce:	f001 f921 	bl	c0d01514 <sqr25519>
	sqr25519(t1, t2);
c0d002d2:	4630      	mov	r0, r6
c0d002d4:	463c      	mov	r4, r7
c0d002d6:	4621      	mov	r1, r4
c0d002d8:	f001 f91c 	bl	c0d01514 <sqr25519>
c0d002dc:	aa67      	add	r2, sp, #412	; 0x19c
	mul25519(az, t1, dx);
c0d002de:	4628      	mov	r0, r5
c0d002e0:	4631      	mov	r1, r6
c0d002e2:	f000 fbcf 	bl	c0d00a84 <mul25519>
 *  X(B) = bx/bz
 *  X(Q) = (t3+t4)/(t3-t4)
 * clobbers t1 and t2, preserves t3 and t4  */
static inline void mont_dbl(i25519 t1, i25519 t2, i25519 t3, i25519 t4,
			i25519 bx, i25519 bz) {
	sqr25519(t1, t3);
c0d002e6:	4630      	mov	r0, r6
c0d002e8:	4637      	mov	r7, r6
c0d002ea:	9915      	ldr	r1, [sp, #84]	; 0x54
c0d002ec:	f001 f912 	bl	c0d01514 <sqr25519>
	sqr25519(t2, t4);
c0d002f0:	4620      	mov	r0, r4
c0d002f2:	9914      	ldr	r1, [sp, #80]	; 0x50
c0d002f4:	f001 f90e 	bl	c0d01514 <sqr25519>
	mul25519(bx, t1, t2);
c0d002f8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d002fa:	4639      	mov	r1, r7
c0d002fc:	4622      	mov	r2, r4
c0d002fe:	4626      	mov	r6, r4
c0d00300:	f000 fbc0 	bl	c0d00a84 <mul25519>
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
}
static void sub25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] - y[0];	xy[1] = x[1] - y[1];
c0d00304:	982b      	ldr	r0, [sp, #172]	; 0xac
c0d00306:	9935      	ldr	r1, [sp, #212]	; 0xd4
c0d00308:	1a08      	subs	r0, r1, r0
c0d0030a:	902b      	str	r0, [sp, #172]	; 0xac
c0d0030c:	982c      	ldr	r0, [sp, #176]	; 0xb0
c0d0030e:	9936      	ldr	r1, [sp, #216]	; 0xd8
c0d00310:	1a08      	subs	r0, r1, r0
c0d00312:	902c      	str	r0, [sp, #176]	; 0xb0
	xy[2] = x[2] - y[2];	xy[3] = x[3] - y[3];
c0d00314:	982d      	ldr	r0, [sp, #180]	; 0xb4
c0d00316:	9937      	ldr	r1, [sp, #220]	; 0xdc
c0d00318:	1a08      	subs	r0, r1, r0
c0d0031a:	902d      	str	r0, [sp, #180]	; 0xb4
c0d0031c:	982e      	ldr	r0, [sp, #184]	; 0xb8
c0d0031e:	9938      	ldr	r1, [sp, #224]	; 0xe0
c0d00320:	1a08      	subs	r0, r1, r0
c0d00322:	902e      	str	r0, [sp, #184]	; 0xb8
	xy[4] = x[4] - y[4];	xy[5] = x[5] - y[5];
c0d00324:	982f      	ldr	r0, [sp, #188]	; 0xbc
c0d00326:	9939      	ldr	r1, [sp, #228]	; 0xe4
c0d00328:	1a08      	subs	r0, r1, r0
c0d0032a:	902f      	str	r0, [sp, #188]	; 0xbc
c0d0032c:	9830      	ldr	r0, [sp, #192]	; 0xc0
c0d0032e:	993a      	ldr	r1, [sp, #232]	; 0xe8
c0d00330:	1a08      	subs	r0, r1, r0
c0d00332:	9030      	str	r0, [sp, #192]	; 0xc0
	xy[6] = x[6] - y[6];	xy[7] = x[7] - y[7];
c0d00334:	9831      	ldr	r0, [sp, #196]	; 0xc4
c0d00336:	993b      	ldr	r1, [sp, #236]	; 0xec
c0d00338:	1a08      	subs	r0, r1, r0
c0d0033a:	9031      	str	r0, [sp, #196]	; 0xc4
c0d0033c:	9832      	ldr	r0, [sp, #200]	; 0xc8
c0d0033e:	993c      	ldr	r1, [sp, #240]	; 0xf0
c0d00340:	1a08      	subs	r0, r1, r0
c0d00342:	9032      	str	r0, [sp, #200]	; 0xc8
	xy[8] = x[8] - y[8];	xy[9] = x[9] - y[9];
c0d00344:	9833      	ldr	r0, [sp, #204]	; 0xcc
c0d00346:	993d      	ldr	r1, [sp, #244]	; 0xf4
c0d00348:	1a08      	subs	r0, r1, r0
c0d0034a:	9033      	str	r0, [sp, #204]	; 0xcc
c0d0034c:	9834      	ldr	r0, [sp, #208]	; 0xd0
c0d0034e:	993e      	ldr	r1, [sp, #248]	; 0xf8
c0d00350:	1a08      	subs	r0, r1, r0
c0d00352:	9034      	str	r0, [sp, #208]	; 0xd0
			i25519 bx, i25519 bz) {
	sqr25519(t1, t3);
	sqr25519(t2, t4);
	mul25519(bx, t1, t2);
	sub25519(t2, t1, t2);
	mul25519small(bz, t2, 121665);
c0d00354:	4afc      	ldr	r2, [pc, #1008]	; (c0d00748 <core25519+0x684>)
c0d00356:	9c0f      	ldr	r4, [sp, #60]	; 0x3c
c0d00358:	4620      	mov	r0, r4
c0d0035a:	4631      	mov	r1, r6
c0d0035c:	f001 fd2a 	bl	c0d01db4 <mul25519small>

/* Add/subtract two numbers.  The inputs must be in reduced form, and the 
 * output isn't, so to do another addition or subtraction on the output, 
 * first multiply it by one to reduce it. */
static void add25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] + y[0];	xy[1] = x[1] + y[1];
c0d00360:	9816      	ldr	r0, [sp, #88]	; 0x58
c0d00362:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d00364:	5840      	ldr	r0, [r0, r1]
c0d00366:	9935      	ldr	r1, [sp, #212]	; 0xd4
c0d00368:	1840      	adds	r0, r0, r1
c0d0036a:	9035      	str	r0, [sp, #212]	; 0xd4
c0d0036c:	6860      	ldr	r0, [r4, #4]
c0d0036e:	9936      	ldr	r1, [sp, #216]	; 0xd8
c0d00370:	1840      	adds	r0, r0, r1
c0d00372:	9036      	str	r0, [sp, #216]	; 0xd8
	xy[2] = x[2] + y[2];	xy[3] = x[3] + y[3];
c0d00374:	68a0      	ldr	r0, [r4, #8]
c0d00376:	9937      	ldr	r1, [sp, #220]	; 0xdc
c0d00378:	1840      	adds	r0, r0, r1
c0d0037a:	9037      	str	r0, [sp, #220]	; 0xdc
c0d0037c:	68e0      	ldr	r0, [r4, #12]
c0d0037e:	9938      	ldr	r1, [sp, #224]	; 0xe0
c0d00380:	1840      	adds	r0, r0, r1
c0d00382:	9038      	str	r0, [sp, #224]	; 0xe0
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
c0d00384:	6920      	ldr	r0, [r4, #16]
c0d00386:	9939      	ldr	r1, [sp, #228]	; 0xe4
c0d00388:	1840      	adds	r0, r0, r1
c0d0038a:	9039      	str	r0, [sp, #228]	; 0xe4
c0d0038c:	6960      	ldr	r0, [r4, #20]
c0d0038e:	993a      	ldr	r1, [sp, #232]	; 0xe8
c0d00390:	1840      	adds	r0, r0, r1
c0d00392:	903a      	str	r0, [sp, #232]	; 0xe8
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
c0d00394:	69a0      	ldr	r0, [r4, #24]
c0d00396:	993b      	ldr	r1, [sp, #236]	; 0xec
c0d00398:	1840      	adds	r0, r0, r1
c0d0039a:	903b      	str	r0, [sp, #236]	; 0xec
c0d0039c:	69e0      	ldr	r0, [r4, #28]
c0d0039e:	993c      	ldr	r1, [sp, #240]	; 0xf0
c0d003a0:	1840      	adds	r0, r0, r1
c0d003a2:	903c      	str	r0, [sp, #240]	; 0xf0
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
c0d003a4:	6a20      	ldr	r0, [r4, #32]
c0d003a6:	993d      	ldr	r1, [sp, #244]	; 0xf4
c0d003a8:	1840      	adds	r0, r0, r1
c0d003aa:	903d      	str	r0, [sp, #244]	; 0xf4
c0d003ac:	6a63      	ldr	r3, [r4, #36]	; 0x24
c0d003ae:	993e      	ldr	r1, [sp, #248]	; 0xf8
c0d003b0:	1859      	adds	r1, r3, r1
c0d003b2:	913e      	str	r1, [sp, #248]	; 0xf8
	sqr25519(t2, t4);
	mul25519(bx, t1, t2);
	sub25519(t2, t1, t2);
	mul25519small(bz, t2, 121665);
	add25519(t1, t1, bz);
	mul25519(bz, t1, t2);
c0d003b4:	4620      	mov	r0, r4
c0d003b6:	4639      	mov	r1, r7
c0d003b8:	4632      	mov	r2, r6
c0d003ba:	f000 fb63 	bl	c0d00a84 <mul25519>
c0d003be:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d003c0:	9a11      	ldr	r2, [sp, #68]	; 0x44
	/* 1G = G */
	cpy25519(x[1], dx);
	set25519(z[1], 1);

	for (i = 32; i--; ) {
		for (j = 8; j--; ) {
c0d003c2:	1e55      	subs	r5, r2, #1
c0d003c4:	2a00      	cmp	r2, #0
c0d003c6:	d000      	beq.n	c0d003ca <core25519+0x306>
c0d003c8:	e733      	b.n	c0d00232 <core25519+0x16e>
c0d003ca:	9908      	ldr	r1, [sp, #32]

	/* 1G = G */
	cpy25519(x[1], dx);
	set25519(z[1], 1);

	for (i = 32; i--; ) {
c0d003cc:	1e48      	subs	r0, r1, #1
c0d003ce:	2900      	cmp	r1, #0
c0d003d0:	9f07      	ldr	r7, [sp, #28]
c0d003d2:	d000      	beq.n	c0d003d6 <core25519+0x312>
c0d003d4:	e725      	b.n	c0d00222 <core25519+0x15e>
c0d003d6:	ac35      	add	r4, sp, #212	; 0xd4
c0d003d8:	a93f      	add	r1, sp, #252	; 0xfc
			mont_add(t1, t2, t3, t4, ax, az, dx);
			mont_dbl(t1, t2, t3, t4, bx, bz);
		}
	}

	recip25519(t1, z[0], 0);
c0d003da:	4620      	mov	r0, r4
c0d003dc:	f000 fa62 	bl	c0d008a4 <recip25519>
c0d003e0:	a867      	add	r0, sp, #412	; 0x19c
c0d003e2:	a953      	add	r1, sp, #332	; 0x14c
	mul25519(dx, x[0], t1);
c0d003e4:	4622      	mov	r2, r4
c0d003e6:	f000 fb4d 	bl	c0d00a84 <mul25519>
c0d003ea:	48d8      	ldr	r0, [pc, #864]	; (c0d0074c <core25519+0x688>)
c0d003ec:	9015      	str	r0, [sp, #84]	; 0x54
c0d003ee:	48d8      	ldr	r0, [pc, #864]	; (c0d00750 <core25519+0x68c>)
	if (Px != NULL) pack25519(dx, Px);
c0d003f0:	9016      	str	r0, [sp, #88]	; 0x58
c0d003f2:	9804      	ldr	r0, [sp, #16]
c0d003f4:	2800      	cmp	r0, #0
c0d003f6:	d100      	bne.n	c0d003fa <core25519+0x336>
c0d003f8:	e0b3      	b.n	c0d00562 <core25519+0x49e>
}


/* Check if reduced-form input >= 2^255-19 */
static inline int is_overflow(const i25519 x) {
	return ((x[0] > P26-19) & ((x[1] & x[3] & x[5] & x[7] & x[9]) == P25) &
c0d003fa:	9870      	ldr	r0, [sp, #448]	; 0x1c0
	                          ((x[2] & x[4] & x[6] & x[8]) == P26)
	       ) | (x[9] > P25);
c0d003fc:	9915      	ldr	r1, [sp, #84]	; 0x54
c0d003fe:	4288      	cmp	r0, r1
c0d00400:	9a13      	ldr	r2, [sp, #76]	; 0x4c
c0d00402:	4615      	mov	r5, r2
c0d00404:	dc00      	bgt.n	c0d00408 <core25519+0x344>
c0d00406:	9d06      	ldr	r5, [sp, #24]
}


/* Check if reduced-form input >= 2^255-19 */
static inline int is_overflow(const i25519 x) {
	return ((x[0] > P26-19) & ((x[1] & x[3] & x[5] & x[7] & x[9]) == P25) &
c0d00408:	9c67      	ldr	r4, [sp, #412]	; 0x19c
c0d0040a:	9916      	ldr	r1, [sp, #88]	; 0x58
c0d0040c:	428c      	cmp	r4, r1
c0d0040e:	4611      	mov	r1, r2
c0d00410:	dc00      	bgt.n	c0d00414 <core25519+0x350>
c0d00412:	9906      	ldr	r1, [sp, #24]
c0d00414:	9e68      	ldr	r6, [sp, #416]	; 0x1a0
c0d00416:	9b6a      	ldr	r3, [sp, #424]	; 0x1a8
c0d00418:	9312      	str	r3, [sp, #72]	; 0x48
c0d0041a:	4033      	ands	r3, r6
c0d0041c:	9f6c      	ldr	r7, [sp, #432]	; 0x1b0
c0d0041e:	401f      	ands	r7, r3
c0d00420:	9b6e      	ldr	r3, [sp, #440]	; 0x1b8
c0d00422:	403b      	ands	r3, r7
c0d00424:	4003      	ands	r3, r0
c0d00426:	9a15      	ldr	r2, [sp, #84]	; 0x54
c0d00428:	4293      	cmp	r3, r2
c0d0042a:	9b13      	ldr	r3, [sp, #76]	; 0x4c
c0d0042c:	d000      	beq.n	c0d00430 <core25519+0x36c>
c0d0042e:	9b06      	ldr	r3, [sp, #24]
c0d00430:	4019      	ands	r1, r3
	                          ((x[2] & x[4] & x[6] & x[8]) == P26)
c0d00432:	9f69      	ldr	r7, [sp, #420]	; 0x1a4
c0d00434:	9b6b      	ldr	r3, [sp, #428]	; 0x1ac
c0d00436:	9311      	str	r3, [sp, #68]	; 0x44
c0d00438:	403b      	ands	r3, r7
c0d0043a:	9a6d      	ldr	r2, [sp, #436]	; 0x1b4
c0d0043c:	9214      	str	r2, [sp, #80]	; 0x50
c0d0043e:	4013      	ands	r3, r2
c0d00440:	9a6f      	ldr	r2, [sp, #444]	; 0x1bc
c0d00442:	401a      	ands	r2, r3
c0d00444:	9b16      	ldr	r3, [sp, #88]	; 0x58
c0d00446:	3313      	adds	r3, #19
c0d00448:	429a      	cmp	r2, r3
c0d0044a:	d001      	beq.n	c0d00450 <core25519+0x38c>
c0d0044c:	9a06      	ldr	r2, [sp, #24]
c0d0044e:	9213      	str	r2, [sp, #76]	; 0x4c
}


/* Check if reduced-form input >= 2^255-19 */
static inline int is_overflow(const i25519 x) {
	return ((x[0] > P26-19) & ((x[1] & x[3] & x[5] & x[7] & x[9]) == P25) &
c0d00450:	9a13      	ldr	r2, [sp, #76]	; 0x4c
c0d00452:	4011      	ands	r1, r2
	                          ((x[2] & x[4] & x[6] & x[8]) == P26)
	       ) | (x[9] > P25);
c0d00454:	430d      	orrs	r5, r1
 * If you're unsure if the number is reduced, first multiply it by 1.  */
static void pack25519(const i25519 x, k25519 m) {
	int32_t ld = 0, ud = 0;
	int64_t t;
	check_reduced("pack input", x);
	ld = is_overflow(x) - (x[9] < 0);
c0d00456:	0fc0      	lsrs	r0, r0, #31
c0d00458:	1a28      	subs	r0, r5, r0
c0d0045a:	2213      	movs	r2, #19
	ud = ld * -(P25+1);
	ld *= 19;
c0d0045c:	4342      	muls	r2, r0
	t = ld + X(0) + (X(1) << 26);
c0d0045e:	17d3      	asrs	r3, r2, #31
c0d00460:	09b1      	lsrs	r1, r6, #6
c0d00462:	17f5      	asrs	r5, r6, #31
c0d00464:	06ad      	lsls	r5, r5, #26
c0d00466:	430d      	orrs	r5, r1
c0d00468:	06b6      	lsls	r6, r6, #26
c0d0046a:	17e1      	asrs	r1, r4, #31
c0d0046c:	1934      	adds	r4, r6, r4
c0d0046e:	4169      	adcs	r1, r5
c0d00470:	18a2      	adds	r2, r4, r2
c0d00472:	4159      	adcs	r1, r3
c0d00474:	9e04      	ldr	r6, [sp, #16]
	m[ 0] = t; m[ 1] = t >> 8; m[ 2] = t >> 16; m[ 3] = t >> 24;
c0d00476:	7032      	strb	r2, [r6, #0]
c0d00478:	0a13      	lsrs	r3, r2, #8
c0d0047a:	7073      	strb	r3, [r6, #1]
c0d0047c:	0c13      	lsrs	r3, r2, #16
c0d0047e:	70b3      	strb	r3, [r6, #2]
c0d00480:	0e12      	lsrs	r2, r2, #24
c0d00482:	70f2      	strb	r2, [r6, #3]
	t = (t >> 32) + (X(2) << 19);
c0d00484:	17ca      	asrs	r2, r1, #31
c0d00486:	0b7b      	lsrs	r3, r7, #13
c0d00488:	17fc      	asrs	r4, r7, #31
c0d0048a:	04e4      	lsls	r4, r4, #19
c0d0048c:	431c      	orrs	r4, r3
c0d0048e:	04fb      	lsls	r3, r7, #19
c0d00490:	18c9      	adds	r1, r1, r3
c0d00492:	4154      	adcs	r4, r2
	m[ 4] = t; m[ 5] = t >> 8; m[ 6] = t >> 16; m[ 7] = t >> 24;
c0d00494:	7131      	strb	r1, [r6, #4]
c0d00496:	0a0a      	lsrs	r2, r1, #8
c0d00498:	7172      	strb	r2, [r6, #5]
c0d0049a:	0c0a      	lsrs	r2, r1, #16
c0d0049c:	71b2      	strb	r2, [r6, #6]
c0d0049e:	0e09      	lsrs	r1, r1, #24
c0d004a0:	71f1      	strb	r1, [r6, #7]
	t = (t >> 32) + (X(3) << 13);
c0d004a2:	17e2      	asrs	r2, r4, #31
c0d004a4:	9d12      	ldr	r5, [sp, #72]	; 0x48
c0d004a6:	0ceb      	lsrs	r3, r5, #19
c0d004a8:	17e9      	asrs	r1, r5, #31
c0d004aa:	0349      	lsls	r1, r1, #13
c0d004ac:	4319      	orrs	r1, r3
c0d004ae:	036b      	lsls	r3, r5, #13
c0d004b0:	18e3      	adds	r3, r4, r3
c0d004b2:	4151      	adcs	r1, r2
	m[ 8] = t; m[ 9] = t >> 8; m[10] = t >> 16; m[11] = t >> 24;
c0d004b4:	7233      	strb	r3, [r6, #8]
c0d004b6:	0a1a      	lsrs	r2, r3, #8
c0d004b8:	7272      	strb	r2, [r6, #9]
c0d004ba:	0c1a      	lsrs	r2, r3, #16
c0d004bc:	72b2      	strb	r2, [r6, #10]
c0d004be:	0e1a      	lsrs	r2, r3, #24
c0d004c0:	72f2      	strb	r2, [r6, #11]
	t = (t >> 32) + (X(4) <<  6);
c0d004c2:	17cb      	asrs	r3, r1, #31
c0d004c4:	9d11      	ldr	r5, [sp, #68]	; 0x44
c0d004c6:	0eac      	lsrs	r4, r5, #26
c0d004c8:	17ea      	asrs	r2, r5, #31
c0d004ca:	0192      	lsls	r2, r2, #6
c0d004cc:	4322      	orrs	r2, r4
c0d004ce:	01ac      	lsls	r4, r5, #6
c0d004d0:	1861      	adds	r1, r4, r1
c0d004d2:	415a      	adcs	r2, r3
	m[12] = t; m[13] = t >> 8; m[14] = t >> 16; m[15] = t >> 24;
c0d004d4:	7331      	strb	r1, [r6, #12]
c0d004d6:	0a0b      	lsrs	r3, r1, #8
c0d004d8:	7373      	strb	r3, [r6, #13]
c0d004da:	0c0b      	lsrs	r3, r1, #16
c0d004dc:	73b3      	strb	r3, [r6, #14]
c0d004de:	0e09      	lsrs	r1, r1, #24
c0d004e0:	73f1      	strb	r1, [r6, #15]
	t = (t >> 32) + X(5) + (X(6) << 25);
c0d004e2:	17d1      	asrs	r1, r2, #31
c0d004e4:	9b6c      	ldr	r3, [sp, #432]	; 0x1b0
c0d004e6:	17dc      	asrs	r4, r3, #31
c0d004e8:	189a      	adds	r2, r3, r2
c0d004ea:	414c      	adcs	r4, r1
c0d004ec:	9d14      	ldr	r5, [sp, #80]	; 0x50
c0d004ee:	09eb      	lsrs	r3, r5, #7
c0d004f0:	17e9      	asrs	r1, r5, #31
c0d004f2:	0649      	lsls	r1, r1, #25
c0d004f4:	4319      	orrs	r1, r3
c0d004f6:	066b      	lsls	r3, r5, #25
c0d004f8:	18d2      	adds	r2, r2, r3
c0d004fa:	4161      	adcs	r1, r4
	m[16] = t; m[17] = t >> 8; m[18] = t >> 16; m[19] = t >> 24;
c0d004fc:	7432      	strb	r2, [r6, #16]
c0d004fe:	0a13      	lsrs	r3, r2, #8
c0d00500:	7473      	strb	r3, [r6, #17]
c0d00502:	0c13      	lsrs	r3, r2, #16
c0d00504:	74b3      	strb	r3, [r6, #18]
c0d00506:	0e12      	lsrs	r2, r2, #24
c0d00508:	74f2      	strb	r2, [r6, #19]
	t = (t >> 32) + (X(7) << 19);
c0d0050a:	17cb      	asrs	r3, r1, #31
c0d0050c:	9c6e      	ldr	r4, [sp, #440]	; 0x1b8
c0d0050e:	0b65      	lsrs	r5, r4, #13
c0d00510:	17e2      	asrs	r2, r4, #31
c0d00512:	04d2      	lsls	r2, r2, #19
c0d00514:	432a      	orrs	r2, r5
c0d00516:	04e4      	lsls	r4, r4, #19
c0d00518:	1861      	adds	r1, r4, r1
c0d0051a:	415a      	adcs	r2, r3
	m[20] = t; m[21] = t >> 8; m[22] = t >> 16; m[23] = t >> 24;
c0d0051c:	7531      	strb	r1, [r6, #20]
c0d0051e:	0a0b      	lsrs	r3, r1, #8
c0d00520:	7573      	strb	r3, [r6, #21]
c0d00522:	0c0b      	lsrs	r3, r1, #16
c0d00524:	75b3      	strb	r3, [r6, #22]
c0d00526:	0e09      	lsrs	r1, r1, #24
c0d00528:	75f1      	strb	r1, [r6, #23]
	t = (t >> 32) + (X(8) << 12);
c0d0052a:	17d3      	asrs	r3, r2, #31
c0d0052c:	9c6f      	ldr	r4, [sp, #444]	; 0x1bc
c0d0052e:	0d25      	lsrs	r5, r4, #20
c0d00530:	17e1      	asrs	r1, r4, #31
c0d00532:	0309      	lsls	r1, r1, #12
c0d00534:	4329      	orrs	r1, r5
c0d00536:	0324      	lsls	r4, r4, #12
c0d00538:	18a2      	adds	r2, r4, r2
c0d0053a:	4159      	adcs	r1, r3
	m[24] = t; m[25] = t >> 8; m[26] = t >> 16; m[27] = t >> 24;
c0d0053c:	7632      	strb	r2, [r6, #24]
c0d0053e:	0a13      	lsrs	r3, r2, #8
c0d00540:	7673      	strb	r3, [r6, #25]
c0d00542:	0c13      	lsrs	r3, r2, #16
c0d00544:	76b3      	strb	r3, [r6, #26]
c0d00546:	0e12      	lsrs	r2, r2, #24
c0d00548:	76f2      	strb	r2, [r6, #27]
static void pack25519(const i25519 x, k25519 m) {
	int32_t ld = 0, ud = 0;
	int64_t t;
	check_reduced("pack input", x);
	ld = is_overflow(x) - (x[9] < 0);
	ud = ld * -(P25+1);
c0d0054a:	0640      	lsls	r0, r0, #25
	m[16] = t; m[17] = t >> 8; m[18] = t >> 16; m[19] = t >> 24;
	t = (t >> 32) + (X(7) << 19);
	m[20] = t; m[21] = t >> 8; m[22] = t >> 16; m[23] = t >> 24;
	t = (t >> 32) + (X(8) << 12);
	m[24] = t; m[25] = t >> 8; m[26] = t >> 16; m[27] = t >> 24;
	t = (t >> 32) + ((X(9) + ud) << 6);
c0d0054c:	9a70      	ldr	r2, [sp, #448]	; 0x1c0
c0d0054e:	1a10      	subs	r0, r2, r0
c0d00550:	0180      	lsls	r0, r0, #6
c0d00552:	1840      	adds	r0, r0, r1
	m[28] = t; m[29] = t >> 8; m[30] = t >> 16; m[31] = t >> 24;
c0d00554:	7730      	strb	r0, [r6, #28]
c0d00556:	0a01      	lsrs	r1, r0, #8
c0d00558:	7771      	strb	r1, [r6, #29]
c0d0055a:	0c01      	lsrs	r1, r0, #16
c0d0055c:	77b1      	strb	r1, [r6, #30]
c0d0055e:	0e00      	lsrs	r0, r0, #24
c0d00560:	77f0      	strb	r0, [r6, #31]
	recip25519(t1, z[0], 0);
	mul25519(dx, x[0], t1);
	if (Px != NULL) pack25519(dx, Px);

	/* calculate s such that s abs(P) = G  .. assumes G is std base point */
	if (s) {
c0d00562:	9805      	ldr	r0, [sp, #20]
c0d00564:	2800      	cmp	r0, #0
c0d00566:	d100      	bne.n	c0d0056a <core25519+0x4a6>
c0d00568:	e18f      	b.n	c0d0088a <core25519+0x7c6>
c0d0056a:	ad2b      	add	r5, sp, #172	; 0xac
c0d0056c:	ac67      	add	r4, sp, #412	; 0x19c
}

/* Y^2 = X^3 + 486662 X^2 + X
 * t is a temporary  */
static inline void x_to_y2(i25519 t, i25519 y2, const i25519 x) {
	sqr25519(t, x);
c0d0056e:	4628      	mov	r0, r5
c0d00570:	4621      	mov	r1, r4
c0d00572:	f000 ffcf 	bl	c0d01514 <sqr25519>
c0d00576:	ae35      	add	r6, sp, #212	; 0xd4
	if (s) {
		x_to_y2(t2, t1, dx);	/* t1 = Py^2  */
		recip25519(t3, z[1], 0);	/* where Q=P+G ... */
		mul25519(t2, x[1], t3);	/* t2 = Qx  */
		add25519(t2, t2, dx);	/* t2 = Qx + Px  */
		t2[0] += 9 + 486662;	/* t2 = Qx + Px + Gx + 486662  */
c0d00578:	4fc5      	ldr	r7, [pc, #788]	; (c0d00890 <core25519+0x7cc>)

/* Y^2 = X^3 + 486662 X^2 + X
 * t is a temporary  */
static inline void x_to_y2(i25519 t, i25519 y2, const i25519 x) {
	sqr25519(t, x);
	mul25519small(y2, x, 486662);
c0d0057a:	4630      	mov	r0, r6
c0d0057c:	9614      	str	r6, [sp, #80]	; 0x50
c0d0057e:	4621      	mov	r1, r4
c0d00580:	463a      	mov	r2, r7
c0d00582:	f001 fc17 	bl	c0d01db4 <mul25519small>

/* Add/subtract two numbers.  The inputs must be in reduced form, and the 
 * output isn't, so to do another addition or subtraction on the output, 
 * first multiply it by one to reduce it. */
static void add25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] + y[0];	xy[1] = x[1] + y[1];
c0d00586:	982c      	ldr	r0, [sp, #176]	; 0xb0
c0d00588:	9936      	ldr	r1, [sp, #216]	; 0xd8
c0d0058a:	180a      	adds	r2, r1, r0
c0d0058c:	9835      	ldr	r0, [sp, #212]	; 0xd4
c0d0058e:	992b      	ldr	r1, [sp, #172]	; 0xac
c0d00590:	922c      	str	r2, [sp, #176]	; 0xb0
	xy[2] = x[2] + y[2];	xy[3] = x[3] + y[3];
c0d00592:	9a2d      	ldr	r2, [sp, #180]	; 0xb4
c0d00594:	9b37      	ldr	r3, [sp, #220]	; 0xdc
c0d00596:	189a      	adds	r2, r3, r2
c0d00598:	922d      	str	r2, [sp, #180]	; 0xb4
c0d0059a:	9a2e      	ldr	r2, [sp, #184]	; 0xb8
c0d0059c:	9b38      	ldr	r3, [sp, #224]	; 0xe0
c0d0059e:	189a      	adds	r2, r3, r2
c0d005a0:	922e      	str	r2, [sp, #184]	; 0xb8
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
c0d005a2:	9a2f      	ldr	r2, [sp, #188]	; 0xbc
c0d005a4:	9b39      	ldr	r3, [sp, #228]	; 0xe4
c0d005a6:	189a      	adds	r2, r3, r2
c0d005a8:	922f      	str	r2, [sp, #188]	; 0xbc
c0d005aa:	9a30      	ldr	r2, [sp, #192]	; 0xc0
c0d005ac:	9b3a      	ldr	r3, [sp, #232]	; 0xe8
c0d005ae:	189a      	adds	r2, r3, r2
c0d005b0:	9230      	str	r2, [sp, #192]	; 0xc0
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
c0d005b2:	9a31      	ldr	r2, [sp, #196]	; 0xc4
c0d005b4:	9b3b      	ldr	r3, [sp, #236]	; 0xec
c0d005b6:	189a      	adds	r2, r3, r2
c0d005b8:	9231      	str	r2, [sp, #196]	; 0xc4
c0d005ba:	9a32      	ldr	r2, [sp, #200]	; 0xc8
c0d005bc:	9b3c      	ldr	r3, [sp, #240]	; 0xf0
c0d005be:	189a      	adds	r2, r3, r2
c0d005c0:	9232      	str	r2, [sp, #200]	; 0xc8
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
c0d005c2:	9a33      	ldr	r2, [sp, #204]	; 0xcc
c0d005c4:	9b3d      	ldr	r3, [sp, #244]	; 0xf4
c0d005c6:	189a      	adds	r2, r3, r2
c0d005c8:	9233      	str	r2, [sp, #204]	; 0xcc
c0d005ca:	9a34      	ldr	r2, [sp, #208]	; 0xd0
c0d005cc:	9b3e      	ldr	r3, [sp, #248]	; 0xf8
c0d005ce:	189a      	adds	r2, r3, r2
c0d005d0:	9234      	str	r2, [sp, #208]	; 0xd0

/* Add/subtract two numbers.  The inputs must be in reduced form, and the 
 * output isn't, so to do another addition or subtraction on the output, 
 * first multiply it by one to reduce it. */
static void add25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] + y[0];	xy[1] = x[1] + y[1];
c0d005d2:	1840      	adds	r0, r0, r1
 * t is a temporary  */
static inline void x_to_y2(i25519 t, i25519 y2, const i25519 x) {
	sqr25519(t, x);
	mul25519small(y2, x, 486662);
	add25519(t, t, y2);
	t[0]++;
c0d005d4:	1c40      	adds	r0, r0, #1
c0d005d6:	902b      	str	r0, [sp, #172]	; 0xac
	mul25519(y2, t, x);
c0d005d8:	4630      	mov	r0, r6
c0d005da:	4629      	mov	r1, r5
c0d005dc:	4622      	mov	r2, r4
c0d005de:	f000 fa51 	bl	c0d00a84 <mul25519>
c0d005e2:	ae21      	add	r6, sp, #132	; 0x84
	if (Px != NULL) pack25519(dx, Px);

	/* calculate s such that s abs(P) = G  .. assumes G is std base point */
	if (s) {
		x_to_y2(t2, t1, dx);	/* t1 = Py^2  */
		recip25519(t3, z[1], 0);	/* where Q=P+G ... */
c0d005e4:	4630      	mov	r0, r6
c0d005e6:	9902      	ldr	r1, [sp, #8]
c0d005e8:	f000 f95c 	bl	c0d008a4 <recip25519>
		mul25519(t2, x[1], t3);	/* t2 = Qx  */
c0d005ec:	4628      	mov	r0, r5
c0d005ee:	9903      	ldr	r1, [sp, #12]
c0d005f0:	4632      	mov	r2, r6
c0d005f2:	f000 fa47 	bl	c0d00a84 <mul25519>

/* Add/subtract two numbers.  The inputs must be in reduced form, and the 
 * output isn't, so to do another addition or subtraction on the output, 
 * first multiply it by one to reduce it. */
static void add25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] + y[0];	xy[1] = x[1] + y[1];
c0d005f6:	982c      	ldr	r0, [sp, #176]	; 0xb0
c0d005f8:	9968      	ldr	r1, [sp, #416]	; 0x1a0
c0d005fa:	180a      	adds	r2, r1, r0
c0d005fc:	9867      	ldr	r0, [sp, #412]	; 0x19c
c0d005fe:	992b      	ldr	r1, [sp, #172]	; 0xac
c0d00600:	922c      	str	r2, [sp, #176]	; 0xb0
	xy[2] = x[2] + y[2];	xy[3] = x[3] + y[3];
c0d00602:	9a2d      	ldr	r2, [sp, #180]	; 0xb4
c0d00604:	9b69      	ldr	r3, [sp, #420]	; 0x1a4
c0d00606:	189a      	adds	r2, r3, r2
c0d00608:	922d      	str	r2, [sp, #180]	; 0xb4
c0d0060a:	9a2e      	ldr	r2, [sp, #184]	; 0xb8
c0d0060c:	9b6a      	ldr	r3, [sp, #424]	; 0x1a8
c0d0060e:	189a      	adds	r2, r3, r2
c0d00610:	922e      	str	r2, [sp, #184]	; 0xb8
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
c0d00612:	9a2f      	ldr	r2, [sp, #188]	; 0xbc
c0d00614:	9b6b      	ldr	r3, [sp, #428]	; 0x1ac
c0d00616:	189a      	adds	r2, r3, r2
c0d00618:	922f      	str	r2, [sp, #188]	; 0xbc
c0d0061a:	9a30      	ldr	r2, [sp, #192]	; 0xc0
c0d0061c:	9b6c      	ldr	r3, [sp, #432]	; 0x1b0
c0d0061e:	189a      	adds	r2, r3, r2
c0d00620:	9230      	str	r2, [sp, #192]	; 0xc0
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
c0d00622:	9a31      	ldr	r2, [sp, #196]	; 0xc4
c0d00624:	9b6d      	ldr	r3, [sp, #436]	; 0x1b4
c0d00626:	189a      	adds	r2, r3, r2
c0d00628:	9231      	str	r2, [sp, #196]	; 0xc4
c0d0062a:	9a32      	ldr	r2, [sp, #200]	; 0xc8
c0d0062c:	9b6e      	ldr	r3, [sp, #440]	; 0x1b8
c0d0062e:	189a      	adds	r2, r3, r2
c0d00630:	9232      	str	r2, [sp, #200]	; 0xc8
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
c0d00632:	9a33      	ldr	r2, [sp, #204]	; 0xcc
c0d00634:	9b6f      	ldr	r3, [sp, #444]	; 0x1bc
c0d00636:	189a      	adds	r2, r3, r2
c0d00638:	9233      	str	r2, [sp, #204]	; 0xcc
c0d0063a:	9a34      	ldr	r2, [sp, #208]	; 0xd0
c0d0063c:	9b70      	ldr	r3, [sp, #448]	; 0x1c0
c0d0063e:	189a      	adds	r2, r3, r2
c0d00640:	9234      	str	r2, [sp, #208]	; 0xd0

/* Add/subtract two numbers.  The inputs must be in reduced form, and the 
 * output isn't, so to do another addition or subtraction on the output, 
 * first multiply it by one to reduce it. */
static void add25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] + y[0];	xy[1] = x[1] + y[1];
c0d00642:	1841      	adds	r1, r0, r1
c0d00644:	19c9      	adds	r1, r1, r7
	if (s) {
		x_to_y2(t2, t1, dx);	/* t1 = Py^2  */
		recip25519(t3, z[1], 0);	/* where Q=P+G ... */
		mul25519(t2, x[1], t3);	/* t2 = Qx  */
		add25519(t2, t2, dx);	/* t2 = Qx + Px  */
		t2[0] += 9 + 486662;	/* t2 = Qx + Px + Gx + 486662  */
c0d00646:	3109      	adds	r1, #9
c0d00648:	912b      	str	r1, [sp, #172]	; 0xac
		dx[0] -= 9;		/* dx = Px - Gx  */
c0d0064a:	3809      	subs	r0, #9
c0d0064c:	9067      	str	r0, [sp, #412]	; 0x19c
		sqr25519(t3, dx);	/* t3 = (Px - Gx)^2  */
c0d0064e:	4630      	mov	r0, r6
c0d00650:	4621      	mov	r1, r4
c0d00652:	f000 ff5f 	bl	c0d01514 <sqr25519>
		mul25519(dx, t2, t3);	/* dx = t2 (Px - Gx)^2  */
c0d00656:	4620      	mov	r0, r4
c0d00658:	4629      	mov	r1, r5
c0d0065a:	4632      	mov	r2, r6
c0d0065c:	f000 fa12 	bl	c0d00a84 <mul25519>
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
}
static void sub25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] - y[0];	xy[1] = x[1] - y[1];
c0d00660:	9836      	ldr	r0, [sp, #216]	; 0xd8
c0d00662:	9968      	ldr	r1, [sp, #416]	; 0x1a0
c0d00664:	1a0a      	subs	r2, r1, r0
c0d00666:	9835      	ldr	r0, [sp, #212]	; 0xd4
c0d00668:	9967      	ldr	r1, [sp, #412]	; 0x19c
c0d0066a:	9268      	str	r2, [sp, #416]	; 0x1a0
	xy[2] = x[2] - y[2];	xy[3] = x[3] - y[3];
c0d0066c:	9a37      	ldr	r2, [sp, #220]	; 0xdc
c0d0066e:	9b69      	ldr	r3, [sp, #420]	; 0x1a4
c0d00670:	1a9a      	subs	r2, r3, r2
c0d00672:	9269      	str	r2, [sp, #420]	; 0x1a4
c0d00674:	9a38      	ldr	r2, [sp, #224]	; 0xe0
c0d00676:	9b6a      	ldr	r3, [sp, #424]	; 0x1a8
c0d00678:	1a9a      	subs	r2, r3, r2
c0d0067a:	926a      	str	r2, [sp, #424]	; 0x1a8
	xy[4] = x[4] - y[4];	xy[5] = x[5] - y[5];
c0d0067c:	9a39      	ldr	r2, [sp, #228]	; 0xe4
c0d0067e:	9b6b      	ldr	r3, [sp, #428]	; 0x1ac
c0d00680:	1a9a      	subs	r2, r3, r2
c0d00682:	926b      	str	r2, [sp, #428]	; 0x1ac
c0d00684:	9a3a      	ldr	r2, [sp, #232]	; 0xe8
c0d00686:	9b6c      	ldr	r3, [sp, #432]	; 0x1b0
c0d00688:	1a9a      	subs	r2, r3, r2
c0d0068a:	926c      	str	r2, [sp, #432]	; 0x1b0
	xy[6] = x[6] - y[6];	xy[7] = x[7] - y[7];
c0d0068c:	9a3b      	ldr	r2, [sp, #236]	; 0xec
c0d0068e:	9b6d      	ldr	r3, [sp, #436]	; 0x1b4
c0d00690:	1a9a      	subs	r2, r3, r2
c0d00692:	926d      	str	r2, [sp, #436]	; 0x1b4
c0d00694:	9a3c      	ldr	r2, [sp, #240]	; 0xf0
c0d00696:	9b6e      	ldr	r3, [sp, #440]	; 0x1b8
c0d00698:	1a9a      	subs	r2, r3, r2
c0d0069a:	926e      	str	r2, [sp, #440]	; 0x1b8
	xy[8] = x[8] - y[8];	xy[9] = x[9] - y[9];
c0d0069c:	9a3d      	ldr	r2, [sp, #244]	; 0xf4
c0d0069e:	9b6f      	ldr	r3, [sp, #444]	; 0x1bc
c0d006a0:	1a9a      	subs	r2, r3, r2
c0d006a2:	926f      	str	r2, [sp, #444]	; 0x1bc
c0d006a4:	9a3e      	ldr	r2, [sp, #248]	; 0xf8
c0d006a6:	9b70      	ldr	r3, [sp, #448]	; 0x1c0
c0d006a8:	1a9a      	subs	r2, r3, r2
c0d006aa:	9270      	str	r2, [sp, #448]	; 0x1c0
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
}
static void sub25519(i25519 xy, const i25519 x, const i25519 y) {
	xy[0] = x[0] - y[0];	xy[1] = x[1] - y[1];
c0d006ac:	1a08      	subs	r0, r1, r0
		t2[0] += 9 + 486662;	/* t2 = Qx + Px + Gx + 486662  */
		dx[0] -= 9;		/* dx = Px - Gx  */
		sqr25519(t3, dx);	/* t3 = (Px - Gx)^2  */
		mul25519(dx, t2, t3);	/* dx = t2 (Px - Gx)^2  */
		sub25519(dx, dx, t1);	/* dx = t2 (Px - Gx)^2 - Py^2  */
		dx[0] -= 39420360;	/* dx = t2 (Px - Gx)^2 - Py^2 - Gy^2  */
c0d006ae:	4979      	ldr	r1, [pc, #484]	; (c0d00894 <core25519+0x7d0>)
c0d006b0:	1840      	adds	r0, r0, r1
c0d006b2:	9067      	str	r0, [sp, #412]	; 0x19c
		mul25519(t1, dx, base_r2y);	/* t1 = -Py  */
c0d006b4:	4a78      	ldr	r2, [pc, #480]	; (c0d00898 <core25519+0x7d4>)
c0d006b6:	447a      	add	r2, pc
c0d006b8:	9814      	ldr	r0, [sp, #80]	; 0x50
c0d006ba:	4621      	mov	r1, r4
c0d006bc:	f000 f9e2 	bl	c0d00a84 <mul25519>
c0d006c0:	2001      	movs	r0, #1
c0d006c2:	2400      	movs	r4, #0
}


/* Check if reduced-form input >= 2^255-19 */
static inline int is_overflow(const i25519 x) {
	return ((x[0] > P26-19) & ((x[1] & x[3] & x[5] & x[7] & x[9]) == P25) &
c0d006c4:	993e      	ldr	r1, [sp, #248]	; 0xf8
	                          ((x[2] & x[4] & x[6] & x[8]) == P26)
	       ) | (x[9] > P25);
c0d006c6:	9a15      	ldr	r2, [sp, #84]	; 0x54
c0d006c8:	4291      	cmp	r1, r2
c0d006ca:	4602      	mov	r2, r0
c0d006cc:	dc00      	bgt.n	c0d006d0 <core25519+0x60c>
c0d006ce:	4622      	mov	r2, r4
}


/* Check if reduced-form input >= 2^255-19 */
static inline int is_overflow(const i25519 x) {
	return ((x[0] > P26-19) & ((x[1] & x[3] & x[5] & x[7] & x[9]) == P25) &
c0d006d0:	9b35      	ldr	r3, [sp, #212]	; 0xd4
c0d006d2:	9d16      	ldr	r5, [sp, #88]	; 0x58
c0d006d4:	42ab      	cmp	r3, r5
c0d006d6:	4605      	mov	r5, r0
c0d006d8:	dc00      	bgt.n	c0d006dc <core25519+0x618>
c0d006da:	4625      	mov	r5, r4
c0d006dc:	9e36      	ldr	r6, [sp, #216]	; 0xd8
c0d006de:	9f38      	ldr	r7, [sp, #224]	; 0xe0
c0d006e0:	4037      	ands	r7, r6
c0d006e2:	9e3a      	ldr	r6, [sp, #232]	; 0xe8
c0d006e4:	403e      	ands	r6, r7
c0d006e6:	9f3c      	ldr	r7, [sp, #240]	; 0xf0
c0d006e8:	4037      	ands	r7, r6
c0d006ea:	400f      	ands	r7, r1
c0d006ec:	9e15      	ldr	r6, [sp, #84]	; 0x54
c0d006ee:	42b7      	cmp	r7, r6
c0d006f0:	4606      	mov	r6, r0
c0d006f2:	d000      	beq.n	c0d006f6 <core25519+0x632>
c0d006f4:	4626      	mov	r6, r4
c0d006f6:	4035      	ands	r5, r6
	                          ((x[2] & x[4] & x[6] & x[8]) == P26)
c0d006f8:	9e37      	ldr	r6, [sp, #220]	; 0xdc
c0d006fa:	9f39      	ldr	r7, [sp, #228]	; 0xe4
c0d006fc:	4037      	ands	r7, r6
c0d006fe:	9e3b      	ldr	r6, [sp, #236]	; 0xec
c0d00700:	403e      	ands	r6, r7
c0d00702:	9f3d      	ldr	r7, [sp, #244]	; 0xf4
c0d00704:	4037      	ands	r7, r6
c0d00706:	9e16      	ldr	r6, [sp, #88]	; 0x58
c0d00708:	3613      	adds	r6, #19
c0d0070a:	42b7      	cmp	r7, r6
c0d0070c:	4606      	mov	r6, r0
c0d0070e:	d000      	beq.n	c0d00712 <core25519+0x64e>
c0d00710:	4626      	mov	r6, r4
}


/* Check if reduced-form input >= 2^255-19 */
static inline int is_overflow(const i25519 x) {
	return ((x[0] > P26-19) & ((x[1] & x[3] & x[5] & x[7] & x[9]) == P25) &
c0d00712:	4035      	ands	r5, r6
	                          ((x[2] & x[4] & x[6] & x[8]) == P26)
	       ) | (x[9] > P25);
c0d00714:	432a      	orrs	r2, r5
	}
}

/* checks if x is "negative", requires reduced input */
static inline int is_negative(i25519 x) {
	return (is_overflow(x) | (x[9] < 0)) ^ (x[0] & 1);
c0d00716:	0fc9      	lsrs	r1, r1, #31
c0d00718:	4311      	orrs	r1, r2
c0d0071a:	4003      	ands	r3, r0
		sqr25519(t3, dx);	/* t3 = (Px - Gx)^2  */
		mul25519(dx, t2, t3);	/* dx = t2 (Px - Gx)^2  */
		sub25519(dx, dx, t1);	/* dx = t2 (Px - Gx)^2 - Py^2  */
		dx[0] -= 39420360;	/* dx = t2 (Px - Gx)^2 - Py^2 - Gy^2  */
		mul25519(t1, dx, base_r2y);	/* t1 = -Py  */
		if (is_negative(t1))	/* sign is 1, so just copy  */
c0d0071c:	4299      	cmp	r1, r3
c0d0071e:	9905      	ldr	r1, [sp, #20]
c0d00720:	9f07      	ldr	r7, [sp, #28]
c0d00722:	d117      	bne.n	c0d00754 <core25519+0x690>
c0d00724:	2000      	movs	r0, #0
c0d00726:	4e5d      	ldr	r6, [pc, #372]	; (c0d0089c <core25519+0x7d8>)
c0d00728:	447e      	add	r6, pc
c0d0072a:	4602      	mov	r2, r0
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d0072c:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d0072e:	4343      	muls	r3, r0
c0d00730:	5cfc      	ldrb	r4, [r7, r3]
c0d00732:	5cf5      	ldrb	r5, [r6, r3]
c0d00734:	18aa      	adds	r2, r5, r2
c0d00736:	1b12      	subs	r2, r2, r4
c0d00738:	54ca      	strb	r2, [r1, r3]
		v >>= 8;
c0d0073a:	1212      	asrs	r2, r2, #8
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d0073c:	1e40      	subs	r0, r0, #1
c0d0073e:	4603      	mov	r3, r0
c0d00740:	3320      	adds	r3, #32
c0d00742:	d1f3      	bne.n	c0d0072c <core25519+0x668>
c0d00744:	e00f      	b.n	c0d00766 <core25519+0x6a2>
c0d00746:	46c0      	nop			; (mov r8, r8)
c0d00748:	0001db41 	.word	0x0001db41
c0d0074c:	01ffffff 	.word	0x01ffffff
c0d00750:	03ffffec 	.word	0x03ffffec
c0d00754:	2000      	movs	r0, #0

/********************* radix 2^8 math *********************/

static void cpy32(k25519 d, const k25519 s) {
	int i;
	for (i = 0; i < 32; i++) d[i] = s[i];
c0d00756:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d00758:	4343      	muls	r3, r0
c0d0075a:	5cfa      	ldrb	r2, [r7, r3]
c0d0075c:	54ca      	strb	r2, [r1, r3]
c0d0075e:	1e40      	subs	r0, r0, #1
c0d00760:	4602      	mov	r2, r0
c0d00762:	3220      	adds	r2, #32
c0d00764:	d1f7      	bne.n	c0d00756 <core25519+0x692>
		else			/* sign is -1, so negate  */
			mula_small(s, order_times_8, 0, k, 32, -1);

		/* reduce s mod q
		 * (is this needed?  do it just in case, it's fast anyway) */
		divmod((dstptr) t1, s, 32, order25519, 32);
c0d00766:	2520      	movs	r5, #32
c0d00768:	4668      	mov	r0, sp
c0d0076a:	6005      	str	r5, [r0, #0]
c0d0076c:	ae35      	add	r6, sp, #212	; 0xd4
c0d0076e:	4c4c      	ldr	r4, [pc, #304]	; (c0d008a0 <core25519+0x7dc>)
c0d00770:	447c      	add	r4, pc
c0d00772:	4630      	mov	r0, r6
c0d00774:	462a      	mov	r2, r5
c0d00776:	4623      	mov	r3, r4
c0d00778:	f001 f9f4 	bl	c0d01b64 <divmod>

/********************* radix 2^8 math *********************/

static void cpy32(k25519 d, const k25519 s) {
	int i;
	for (i = 0; i < 32; i++) d[i] = s[i];
c0d0077c:	4630      	mov	r0, r6
c0d0077e:	9415      	str	r4, [sp, #84]	; 0x54
c0d00780:	4621      	mov	r1, r4
c0d00782:	462a      	mov	r2, r5
c0d00784:	f004 f8f0 	bl	c0d04968 <__aeabi_memcpy>
c0d00788:	a83f      	add	r0, sp, #252	; 0xfc
 * x and y must have 64 bytes space for temporary use.
 * requires that a[-1] and b[-1] are valid memory locations  */
static dstptr egcd32(dstptr x, dstptr y, dstptr a, dstptr b) {
	unsigned an, bn = 32, qn, i;
	for (i = 0; i < 32; i++)
		x[i] = y[i] = 0;
c0d0078a:	4629      	mov	r1, r5
c0d0078c:	f004 f8e6 	bl	c0d0495c <__aeabi_memclr>
c0d00790:	ae53      	add	r6, sp, #332	; 0x14c
c0d00792:	4630      	mov	r0, r6
c0d00794:	9516      	str	r5, [sp, #88]	; 0x58
c0d00796:	4629      	mov	r1, r5
c0d00798:	f004 f8e0 	bl	c0d0495c <__aeabi_memclr>
	x[0] = 1;
c0d0079c:	2001      	movs	r0, #1
c0d0079e:	9014      	str	r0, [sp, #80]	; 0x50
c0d007a0:	7030      	strb	r0, [r6, #0]
c0d007a2:	2621      	movs	r6, #33	; 0x21
c0d007a4:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d007a6:	a93f      	add	r1, sp, #252	; 0xfc

	r[t-1] = rn;
}

static inline unsigned numsize(srcptr x, unsigned n) {
	while (n-- && !x[n])
c0d007a8:	2e01      	cmp	r6, #1
c0d007aa:	d055      	beq.n	c0d00858 <core25519+0x794>
c0d007ac:	9a05      	ldr	r2, [sp, #20]
c0d007ae:	1990      	adds	r0, r2, r6
c0d007b0:	18c0      	adds	r0, r0, r3
c0d007b2:	2100      	movs	r1, #0
c0d007b4:	43c9      	mvns	r1, r1
c0d007b6:	5c40      	ldrb	r0, [r0, r1]
c0d007b8:	1e76      	subs	r6, r6, #1
c0d007ba:	2800      	cmp	r0, #0
c0d007bc:	d0f3      	beq.n	c0d007a6 <core25519+0x6e2>
/* Returns x if a contains the gcd, y if b.  Also, the returned buffer contains 
 * the inverse of a mod b, as 32-byte signed.
 * x and y must have 64 bytes space for temporary use.
 * requires that a[-1] and b[-1] are valid memory locations  */
static dstptr egcd32(dstptr x, dstptr y, dstptr a, dstptr b) {
	unsigned an, bn = 32, qn, i;
c0d007be:	18d0      	adds	r0, r2, r3
c0d007c0:	9011      	str	r0, [sp, #68]	; 0x44
c0d007c2:	a835      	add	r0, sp, #212	; 0xd4
c0d007c4:	4619      	mov	r1, r3
c0d007c6:	4613      	mov	r3, r2
c0d007c8:	1847      	adds	r7, r0, r1
c0d007ca:	a853      	add	r0, sp, #332	; 0x14c
c0d007cc:	3020      	adds	r0, #32
c0d007ce:	9013      	str	r0, [sp, #76]	; 0x4c
c0d007d0:	a83f      	add	r0, sp, #252	; 0xfc
c0d007d2:	3020      	adds	r0, #32
c0d007d4:	9012      	str	r0, [sp, #72]	; 0x48
	x[0] = 1;
	if (!(an = numsize(a, 32)))
		return y;	/* division by zero */
	while (42) {
		qn = bn - an + 1;
		divmod(y+32, b, bn, a, an);
c0d007d6:	4669      	mov	r1, sp
c0d007d8:	600e      	str	r6, [r1, #0]
c0d007da:	a935      	add	r1, sp, #212	; 0xd4
c0d007dc:	9c16      	ldr	r4, [sp, #88]	; 0x58
c0d007de:	4622      	mov	r2, r4
c0d007e0:	f001 f9c0 	bl	c0d01b64 <divmod>
c0d007e4:	4620      	mov	r0, r4
c0d007e6:	9b0a      	ldr	r3, [sp, #40]	; 0x28

	r[t-1] = rn;
}

static inline unsigned numsize(srcptr x, unsigned n) {
	while (n-- && !x[n])
c0d007e8:	1e44      	subs	r4, r0, #1
c0d007ea:	a953      	add	r1, sp, #332	; 0x14c
c0d007ec:	2800      	cmp	r0, #0
c0d007ee:	d033      	beq.n	c0d00858 <core25519+0x794>
c0d007f0:	5c38      	ldrb	r0, [r7, r0]
c0d007f2:	2800      	cmp	r0, #0
c0d007f4:	4620      	mov	r0, r4
c0d007f6:	d0f7      	beq.n	c0d007e8 <core25519+0x724>
	while (42) {
		qn = bn - an + 1;
		divmod(y+32, b, bn, a, an);
		if (!(bn = numsize(b, bn)))
			return x;
		mula32(y, x, y+32, qn, -1);
c0d007f8:	4668      	mov	r0, sp
c0d007fa:	6003      	str	r3, [r0, #0]
		x[i] = y[i] = 0;
	x[0] = 1;
	if (!(an = numsize(a, 32)))
		return y;	/* division by zero */
	while (42) {
		qn = bn - an + 1;
c0d007fc:	9814      	ldr	r0, [sp, #80]	; 0x50
c0d007fe:	1b80      	subs	r0, r0, r6
c0d00800:	9916      	ldr	r1, [sp, #88]	; 0x58
c0d00802:	1843      	adds	r3, r0, r1
c0d00804:	a83f      	add	r0, sp, #252	; 0xfc
c0d00806:	a953      	add	r1, sp, #332	; 0x14c
		divmod(y+32, b, bn, a, an);
		if (!(bn = numsize(b, bn)))
			return x;
		mula32(y, x, y+32, qn, -1);
c0d00808:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d0080a:	f001 fa97 	bl	c0d01d3c <mula32>

		qn = an - bn + 1;
		divmod(x+32, a, an, b, bn);
c0d0080e:	1c61      	adds	r1, r4, #1
c0d00810:	4668      	mov	r0, sp
c0d00812:	9116      	str	r1, [sp, #88]	; 0x58
c0d00814:	6001      	str	r1, [r0, #0]
c0d00816:	ab35      	add	r3, sp, #212	; 0xd4
c0d00818:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d0081a:	9905      	ldr	r1, [sp, #20]
c0d0081c:	4632      	mov	r2, r6
c0d0081e:	f001 f9a1 	bl	c0d01b64 <divmod>
c0d00822:	9a11      	ldr	r2, [sp, #68]	; 0x44
c0d00824:	9b0a      	ldr	r3, [sp, #40]	; 0x28

	r[t-1] = rn;
}

static inline unsigned numsize(srcptr x, unsigned n) {
	while (n-- && !x[n])
c0d00826:	461d      	mov	r5, r3
c0d00828:	4375      	muls	r5, r6
c0d0082a:	a93f      	add	r1, sp, #252	; 0xfc
c0d0082c:	2d00      	cmp	r5, #0
c0d0082e:	d013      	beq.n	c0d00858 <core25519+0x794>
c0d00830:	4618      	mov	r0, r3
c0d00832:	4368      	muls	r0, r5
c0d00834:	5c10      	ldrb	r0, [r2, r0]
c0d00836:	1c6d      	adds	r5, r5, #1
c0d00838:	2800      	cmp	r0, #0
c0d0083a:	d0f6      	beq.n	c0d0082a <core25519+0x766>

		qn = an - bn + 1;
		divmod(x+32, a, an, b, bn);
		if (!(an = numsize(a, an)))
			return y;
		mula32(x, y, x+32, qn, -1);
c0d0083c:	4668      	mov	r0, sp
c0d0083e:	6003      	str	r3, [r0, #0]
c0d00840:	1b33      	subs	r3, r6, r4
c0d00842:	a853      	add	r0, sp, #332	; 0x14c
c0d00844:	a93f      	add	r1, sp, #252	; 0xfc
c0d00846:	9a13      	ldr	r2, [sp, #76]	; 0x4c
c0d00848:	f001 fa78 	bl	c0d01d3c <mula32>
	for (i = 0; i < 32; i++)
		x[i] = y[i] = 0;
	x[0] = 1;
	if (!(an = numsize(a, 32)))
		return y;	/* division by zero */
	while (42) {
c0d0084c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0084e:	4345      	muls	r5, r0
c0d00850:	1c6e      	adds	r6, r5, #1
c0d00852:	9b05      	ldr	r3, [sp, #20]
c0d00854:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d00856:	e7be      	b.n	c0d007d6 <core25519+0x712>

/********************* radix 2^8 math *********************/

static void cpy32(k25519 d, const k25519 s) {
	int i;
	for (i = 0; i < 32; i++) d[i] = s[i];
c0d00858:	2220      	movs	r2, #32
c0d0085a:	9d05      	ldr	r5, [sp, #20]
c0d0085c:	4628      	mov	r0, r5
c0d0085e:	461e      	mov	r6, r3
c0d00860:	f004 f882 	bl	c0d04968 <__aeabi_memcpy>
		divmod((dstptr) t1, s, 32, order25519, 32);

		/* take reciprocal of s mod q */
		cpy32((dstptr) t1, order25519);
		cpy32(s, egcd32((dstptr) x, (dstptr) z, s, (dstptr) t1));
		if ((int8_t) s[31] < 0)
c0d00864:	201f      	movs	r0, #31
c0d00866:	5628      	ldrsb	r0, [r5, r0]
c0d00868:	2800      	cmp	r0, #0
c0d0086a:	9f15      	ldr	r7, [sp, #84]	; 0x54
c0d0086c:	da0d      	bge.n	c0d0088a <core25519+0x7c6>
c0d0086e:	2000      	movs	r0, #0
c0d00870:	4601      	mov	r1, r0
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d00872:	4632      	mov	r2, r6
c0d00874:	4342      	muls	r2, r0
c0d00876:	5cbb      	ldrb	r3, [r7, r2]
c0d00878:	5cac      	ldrb	r4, [r5, r2]
c0d0087a:	1861      	adds	r1, r4, r1
c0d0087c:	18c9      	adds	r1, r1, r3
c0d0087e:	54a9      	strb	r1, [r5, r2]
		v >>= 8;
c0d00880:	1209      	asrs	r1, r1, #8
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d00882:	1e40      	subs	r0, r0, #1
c0d00884:	4602      	mov	r2, r0
c0d00886:	3220      	adds	r2, #32
c0d00888:	d1f3      	bne.n	c0d00872 <core25519+0x7ae>
		cpy32((dstptr) t1, order25519);
		cpy32(s, egcd32((dstptr) x, (dstptr) z, s, (dstptr) t1));
		if ((int8_t) s[31] < 0)
			mula_small(s, s, 0, order25519, 32, 1);
	}
}
c0d0088a:	b071      	add	sp, #452	; 0x1c4
c0d0088c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0088e:	46c0      	nop			; (mov r8, r8)
c0d00890:	00076d06 	.word	0x00076d06
c0d00894:	fda67e38 	.word	0xfda67e38
c0d00898:	0000448a 	.word	0x0000448a
c0d0089c:	00004440 	.word	0x00004440
c0d008a0:	000043b0 	.word	0x000043b0

c0d008a4 <recip25519>:
}

/* Calculates a reciprocal.  The output is in reduced form, the inputs need not 
 * be.  Simply calculates  y = x^(p-2)  so it's not too fast. */
/* When sqrtassist is true, it instead calculates y = x^((p-5)/8) */
static void recip25519(i25519 y, const i25519 x, int sqrtassist) {
c0d008a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008a6:	b0b3      	sub	sp, #204	; 0xcc
c0d008a8:	460f      	mov	r7, r1
c0d008aa:	9000      	str	r0, [sp, #0]
c0d008ac:	ad1f      	add	r5, sp, #124	; 0x7c
	i25519 t0, t1, t2, t3, t4;
	int i;
	/* the chain for x^(2^255-21) is straight from djb's implementation */
	sqr25519(t1, x);	/*  2 == 2 * 1	*/
c0d008ae:	4628      	mov	r0, r5
c0d008b0:	f000 fe30 	bl	c0d01514 <sqr25519>
c0d008b4:	ae15      	add	r6, sp, #84	; 0x54
	sqr25519(t2, t1);	/*  4 == 2 * 2	*/
c0d008b6:	4630      	mov	r0, r6
c0d008b8:	4629      	mov	r1, r5
c0d008ba:	f000 fe2b 	bl	c0d01514 <sqr25519>
c0d008be:	ac29      	add	r4, sp, #164	; 0xa4
	sqr25519(t0, t2);	/*  8 == 2 * 4	*/
c0d008c0:	4620      	mov	r0, r4
c0d008c2:	4631      	mov	r1, r6
c0d008c4:	f000 fe26 	bl	c0d01514 <sqr25519>
	mul25519(t2, t0, x);	/*  9 == 8 + 1	*/
c0d008c8:	4630      	mov	r0, r6
c0d008ca:	4621      	mov	r1, r4
c0d008cc:	463a      	mov	r2, r7
c0d008ce:	f000 f8d9 	bl	c0d00a84 <mul25519>
	mul25519(t0, t2, t1);	/* 11 == 9 + 2	*/
c0d008d2:	4620      	mov	r0, r4
c0d008d4:	4631      	mov	r1, r6
c0d008d6:	462a      	mov	r2, r5
c0d008d8:	f000 f8d4 	bl	c0d00a84 <mul25519>
	sqr25519(t1, t0);	/* 22 == 2 * 11	*/
c0d008dc:	4628      	mov	r0, r5
c0d008de:	4621      	mov	r1, r4
c0d008e0:	f000 fe18 	bl	c0d01514 <sqr25519>
c0d008e4:	af0b      	add	r7, sp, #44	; 0x2c
	mul25519(t3, t1, t2);	/* 31 == 22 + 9
c0d008e6:	4638      	mov	r0, r7
c0d008e8:	4629      	mov	r1, r5
c0d008ea:	4632      	mov	r2, r6
c0d008ec:	f000 f8ca 	bl	c0d00a84 <mul25519>
				== 2^5   - 2^0	*/
	sqr25519(t1, t3);	/* 2^6   - 2^1	*/
c0d008f0:	4628      	mov	r0, r5
c0d008f2:	4639      	mov	r1, r7
c0d008f4:	f000 fe0e 	bl	c0d01514 <sqr25519>
	sqr25519(t2, t1);	/* 2^7   - 2^2	*/
c0d008f8:	4630      	mov	r0, r6
c0d008fa:	4629      	mov	r1, r5
c0d008fc:	f000 fe0a 	bl	c0d01514 <sqr25519>
	sqr25519(t1, t2);	/* 2^8   - 2^3	*/
c0d00900:	4628      	mov	r0, r5
c0d00902:	4631      	mov	r1, r6
c0d00904:	f000 fe06 	bl	c0d01514 <sqr25519>
	sqr25519(t2, t1);	/* 2^9   - 2^4	*/
c0d00908:	4630      	mov	r0, r6
c0d0090a:	4629      	mov	r1, r5
c0d0090c:	f000 fe02 	bl	c0d01514 <sqr25519>
	sqr25519(t1, t2);	/* 2^10  - 2^5	*/
c0d00910:	4628      	mov	r0, r5
c0d00912:	4631      	mov	r1, r6
c0d00914:	f000 fdfe 	bl	c0d01514 <sqr25519>
	mul25519(t2, t1, t3);	/* 2^10  - 2^0	*/
c0d00918:	4630      	mov	r0, r6
c0d0091a:	4629      	mov	r1, r5
c0d0091c:	463a      	mov	r2, r7
c0d0091e:	f000 f8b1 	bl	c0d00a84 <mul25519>
	sqr25519(t1, t2);	/* 2^11  - 2^1	*/
c0d00922:	4628      	mov	r0, r5
c0d00924:	4631      	mov	r1, r6
c0d00926:	f000 fdf5 	bl	c0d01514 <sqr25519>
	sqr25519(t3, t1);	/* 2^12  - 2^2	*/
c0d0092a:	4638      	mov	r0, r7
c0d0092c:	4629      	mov	r1, r5
c0d0092e:	f000 fdf1 	bl	c0d01514 <sqr25519>
c0d00932:	2604      	movs	r6, #4
c0d00934:	ac1f      	add	r4, sp, #124	; 0x7c
c0d00936:	ad0b      	add	r5, sp, #44	; 0x2c
	for (i = 1; i < 5; i++) {
		sqr25519(t1, t3);
c0d00938:	4620      	mov	r0, r4
c0d0093a:	4629      	mov	r1, r5
c0d0093c:	f000 fdea 	bl	c0d01514 <sqr25519>
		sqr25519(t3, t1);
c0d00940:	4628      	mov	r0, r5
c0d00942:	4621      	mov	r1, r4
c0d00944:	f000 fde6 	bl	c0d01514 <sqr25519>
	sqr25519(t2, t1);	/* 2^9   - 2^4	*/
	sqr25519(t1, t2);	/* 2^10  - 2^5	*/
	mul25519(t2, t1, t3);	/* 2^10  - 2^0	*/
	sqr25519(t1, t2);	/* 2^11  - 2^1	*/
	sqr25519(t3, t1);	/* 2^12  - 2^2	*/
	for (i = 1; i < 5; i++) {
c0d00948:	1e76      	subs	r6, r6, #1
c0d0094a:	d1f3      	bne.n	c0d00934 <recip25519+0x90>
c0d0094c:	ac1f      	add	r4, sp, #124	; 0x7c
c0d0094e:	ad0b      	add	r5, sp, #44	; 0x2c
c0d00950:	aa15      	add	r2, sp, #84	; 0x54
		sqr25519(t1, t3);
		sqr25519(t3, t1);
	} /* t3 */		/* 2^20  - 2^10	*/
	mul25519(t1, t3, t2);	/* 2^20  - 2^0	*/
c0d00952:	4620      	mov	r0, r4
c0d00954:	4629      	mov	r1, r5
c0d00956:	f000 f895 	bl	c0d00a84 <mul25519>
	sqr25519(t3, t1);	/* 2^21  - 2^1	*/
c0d0095a:	4628      	mov	r0, r5
c0d0095c:	4621      	mov	r1, r4
c0d0095e:	f000 fdd9 	bl	c0d01514 <sqr25519>
c0d00962:	a801      	add	r0, sp, #4
	sqr25519(t4, t3);	/* 2^22  - 2^2	*/
c0d00964:	4629      	mov	r1, r5
c0d00966:	f000 fdd5 	bl	c0d01514 <sqr25519>
c0d0096a:	2609      	movs	r6, #9
c0d0096c:	ac0b      	add	r4, sp, #44	; 0x2c
c0d0096e:	ad01      	add	r5, sp, #4
	for (i = 1; i < 10; i++) {
		sqr25519(t3, t4);
c0d00970:	4620      	mov	r0, r4
c0d00972:	4629      	mov	r1, r5
c0d00974:	f000 fdce 	bl	c0d01514 <sqr25519>
		sqr25519(t4, t3);
c0d00978:	4628      	mov	r0, r5
c0d0097a:	4621      	mov	r1, r4
c0d0097c:	f000 fdca 	bl	c0d01514 <sqr25519>
		sqr25519(t3, t1);
	} /* t3 */		/* 2^20  - 2^10	*/
	mul25519(t1, t3, t2);	/* 2^20  - 2^0	*/
	sqr25519(t3, t1);	/* 2^21  - 2^1	*/
	sqr25519(t4, t3);	/* 2^22  - 2^2	*/
	for (i = 1; i < 10; i++) {
c0d00980:	1e76      	subs	r6, r6, #1
c0d00982:	d1f3      	bne.n	c0d0096c <recip25519+0xc8>
c0d00984:	a80b      	add	r0, sp, #44	; 0x2c
c0d00986:	a901      	add	r1, sp, #4
c0d00988:	aa1f      	add	r2, sp, #124	; 0x7c
		sqr25519(t3, t4);
		sqr25519(t4, t3);
	} /* t4 */		/* 2^40  - 2^20	*/
	mul25519(t3, t4, t1);	/* 2^40  - 2^0	*/
c0d0098a:	f000 f87b 	bl	c0d00a84 <mul25519>
c0d0098e:	2605      	movs	r6, #5
c0d00990:	ac1f      	add	r4, sp, #124	; 0x7c
c0d00992:	ad0b      	add	r5, sp, #44	; 0x2c
	for (i = 0; i < 5; i++) {
		sqr25519(t1, t3);
c0d00994:	4620      	mov	r0, r4
c0d00996:	4629      	mov	r1, r5
c0d00998:	f000 fdbc 	bl	c0d01514 <sqr25519>
		sqr25519(t3, t1);
c0d0099c:	4628      	mov	r0, r5
c0d0099e:	4621      	mov	r1, r4
c0d009a0:	f000 fdb8 	bl	c0d01514 <sqr25519>
	for (i = 1; i < 10; i++) {
		sqr25519(t3, t4);
		sqr25519(t4, t3);
	} /* t4 */		/* 2^40  - 2^20	*/
	mul25519(t3, t4, t1);	/* 2^40  - 2^0	*/
	for (i = 0; i < 5; i++) {
c0d009a4:	1e76      	subs	r6, r6, #1
c0d009a6:	d1f3      	bne.n	c0d00990 <recip25519+0xec>
c0d009a8:	ac1f      	add	r4, sp, #124	; 0x7c
c0d009aa:	ad0b      	add	r5, sp, #44	; 0x2c
c0d009ac:	ae15      	add	r6, sp, #84	; 0x54
		sqr25519(t1, t3);
		sqr25519(t3, t1);
	} /* t3 */		/* 2^50  - 2^10	*/
	mul25519(t1, t3, t2);	/* 2^50  - 2^0	*/
c0d009ae:	4620      	mov	r0, r4
c0d009b0:	4629      	mov	r1, r5
c0d009b2:	4632      	mov	r2, r6
c0d009b4:	f000 f866 	bl	c0d00a84 <mul25519>
	sqr25519(t2, t1);	/* 2^51  - 2^1	*/
c0d009b8:	4630      	mov	r0, r6
c0d009ba:	4621      	mov	r1, r4
c0d009bc:	f000 fdaa 	bl	c0d01514 <sqr25519>
	sqr25519(t3, t2);	/* 2^52  - 2^2	*/
c0d009c0:	4628      	mov	r0, r5
c0d009c2:	4631      	mov	r1, r6
c0d009c4:	f000 fda6 	bl	c0d01514 <sqr25519>
c0d009c8:	2618      	movs	r6, #24
c0d009ca:	ac15      	add	r4, sp, #84	; 0x54
c0d009cc:	ad0b      	add	r5, sp, #44	; 0x2c
	for (i = 1; i < 25; i++) {
		sqr25519(t2, t3);
c0d009ce:	4620      	mov	r0, r4
c0d009d0:	4629      	mov	r1, r5
c0d009d2:	f000 fd9f 	bl	c0d01514 <sqr25519>
		sqr25519(t3, t2);
c0d009d6:	4628      	mov	r0, r5
c0d009d8:	4621      	mov	r1, r4
c0d009da:	f000 fd9b 	bl	c0d01514 <sqr25519>
		sqr25519(t3, t1);
	} /* t3 */		/* 2^50  - 2^10	*/
	mul25519(t1, t3, t2);	/* 2^50  - 2^0	*/
	sqr25519(t2, t1);	/* 2^51  - 2^1	*/
	sqr25519(t3, t2);	/* 2^52  - 2^2	*/
	for (i = 1; i < 25; i++) {
c0d009de:	1e76      	subs	r6, r6, #1
c0d009e0:	d1f3      	bne.n	c0d009ca <recip25519+0x126>
c0d009e2:	ac15      	add	r4, sp, #84	; 0x54
c0d009e4:	ad0b      	add	r5, sp, #44	; 0x2c
c0d009e6:	aa1f      	add	r2, sp, #124	; 0x7c
		sqr25519(t2, t3);
		sqr25519(t3, t2);
	} /* t3 */		/* 2^100 - 2^50 */
	mul25519(t2, t3, t1);	/* 2^100 - 2^0	*/
c0d009e8:	4620      	mov	r0, r4
c0d009ea:	4629      	mov	r1, r5
c0d009ec:	f000 f84a 	bl	c0d00a84 <mul25519>
	sqr25519(t3, t2);	/* 2^101 - 2^1	*/
c0d009f0:	4628      	mov	r0, r5
c0d009f2:	4621      	mov	r1, r4
c0d009f4:	f000 fd8e 	bl	c0d01514 <sqr25519>
c0d009f8:	a801      	add	r0, sp, #4
	sqr25519(t4, t3);	/* 2^102 - 2^2	*/
c0d009fa:	4629      	mov	r1, r5
c0d009fc:	f000 fd8a 	bl	c0d01514 <sqr25519>
c0d00a00:	2631      	movs	r6, #49	; 0x31
c0d00a02:	ac0b      	add	r4, sp, #44	; 0x2c
c0d00a04:	ad01      	add	r5, sp, #4
	for (i = 1; i < 50; i++) {
		sqr25519(t3, t4);
c0d00a06:	4620      	mov	r0, r4
c0d00a08:	4629      	mov	r1, r5
c0d00a0a:	f000 fd83 	bl	c0d01514 <sqr25519>
		sqr25519(t4, t3);
c0d00a0e:	4628      	mov	r0, r5
c0d00a10:	4621      	mov	r1, r4
c0d00a12:	f000 fd7f 	bl	c0d01514 <sqr25519>
		sqr25519(t3, t2);
	} /* t3 */		/* 2^100 - 2^50 */
	mul25519(t2, t3, t1);	/* 2^100 - 2^0	*/
	sqr25519(t3, t2);	/* 2^101 - 2^1	*/
	sqr25519(t4, t3);	/* 2^102 - 2^2	*/
	for (i = 1; i < 50; i++) {
c0d00a16:	1e76      	subs	r6, r6, #1
c0d00a18:	d1f3      	bne.n	c0d00a02 <recip25519+0x15e>
c0d00a1a:	a80b      	add	r0, sp, #44	; 0x2c
c0d00a1c:	a901      	add	r1, sp, #4
c0d00a1e:	aa15      	add	r2, sp, #84	; 0x54
		sqr25519(t3, t4);
		sqr25519(t4, t3);
	} /* t4 */		/* 2^200 - 2^100 */
	mul25519(t3, t4, t2);	/* 2^200 - 2^0	*/
c0d00a20:	f000 f830 	bl	c0d00a84 <mul25519>
c0d00a24:	2619      	movs	r6, #25
c0d00a26:	ac01      	add	r4, sp, #4
c0d00a28:	ad0b      	add	r5, sp, #44	; 0x2c
	for (i = 0; i < 25; i++) {
		sqr25519(t4, t3);
c0d00a2a:	4620      	mov	r0, r4
c0d00a2c:	4629      	mov	r1, r5
c0d00a2e:	f000 fd71 	bl	c0d01514 <sqr25519>
		sqr25519(t3, t4);
c0d00a32:	4628      	mov	r0, r5
c0d00a34:	4621      	mov	r1, r4
c0d00a36:	f000 fd6d 	bl	c0d01514 <sqr25519>
	for (i = 1; i < 50; i++) {
		sqr25519(t3, t4);
		sqr25519(t4, t3);
	} /* t4 */		/* 2^200 - 2^100 */
	mul25519(t3, t4, t2);	/* 2^200 - 2^0	*/
	for (i = 0; i < 25; i++) {
c0d00a3a:	1e76      	subs	r6, r6, #1
c0d00a3c:	d1f3      	bne.n	c0d00a26 <recip25519+0x182>
c0d00a3e:	ae15      	add	r6, sp, #84	; 0x54
c0d00a40:	a90b      	add	r1, sp, #44	; 0x2c
c0d00a42:	ad1f      	add	r5, sp, #124	; 0x7c
		sqr25519(t4, t3);
		sqr25519(t3, t4);
	} /* t3 */		/* 2^250 - 2^50	*/
	mul25519(t2, t3, t1);	/* 2^250 - 2^0	*/
c0d00a44:	4630      	mov	r0, r6
c0d00a46:	462a      	mov	r2, r5
c0d00a48:	f000 f81c 	bl	c0d00a84 <mul25519>
	sqr25519(t1, t2);	/* 2^251 - 2^1	*/
c0d00a4c:	4628      	mov	r0, r5
c0d00a4e:	4631      	mov	r1, r6
c0d00a50:	f000 fd60 	bl	c0d01514 <sqr25519>
	sqr25519(t2, t1);	/* 2^252 - 2^2	*/
c0d00a54:	4630      	mov	r0, r6
c0d00a56:	4629      	mov	r1, r5
c0d00a58:	f000 fd5c 	bl	c0d01514 <sqr25519>
	if (sqrtassist) {
		mul25519(y, x, t2);	/* 2^252 - 3 */
	} else {
		sqr25519(t1, t2);	/* 2^253 - 2^3	*/
c0d00a5c:	4628      	mov	r0, r5
c0d00a5e:	4631      	mov	r1, r6
c0d00a60:	f000 fd58 	bl	c0d01514 <sqr25519>
		sqr25519(t2, t1);	/* 2^254 - 2^4	*/
c0d00a64:	4630      	mov	r0, r6
c0d00a66:	4629      	mov	r1, r5
c0d00a68:	f000 fd54 	bl	c0d01514 <sqr25519>
		sqr25519(t1, t2);	/* 2^255 - 2^5	*/
c0d00a6c:	4628      	mov	r0, r5
c0d00a6e:	4631      	mov	r1, r6
c0d00a70:	f000 fd50 	bl	c0d01514 <sqr25519>
c0d00a74:	aa29      	add	r2, sp, #164	; 0xa4
		mul25519(y, t1, t0);	/* 2^255 - 21	*/
c0d00a76:	9800      	ldr	r0, [sp, #0]
c0d00a78:	4629      	mov	r1, r5
c0d00a7a:	f000 f803 	bl	c0d00a84 <mul25519>
	}
}
c0d00a7e:	b033      	add	sp, #204	; 0xcc
c0d00a80:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00a84 <mul25519>:
	return xy;
}

/* Multiply two numbers.  The output is in reduced form, the inputs need not 
 * be. */
static i25519ptr mul25519(i25519 xy, const i25519 x, const i25519 y) {
c0d00a84:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a86:	b08d      	sub	sp, #52	; 0x34
c0d00a88:	4615      	mov	r5, r2
c0d00a8a:	460e      	mov	r6, r1
c0d00a8c:	900b      	str	r0, [sp, #44]	; 0x2c
	register int64_t t;
	check_nonred("mul input x", x);
	check_nonred("mul input y", y);
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
c0d00a8e:	69e8      	ldr	r0, [r5, #28]
c0d00a90:	17c1      	asrs	r1, r0, #31
c0d00a92:	6872      	ldr	r2, [r6, #4]
c0d00a94:	17d3      	asrs	r3, r2, #31
c0d00a96:	f003 ff35 	bl	c0d04904 <__aeabi_lmul>
c0d00a9a:	4607      	mov	r7, r0
c0d00a9c:	910c      	str	r1, [sp, #48]	; 0x30
c0d00a9e:	6968      	ldr	r0, [r5, #20]
c0d00aa0:	17c1      	asrs	r1, r0, #31
c0d00aa2:	68f2      	ldr	r2, [r6, #12]
c0d00aa4:	17d3      	asrs	r3, r2, #31
c0d00aa6:	f003 ff2d 	bl	c0d04904 <__aeabi_lmul>
c0d00aaa:	460c      	mov	r4, r1
c0d00aac:	19c0      	adds	r0, r0, r7
c0d00aae:	900a      	str	r0, [sp, #40]	; 0x28
c0d00ab0:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00ab2:	4144      	adcs	r4, r0
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
c0d00ab4:	68e8      	ldr	r0, [r5, #12]
c0d00ab6:	17c1      	asrs	r1, r0, #31
c0d00ab8:	6972      	ldr	r2, [r6, #20]
c0d00aba:	17d3      	asrs	r3, r2, #31
c0d00abc:	f003 ff22 	bl	c0d04904 <__aeabi_lmul>
c0d00ac0:	460f      	mov	r7, r1
static i25519ptr mul25519(i25519 xy, const i25519 x, const i25519 y) {
	register int64_t t;
	check_nonred("mul input x", x);
	check_nonred("mul input y", y);
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
c0d00ac2:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00ac4:	1808      	adds	r0, r1, r0
c0d00ac6:	900c      	str	r0, [sp, #48]	; 0x30
c0d00ac8:	4167      	adcs	r7, r4
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
c0d00aca:	6868      	ldr	r0, [r5, #4]
c0d00acc:	17c1      	asrs	r1, r0, #31
c0d00ace:	69f2      	ldr	r2, [r6, #28]
c0d00ad0:	17d3      	asrs	r3, r2, #31
c0d00ad2:	f003 ff17 	bl	c0d04904 <__aeabi_lmul>
c0d00ad6:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d00ad8:	1810      	adds	r0, r2, r0
c0d00ada:	900c      	str	r0, [sp, #48]	; 0x30
c0d00adc:	4179      	adcs	r1, r7
static i25519ptr mul25519(i25519 xy, const i25519 x, const i25519 y) {
	register int64_t t;
	check_nonred("mul input x", x);
	check_nonred("mul input y", y);
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
c0d00ade:	0fc0      	lsrs	r0, r0, #31
c0d00ae0:	0049      	lsls	r1, r1, #1
c0d00ae2:	4301      	orrs	r1, r0
c0d00ae4:	910a      	str	r1, [sp, #40]	; 0x28
 * be. */
static i25519ptr mul25519(i25519 xy, const i25519 x, const i25519 y) {
	register int64_t t;
	check_nonred("mul input x", x);
	check_nonred("mul input y", y);
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
c0d00ae6:	6a28      	ldr	r0, [r5, #32]
c0d00ae8:	17c1      	asrs	r1, r0, #31
c0d00aea:	6832      	ldr	r2, [r6, #0]
c0d00aec:	17d3      	asrs	r3, r2, #31
c0d00aee:	f003 ff09 	bl	c0d04904 <__aeabi_lmul>
c0d00af2:	4607      	mov	r7, r0
c0d00af4:	9109      	str	r1, [sp, #36]	; 0x24
c0d00af6:	69a8      	ldr	r0, [r5, #24]
c0d00af8:	17c1      	asrs	r1, r0, #31
c0d00afa:	68b2      	ldr	r2, [r6, #8]
c0d00afc:	17d3      	asrs	r3, r2, #31
c0d00afe:	f003 ff01 	bl	c0d04904 <__aeabi_lmul>
c0d00b02:	460c      	mov	r4, r1
c0d00b04:	19c0      	adds	r0, r0, r7
c0d00b06:	9007      	str	r0, [sp, #28]
c0d00b08:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d00b0a:	4144      	adcs	r4, r0
c0d00b0c:	6928      	ldr	r0, [r5, #16]
c0d00b0e:	17c1      	asrs	r1, r0, #31
c0d00b10:	6932      	ldr	r2, [r6, #16]
c0d00b12:	17d3      	asrs	r3, r2, #31
c0d00b14:	f003 fef6 	bl	c0d04904 <__aeabi_lmul>
c0d00b18:	460f      	mov	r7, r1
c0d00b1a:	9907      	ldr	r1, [sp, #28]
c0d00b1c:	1808      	adds	r0, r1, r0
c0d00b1e:	9009      	str	r0, [sp, #36]	; 0x24
c0d00b20:	4167      	adcs	r7, r4
c0d00b22:	462c      	mov	r4, r5
c0d00b24:	68a0      	ldr	r0, [r4, #8]
c0d00b26:	17c1      	asrs	r1, r0, #31
c0d00b28:	69b2      	ldr	r2, [r6, #24]
c0d00b2a:	17d3      	asrs	r3, r2, #31
c0d00b2c:	f003 feea 	bl	c0d04904 <__aeabi_lmul>
c0d00b30:	460d      	mov	r5, r1
c0d00b32:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00b34:	1808      	adds	r0, r1, r0
c0d00b36:	9009      	str	r0, [sp, #36]	; 0x24
c0d00b38:	417d      	adcs	r5, r7
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
c0d00b3a:	6820      	ldr	r0, [r4, #0]
c0d00b3c:	4627      	mov	r7, r4
c0d00b3e:	17c1      	asrs	r1, r0, #31
c0d00b40:	9608      	str	r6, [sp, #32]
c0d00b42:	6a32      	ldr	r2, [r6, #32]
c0d00b44:	17d3      	asrs	r3, r2, #31
c0d00b46:	f003 fedd 	bl	c0d04904 <__aeabi_lmul>
c0d00b4a:	460c      	mov	r4, r1
 * be. */
static i25519ptr mul25519(i25519 xy, const i25519 x, const i25519 y) {
	register int64_t t;
	check_nonred("mul input x", x);
	check_nonred("mul input y", y);
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
c0d00b4c:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00b4e:	1808      	adds	r0, r1, r0
c0d00b50:	416c      	adcs	r4, r5
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
c0d00b52:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d00b54:	0049      	lsls	r1, r1, #1
c0d00b56:	1845      	adds	r5, r0, r1
c0d00b58:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00b5a:	4144      	adcs	r4, r0
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
		m64(x[9],y[9]);
c0d00b5c:	6a70      	ldr	r0, [r6, #36]	; 0x24
c0d00b5e:	17c1      	asrs	r1, r0, #31
c0d00b60:	6a7a      	ldr	r2, [r7, #36]	; 0x24
c0d00b62:	463e      	mov	r6, r7
c0d00b64:	17d3      	asrs	r3, r2, #31
c0d00b66:	f003 fecd 	bl	c0d04904 <__aeabi_lmul>
c0d00b6a:	2226      	movs	r2, #38	; 0x26
c0d00b6c:	9206      	str	r2, [sp, #24]
c0d00b6e:	2300      	movs	r3, #0
	register int64_t t;
	check_nonred("mul input x", x);
	check_nonred("mul input y", y);
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
c0d00b70:	930c      	str	r3, [sp, #48]	; 0x30
c0d00b72:	f003 fec7 	bl	c0d04904 <__aeabi_lmul>
c0d00b76:	1828      	adds	r0, r5, r0
c0d00b78:	4161      	adcs	r1, r4
		m64(x[3],y[4]) + m64(x[4],y[3]) + m64(x[5],y[2]) +
		m64(x[6],y[1]) + m64(x[7],y[0]) + 19 * (m64(x[8],y[9]) +
				m64(x[9],y[8]));
	xy[7] = t & ((1 << 25) - 1);
	t = (t >> 25) + xy[8];
	xy[8] = t & ((1 << 26) - 1);
c0d00b7a:	4bfd      	ldr	r3, [pc, #1012]	; (c0d00f70 <mul25519+0x4ec>)
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
		m64(x[9],y[9]);
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
c0d00b7c:	9309      	str	r3, [sp, #36]	; 0x24
c0d00b7e:	0e82      	lsrs	r2, r0, #26
	check_nonred("mul input y", y);
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
		m64(x[9],y[9]);
	xy[8] = t & ((1 << 26) - 1);
c0d00b80:	4018      	ands	r0, r3
c0d00b82:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d00b84:	6218      	str	r0, [r3, #32]
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
c0d00b86:	018d      	lsls	r5, r1, #6
c0d00b88:	4315      	orrs	r5, r2
c0d00b8a:	1688      	asrs	r0, r1, #26
c0d00b8c:	900a      	str	r0, [sp, #40]	; 0x28
c0d00b8e:	6a70      	ldr	r0, [r6, #36]	; 0x24
c0d00b90:	17c1      	asrs	r1, r0, #31
c0d00b92:	9f08      	ldr	r7, [sp, #32]
c0d00b94:	683a      	ldr	r2, [r7, #0]
c0d00b96:	17d3      	asrs	r3, r2, #31
c0d00b98:	f003 feb4 	bl	c0d04904 <__aeabi_lmul>
c0d00b9c:	460c      	mov	r4, r1
c0d00b9e:	1828      	adds	r0, r5, r0
c0d00ba0:	9007      	str	r0, [sp, #28]
c0d00ba2:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00ba4:	4144      	adcs	r4, r0
c0d00ba6:	6a30      	ldr	r0, [r6, #32]
c0d00ba8:	17c1      	asrs	r1, r0, #31
c0d00baa:	687a      	ldr	r2, [r7, #4]
c0d00bac:	17d3      	asrs	r3, r2, #31
c0d00bae:	f003 fea9 	bl	c0d04904 <__aeabi_lmul>
c0d00bb2:	460d      	mov	r5, r1
c0d00bb4:	9907      	ldr	r1, [sp, #28]
c0d00bb6:	1808      	adds	r0, r1, r0
c0d00bb8:	900a      	str	r0, [sp, #40]	; 0x28
c0d00bba:	4165      	adcs	r5, r4
c0d00bbc:	4637      	mov	r7, r6
c0d00bbe:	69f8      	ldr	r0, [r7, #28]
c0d00bc0:	17c1      	asrs	r1, r0, #31
c0d00bc2:	9c08      	ldr	r4, [sp, #32]
c0d00bc4:	68a2      	ldr	r2, [r4, #8]
c0d00bc6:	17d3      	asrs	r3, r2, #31
c0d00bc8:	f003 fe9c 	bl	c0d04904 <__aeabi_lmul>
c0d00bcc:	460e      	mov	r6, r1
c0d00bce:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00bd0:	1808      	adds	r0, r1, r0
c0d00bd2:	900a      	str	r0, [sp, #40]	; 0x28
c0d00bd4:	416e      	adcs	r6, r5
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
c0d00bd6:	69b8      	ldr	r0, [r7, #24]
c0d00bd8:	17c1      	asrs	r1, r0, #31
c0d00bda:	68e2      	ldr	r2, [r4, #12]
c0d00bdc:	17d3      	asrs	r3, r2, #31
c0d00bde:	f003 fe91 	bl	c0d04904 <__aeabi_lmul>
c0d00be2:	460d      	mov	r5, r1
	t = m64(x[0],y[8]) + m64(x[2],y[6]) + m64(x[4],y[4]) + m64(x[6],y[2]) +
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
		m64(x[9],y[9]);
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
c0d00be4:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00be6:	1808      	adds	r0, r1, r0
c0d00be8:	900a      	str	r0, [sp, #40]	; 0x28
c0d00bea:	4175      	adcs	r5, r6
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
c0d00bec:	6978      	ldr	r0, [r7, #20]
c0d00bee:	17c1      	asrs	r1, r0, #31
c0d00bf0:	6922      	ldr	r2, [r4, #16]
c0d00bf2:	4626      	mov	r6, r4
c0d00bf4:	17d3      	asrs	r3, r2, #31
c0d00bf6:	f003 fe85 	bl	c0d04904 <__aeabi_lmul>
c0d00bfa:	460c      	mov	r4, r1
c0d00bfc:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00bfe:	1808      	adds	r0, r1, r0
c0d00c00:	900a      	str	r0, [sp, #40]	; 0x28
c0d00c02:	416c      	adcs	r4, r5
c0d00c04:	6938      	ldr	r0, [r7, #16]
c0d00c06:	17c1      	asrs	r1, r0, #31
c0d00c08:	6972      	ldr	r2, [r6, #20]
c0d00c0a:	17d3      	asrs	r3, r2, #31
c0d00c0c:	f003 fe7a 	bl	c0d04904 <__aeabi_lmul>
c0d00c10:	460d      	mov	r5, r1
c0d00c12:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00c14:	1808      	adds	r0, r1, r0
c0d00c16:	900a      	str	r0, [sp, #40]	; 0x28
c0d00c18:	4165      	adcs	r5, r4
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
c0d00c1a:	68f8      	ldr	r0, [r7, #12]
c0d00c1c:	17c1      	asrs	r1, r0, #31
c0d00c1e:	69b2      	ldr	r2, [r6, #24]
c0d00c20:	17d3      	asrs	r3, r2, #31
c0d00c22:	f003 fe6f 	bl	c0d04904 <__aeabi_lmul>
c0d00c26:	460c      	mov	r4, r1
		m64(x[8],y[0]) + 2 * (m64(x[1],y[7]) + m64(x[3],y[5]) +
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
		m64(x[9],y[9]);
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
c0d00c28:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00c2a:	1808      	adds	r0, r1, r0
c0d00c2c:	900a      	str	r0, [sp, #40]	; 0x28
c0d00c2e:	416c      	adcs	r4, r5
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
c0d00c30:	68b8      	ldr	r0, [r7, #8]
c0d00c32:	17c1      	asrs	r1, r0, #31
c0d00c34:	69f2      	ldr	r2, [r6, #28]
c0d00c36:	17d3      	asrs	r3, r2, #31
c0d00c38:	f003 fe64 	bl	c0d04904 <__aeabi_lmul>
c0d00c3c:	460d      	mov	r5, r1
c0d00c3e:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00c40:	1808      	adds	r0, r1, r0
c0d00c42:	900a      	str	r0, [sp, #40]	; 0x28
c0d00c44:	4165      	adcs	r5, r4
c0d00c46:	6878      	ldr	r0, [r7, #4]
c0d00c48:	17c1      	asrs	r1, r0, #31
c0d00c4a:	6a32      	ldr	r2, [r6, #32]
c0d00c4c:	17d3      	asrs	r3, r2, #31
c0d00c4e:	f003 fe59 	bl	c0d04904 <__aeabi_lmul>
c0d00c52:	460c      	mov	r4, r1
c0d00c54:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00c56:	1808      	adds	r0, r1, r0
c0d00c58:	900a      	str	r0, [sp, #40]	; 0x28
c0d00c5a:	416c      	adcs	r4, r5
		m64(x[9],y[0]);
c0d00c5c:	6838      	ldr	r0, [r7, #0]
c0d00c5e:	17c1      	asrs	r1, r0, #31
c0d00c60:	6a72      	ldr	r2, [r6, #36]	; 0x24
c0d00c62:	17d3      	asrs	r3, r2, #31
c0d00c64:	f003 fe4e 	bl	c0d04904 <__aeabi_lmul>
				m64(x[5],y[3]) + m64(x[7],y[1])) + 38 *
		m64(x[9],y[9]);
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
c0d00c68:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d00c6a:	1810      	adds	r0, r2, r0
c0d00c6c:	4161      	adcs	r1, r4
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[7]) + m64(x[1],y[6]) + m64(x[2],y[5]) +
		m64(x[3],y[4]) + m64(x[4],y[3]) + m64(x[5],y[2]) +
		m64(x[6],y[1]) + m64(x[7],y[0]) + 19 * (m64(x[8],y[9]) +
				m64(x[9],y[8]));
	xy[7] = t & ((1 << 25) - 1);
c0d00c6e:	4bc1      	ldr	r3, [pc, #772]	; (c0d00f74 <mul25519+0x4f0>)
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
		m64(x[9],y[0]);
	xy[9] = t & ((1 << 25) - 1);
	t = m64(x[0],y[0]) + 19 * ((t >> 25) + m64(x[2],y[8]) + m64(x[4],y[6])
c0d00c70:	9307      	str	r3, [sp, #28]
c0d00c72:	0e42      	lsrs	r2, r0, #25
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
		m64(x[9],y[0]);
	xy[9] = t & ((1 << 25) - 1);
c0d00c74:	4018      	ands	r0, r3
c0d00c76:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d00c78:	6258      	str	r0, [r3, #36]	; 0x24
	t = m64(x[0],y[0]) + 19 * ((t >> 25) + m64(x[2],y[8]) + m64(x[4],y[6])
c0d00c7a:	01cd      	lsls	r5, r1, #7
c0d00c7c:	4315      	orrs	r5, r2
c0d00c7e:	1648      	asrs	r0, r1, #25
c0d00c80:	900a      	str	r0, [sp, #40]	; 0x28
c0d00c82:	6a38      	ldr	r0, [r7, #32]
c0d00c84:	17c1      	asrs	r1, r0, #31
c0d00c86:	68b2      	ldr	r2, [r6, #8]
c0d00c88:	17d3      	asrs	r3, r2, #31
c0d00c8a:	f003 fe3b 	bl	c0d04904 <__aeabi_lmul>
c0d00c8e:	460c      	mov	r4, r1
c0d00c90:	1940      	adds	r0, r0, r5
c0d00c92:	9004      	str	r0, [sp, #16]
c0d00c94:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00c96:	4144      	adcs	r4, r0
c0d00c98:	69b8      	ldr	r0, [r7, #24]
c0d00c9a:	17c1      	asrs	r1, r0, #31
c0d00c9c:	6932      	ldr	r2, [r6, #16]
c0d00c9e:	17d3      	asrs	r3, r2, #31
c0d00ca0:	f003 fe30 	bl	c0d04904 <__aeabi_lmul>
c0d00ca4:	460d      	mov	r5, r1
c0d00ca6:	9904      	ldr	r1, [sp, #16]
c0d00ca8:	1808      	adds	r0, r1, r0
c0d00caa:	900a      	str	r0, [sp, #40]	; 0x28
c0d00cac:	4165      	adcs	r5, r4
			+ m64(x[6],y[4]) + m64(x[8],y[2])) + 38 *
c0d00cae:	6938      	ldr	r0, [r7, #16]
c0d00cb0:	17c1      	asrs	r1, r0, #31
c0d00cb2:	69b2      	ldr	r2, [r6, #24]
c0d00cb4:	17d3      	asrs	r3, r2, #31
c0d00cb6:	f003 fe25 	bl	c0d04904 <__aeabi_lmul>
c0d00cba:	460c      	mov	r4, r1
c0d00cbc:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00cbe:	1808      	adds	r0, r1, r0
c0d00cc0:	900a      	str	r0, [sp, #40]	; 0x28
c0d00cc2:	416c      	adcs	r4, r5
c0d00cc4:	68b8      	ldr	r0, [r7, #8]
c0d00cc6:	17c1      	asrs	r1, r0, #31
c0d00cc8:	6a32      	ldr	r2, [r6, #32]
c0d00cca:	17d3      	asrs	r3, r2, #31
c0d00ccc:	f003 fe1a 	bl	c0d04904 <__aeabi_lmul>
c0d00cd0:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d00cd2:	1810      	adds	r0, r2, r0
c0d00cd4:	4161      	adcs	r1, r4
c0d00cd6:	2213      	movs	r2, #19
	t = (t >> 26) + m64(x[0],y[9]) + m64(x[1],y[8]) + m64(x[2],y[7]) +
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
		m64(x[9],y[0]);
	xy[9] = t & ((1 << 25) - 1);
	t = m64(x[0],y[0]) + 19 * ((t >> 25) + m64(x[2],y[8]) + m64(x[4],y[6])
c0d00cd8:	920a      	str	r2, [sp, #40]	; 0x28
c0d00cda:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00cdc:	f003 fe12 	bl	c0d04904 <__aeabi_lmul>
c0d00ce0:	4605      	mov	r5, r0
c0d00ce2:	9103      	str	r1, [sp, #12]
c0d00ce4:	6838      	ldr	r0, [r7, #0]
c0d00ce6:	17c1      	asrs	r1, r0, #31
c0d00ce8:	6832      	ldr	r2, [r6, #0]
c0d00cea:	17d3      	asrs	r3, r2, #31
c0d00cec:	f003 fe0a 	bl	c0d04904 <__aeabi_lmul>
c0d00cf0:	1828      	adds	r0, r5, r0
c0d00cf2:	9004      	str	r0, [sp, #16]
c0d00cf4:	9803      	ldr	r0, [sp, #12]
c0d00cf6:	4141      	adcs	r1, r0
c0d00cf8:	9103      	str	r1, [sp, #12]
			+ m64(x[6],y[4]) + m64(x[8],y[2])) + 38 *
		(m64(x[1],y[9]) + m64(x[3],y[7]) + m64(x[5],y[5]) +
c0d00cfa:	6a78      	ldr	r0, [r7, #36]	; 0x24
c0d00cfc:	17c1      	asrs	r1, r0, #31
c0d00cfe:	6872      	ldr	r2, [r6, #4]
c0d00d00:	17d3      	asrs	r3, r2, #31
c0d00d02:	f003 fdff 	bl	c0d04904 <__aeabi_lmul>
c0d00d06:	4604      	mov	r4, r0
c0d00d08:	9102      	str	r1, [sp, #8]
c0d00d0a:	69f8      	ldr	r0, [r7, #28]
c0d00d0c:	17c1      	asrs	r1, r0, #31
c0d00d0e:	68f2      	ldr	r2, [r6, #12]
c0d00d10:	17d3      	asrs	r3, r2, #31
c0d00d12:	f003 fdf7 	bl	c0d04904 <__aeabi_lmul>
c0d00d16:	460d      	mov	r5, r1
c0d00d18:	1900      	adds	r0, r0, r4
c0d00d1a:	9001      	str	r0, [sp, #4]
c0d00d1c:	9802      	ldr	r0, [sp, #8]
c0d00d1e:	4145      	adcs	r5, r0
c0d00d20:	6978      	ldr	r0, [r7, #20]
c0d00d22:	463c      	mov	r4, r7
c0d00d24:	17c1      	asrs	r1, r0, #31
c0d00d26:	6972      	ldr	r2, [r6, #20]
c0d00d28:	17d3      	asrs	r3, r2, #31
c0d00d2a:	f003 fdeb 	bl	c0d04904 <__aeabi_lmul>
c0d00d2e:	460f      	mov	r7, r1
c0d00d30:	9901      	ldr	r1, [sp, #4]
c0d00d32:	1808      	adds	r0, r1, r0
c0d00d34:	9002      	str	r0, [sp, #8]
c0d00d36:	416f      	adcs	r7, r5
		 m64(x[7],y[3]) + m64(x[9],y[1]));
c0d00d38:	68e0      	ldr	r0, [r4, #12]
c0d00d3a:	17c1      	asrs	r1, r0, #31
c0d00d3c:	69f2      	ldr	r2, [r6, #28]
c0d00d3e:	17d3      	asrs	r3, r2, #31
c0d00d40:	f003 fde0 	bl	c0d04904 <__aeabi_lmul>
c0d00d44:	460d      	mov	r5, r1
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
		m64(x[9],y[0]);
	xy[9] = t & ((1 << 25) - 1);
	t = m64(x[0],y[0]) + 19 * ((t >> 25) + m64(x[2],y[8]) + m64(x[4],y[6])
			+ m64(x[6],y[4]) + m64(x[8],y[2])) + 38 *
		(m64(x[1],y[9]) + m64(x[3],y[7]) + m64(x[5],y[5]) +
c0d00d46:	9902      	ldr	r1, [sp, #8]
c0d00d48:	1808      	adds	r0, r1, r0
c0d00d4a:	9002      	str	r0, [sp, #8]
c0d00d4c:	417d      	adcs	r5, r7
c0d00d4e:	4627      	mov	r7, r4
		 m64(x[7],y[3]) + m64(x[9],y[1]));
c0d00d50:	6878      	ldr	r0, [r7, #4]
c0d00d52:	17c1      	asrs	r1, r0, #31
c0d00d54:	6a72      	ldr	r2, [r6, #36]	; 0x24
c0d00d56:	17d3      	asrs	r3, r2, #31
c0d00d58:	f003 fdd4 	bl	c0d04904 <__aeabi_lmul>
c0d00d5c:	9a02      	ldr	r2, [sp, #8]
c0d00d5e:	1810      	adds	r0, r2, r0
c0d00d60:	4169      	adcs	r1, r5
		m64(x[3],y[6]) + m64(x[4],y[5]) + m64(x[5],y[4]) +
		m64(x[6],y[3]) + m64(x[7],y[2]) + m64(x[8],y[1]) +
		m64(x[9],y[0]);
	xy[9] = t & ((1 << 25) - 1);
	t = m64(x[0],y[0]) + 19 * ((t >> 25) + m64(x[2],y[8]) + m64(x[4],y[6])
			+ m64(x[6],y[4]) + m64(x[8],y[2])) + 38 *
c0d00d62:	9a06      	ldr	r2, [sp, #24]
c0d00d64:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00d66:	f003 fdcd 	bl	c0d04904 <__aeabi_lmul>
c0d00d6a:	9a04      	ldr	r2, [sp, #16]
c0d00d6c:	1810      	adds	r0, r2, r0
c0d00d6e:	9a03      	ldr	r2, [sp, #12]
c0d00d70:	4151      	adcs	r1, r2
		(m64(x[1],y[9]) + m64(x[3],y[7]) + m64(x[5],y[5]) +
		 m64(x[7],y[3]) + m64(x[9],y[1]));
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[1]) + m64(x[1],y[0]) + 19 * (m64(x[2],y[9])
c0d00d72:	0e82      	lsrs	r2, r0, #26
	xy[9] = t & ((1 << 25) - 1);
	t = m64(x[0],y[0]) + 19 * ((t >> 25) + m64(x[2],y[8]) + m64(x[4],y[6])
			+ m64(x[6],y[4]) + m64(x[8],y[2])) + 38 *
		(m64(x[1],y[9]) + m64(x[3],y[7]) + m64(x[5],y[5]) +
		 m64(x[7],y[3]) + m64(x[9],y[1]));
	xy[0] = t & ((1 << 26) - 1);
c0d00d74:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d00d76:	4018      	ands	r0, r3
c0d00d78:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d00d7a:	6018      	str	r0, [r3, #0]
	t = (t >> 26) + m64(x[0],y[1]) + m64(x[1],y[0]) + 19 * (m64(x[2],y[9])
c0d00d7c:	018c      	lsls	r4, r1, #6
c0d00d7e:	4314      	orrs	r4, r2
c0d00d80:	1688      	asrs	r0, r1, #26
c0d00d82:	9004      	str	r0, [sp, #16]
c0d00d84:	6878      	ldr	r0, [r7, #4]
c0d00d86:	17c1      	asrs	r1, r0, #31
c0d00d88:	6832      	ldr	r2, [r6, #0]
c0d00d8a:	17d3      	asrs	r3, r2, #31
c0d00d8c:	f003 fdba 	bl	c0d04904 <__aeabi_lmul>
c0d00d90:	460d      	mov	r5, r1
c0d00d92:	1824      	adds	r4, r4, r0
c0d00d94:	9804      	ldr	r0, [sp, #16]
c0d00d96:	4145      	adcs	r5, r0
c0d00d98:	6838      	ldr	r0, [r7, #0]
c0d00d9a:	17c1      	asrs	r1, r0, #31
c0d00d9c:	6872      	ldr	r2, [r6, #4]
c0d00d9e:	17d3      	asrs	r3, r2, #31
c0d00da0:	f003 fdb0 	bl	c0d04904 <__aeabi_lmul>
c0d00da4:	1820      	adds	r0, r4, r0
c0d00da6:	9004      	str	r0, [sp, #16]
c0d00da8:	4169      	adcs	r1, r5
c0d00daa:	9103      	str	r1, [sp, #12]
c0d00dac:	463c      	mov	r4, r7
c0d00dae:	6a60      	ldr	r0, [r4, #36]	; 0x24
c0d00db0:	17c1      	asrs	r1, r0, #31
c0d00db2:	68b2      	ldr	r2, [r6, #8]
c0d00db4:	17d3      	asrs	r3, r2, #31
c0d00db6:	f003 fda5 	bl	c0d04904 <__aeabi_lmul>
c0d00dba:	4607      	mov	r7, r0
c0d00dbc:	9102      	str	r1, [sp, #8]
			+ m64(x[3],y[8]) + m64(x[4],y[7]) + m64(x[5],y[6]) +
c0d00dbe:	6a20      	ldr	r0, [r4, #32]
c0d00dc0:	17c1      	asrs	r1, r0, #31
c0d00dc2:	68f2      	ldr	r2, [r6, #12]
c0d00dc4:	17d3      	asrs	r3, r2, #31
c0d00dc6:	f003 fd9d 	bl	c0d04904 <__aeabi_lmul>
c0d00dca:	460d      	mov	r5, r1
c0d00dcc:	19c0      	adds	r0, r0, r7
c0d00dce:	9001      	str	r0, [sp, #4]
c0d00dd0:	9802      	ldr	r0, [sp, #8]
c0d00dd2:	4145      	adcs	r5, r0
c0d00dd4:	69e0      	ldr	r0, [r4, #28]
c0d00dd6:	17c1      	asrs	r1, r0, #31
c0d00dd8:	6932      	ldr	r2, [r6, #16]
c0d00dda:	17d3      	asrs	r3, r2, #31
c0d00ddc:	f003 fd92 	bl	c0d04904 <__aeabi_lmul>
c0d00de0:	460f      	mov	r7, r1
c0d00de2:	9901      	ldr	r1, [sp, #4]
c0d00de4:	1808      	adds	r0, r1, r0
c0d00de6:	9002      	str	r0, [sp, #8]
c0d00de8:	416f      	adcs	r7, r5
c0d00dea:	69a0      	ldr	r0, [r4, #24]
c0d00dec:	17c1      	asrs	r1, r0, #31
c0d00dee:	6972      	ldr	r2, [r6, #20]
c0d00df0:	17d3      	asrs	r3, r2, #31
c0d00df2:	f003 fd87 	bl	c0d04904 <__aeabi_lmul>
c0d00df6:	460d      	mov	r5, r1
c0d00df8:	9902      	ldr	r1, [sp, #8]
c0d00dfa:	1808      	adds	r0, r1, r0
c0d00dfc:	9002      	str	r0, [sp, #8]
c0d00dfe:	417d      	adcs	r5, r7
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
c0d00e00:	6960      	ldr	r0, [r4, #20]
c0d00e02:	17c1      	asrs	r1, r0, #31
c0d00e04:	69b2      	ldr	r2, [r6, #24]
c0d00e06:	17d3      	asrs	r3, r2, #31
c0d00e08:	f003 fd7c 	bl	c0d04904 <__aeabi_lmul>
c0d00e0c:	460f      	mov	r7, r1
			+ m64(x[6],y[4]) + m64(x[8],y[2])) + 38 *
		(m64(x[1],y[9]) + m64(x[3],y[7]) + m64(x[5],y[5]) +
		 m64(x[7],y[3]) + m64(x[9],y[1]));
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[1]) + m64(x[1],y[0]) + 19 * (m64(x[2],y[9])
			+ m64(x[3],y[8]) + m64(x[4],y[7]) + m64(x[5],y[6]) +
c0d00e0e:	9902      	ldr	r1, [sp, #8]
c0d00e10:	1808      	adds	r0, r1, r0
c0d00e12:	9002      	str	r0, [sp, #8]
c0d00e14:	416f      	adcs	r7, r5
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
c0d00e16:	6920      	ldr	r0, [r4, #16]
c0d00e18:	17c1      	asrs	r1, r0, #31
c0d00e1a:	69f2      	ldr	r2, [r6, #28]
c0d00e1c:	17d3      	asrs	r3, r2, #31
c0d00e1e:	f003 fd71 	bl	c0d04904 <__aeabi_lmul>
c0d00e22:	460d      	mov	r5, r1
c0d00e24:	9902      	ldr	r1, [sp, #8]
c0d00e26:	1808      	adds	r0, r1, r0
c0d00e28:	9002      	str	r0, [sp, #8]
c0d00e2a:	417d      	adcs	r5, r7
c0d00e2c:	68e0      	ldr	r0, [r4, #12]
c0d00e2e:	9405      	str	r4, [sp, #20]
c0d00e30:	17c1      	asrs	r1, r0, #31
c0d00e32:	6a32      	ldr	r2, [r6, #32]
c0d00e34:	17d3      	asrs	r3, r2, #31
c0d00e36:	f003 fd65 	bl	c0d04904 <__aeabi_lmul>
c0d00e3a:	460f      	mov	r7, r1
c0d00e3c:	9902      	ldr	r1, [sp, #8]
c0d00e3e:	1808      	adds	r0, r1, r0
c0d00e40:	9002      	str	r0, [sp, #8]
c0d00e42:	416f      	adcs	r7, r5
			m64(x[9],y[2]));
c0d00e44:	68a0      	ldr	r0, [r4, #8]
c0d00e46:	17c1      	asrs	r1, r0, #31
c0d00e48:	4635      	mov	r5, r6
c0d00e4a:	6a6a      	ldr	r2, [r5, #36]	; 0x24
c0d00e4c:	17d3      	asrs	r3, r2, #31
c0d00e4e:	f003 fd59 	bl	c0d04904 <__aeabi_lmul>
		(m64(x[1],y[9]) + m64(x[3],y[7]) + m64(x[5],y[5]) +
		 m64(x[7],y[3]) + m64(x[9],y[1]));
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[1]) + m64(x[1],y[0]) + 19 * (m64(x[2],y[9])
			+ m64(x[3],y[8]) + m64(x[4],y[7]) + m64(x[5],y[6]) +
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
c0d00e52:	9a02      	ldr	r2, [sp, #8]
c0d00e54:	1810      	adds	r0, r2, r0
c0d00e56:	4179      	adcs	r1, r7
	t = m64(x[0],y[0]) + 19 * ((t >> 25) + m64(x[2],y[8]) + m64(x[4],y[6])
			+ m64(x[6],y[4]) + m64(x[8],y[2])) + 38 *
		(m64(x[1],y[9]) + m64(x[3],y[7]) + m64(x[5],y[5]) +
		 m64(x[7],y[3]) + m64(x[9],y[1]));
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[1]) + m64(x[1],y[0]) + 19 * (m64(x[2],y[9])
c0d00e58:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d00e5a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00e5c:	f003 fd52 	bl	c0d04904 <__aeabi_lmul>
c0d00e60:	9a04      	ldr	r2, [sp, #16]
c0d00e62:	1810      	adds	r0, r2, r0
c0d00e64:	9a03      	ldr	r2, [sp, #12]
c0d00e66:	4151      	adcs	r1, r2
			+ m64(x[3],y[8]) + m64(x[4],y[7]) + m64(x[5],y[6]) +
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
			m64(x[9],y[2]));
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[2]) + m64(x[2],y[0]) + 19 * (m64(x[4],y[8])
c0d00e68:	0e42      	lsrs	r2, r0, #25
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[1]) + m64(x[1],y[0]) + 19 * (m64(x[2],y[9])
			+ m64(x[3],y[8]) + m64(x[4],y[7]) + m64(x[5],y[6]) +
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
			m64(x[9],y[2]));
	xy[1] = t & ((1 << 25) - 1);
c0d00e6a:	9b07      	ldr	r3, [sp, #28]
c0d00e6c:	4018      	ands	r0, r3
c0d00e6e:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d00e70:	6058      	str	r0, [r3, #4]
	t = (t >> 25) + m64(x[0],y[2]) + m64(x[2],y[0]) + 19 * (m64(x[4],y[8])
c0d00e72:	01cc      	lsls	r4, r1, #7
c0d00e74:	4314      	orrs	r4, r2
c0d00e76:	1648      	asrs	r0, r1, #25
c0d00e78:	9004      	str	r0, [sp, #16]
c0d00e7a:	9e05      	ldr	r6, [sp, #20]
c0d00e7c:	68b0      	ldr	r0, [r6, #8]
c0d00e7e:	17c1      	asrs	r1, r0, #31
c0d00e80:	682a      	ldr	r2, [r5, #0]
c0d00e82:	462f      	mov	r7, r5
c0d00e84:	17d3      	asrs	r3, r2, #31
c0d00e86:	f003 fd3d 	bl	c0d04904 <__aeabi_lmul>
c0d00e8a:	460d      	mov	r5, r1
c0d00e8c:	1824      	adds	r4, r4, r0
c0d00e8e:	9804      	ldr	r0, [sp, #16]
c0d00e90:	4145      	adcs	r5, r0
c0d00e92:	6830      	ldr	r0, [r6, #0]
c0d00e94:	17c1      	asrs	r1, r0, #31
c0d00e96:	68ba      	ldr	r2, [r7, #8]
c0d00e98:	17d3      	asrs	r3, r2, #31
c0d00e9a:	f003 fd33 	bl	c0d04904 <__aeabi_lmul>
c0d00e9e:	1820      	adds	r0, r4, r0
c0d00ea0:	9004      	str	r0, [sp, #16]
c0d00ea2:	4169      	adcs	r1, r5
c0d00ea4:	9103      	str	r1, [sp, #12]
c0d00ea6:	6a30      	ldr	r0, [r6, #32]
c0d00ea8:	17c1      	asrs	r1, r0, #31
c0d00eaa:	463c      	mov	r4, r7
c0d00eac:	6922      	ldr	r2, [r4, #16]
c0d00eae:	17d3      	asrs	r3, r2, #31
c0d00eb0:	f003 fd28 	bl	c0d04904 <__aeabi_lmul>
c0d00eb4:	4607      	mov	r7, r0
c0d00eb6:	9102      	str	r1, [sp, #8]
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
c0d00eb8:	69b0      	ldr	r0, [r6, #24]
c0d00eba:	17c1      	asrs	r1, r0, #31
c0d00ebc:	69a2      	ldr	r2, [r4, #24]
c0d00ebe:	17d3      	asrs	r3, r2, #31
c0d00ec0:	f003 fd20 	bl	c0d04904 <__aeabi_lmul>
c0d00ec4:	460d      	mov	r5, r1
c0d00ec6:	19c7      	adds	r7, r0, r7
c0d00ec8:	9802      	ldr	r0, [sp, #8]
c0d00eca:	4145      	adcs	r5, r0
c0d00ecc:	6930      	ldr	r0, [r6, #16]
c0d00ece:	17c1      	asrs	r1, r0, #31
c0d00ed0:	6a22      	ldr	r2, [r4, #32]
c0d00ed2:	17d3      	asrs	r3, r2, #31
c0d00ed4:	f003 fd16 	bl	c0d04904 <__aeabi_lmul>
c0d00ed8:	1838      	adds	r0, r7, r0
c0d00eda:	4169      	adcs	r1, r5
	t = (t >> 26) + m64(x[0],y[1]) + m64(x[1],y[0]) + 19 * (m64(x[2],y[9])
			+ m64(x[3],y[8]) + m64(x[4],y[7]) + m64(x[5],y[6]) +
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
			m64(x[9],y[2]));
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[2]) + m64(x[2],y[0]) + 19 * (m64(x[4],y[8])
c0d00edc:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d00ede:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00ee0:	f003 fd10 	bl	c0d04904 <__aeabi_lmul>
c0d00ee4:	460f      	mov	r7, r1
c0d00ee6:	9904      	ldr	r1, [sp, #16]
c0d00ee8:	1808      	adds	r0, r1, r0
c0d00eea:	9004      	str	r0, [sp, #16]
c0d00eec:	9803      	ldr	r0, [sp, #12]
c0d00eee:	4147      	adcs	r7, r0
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
c0d00ef0:	6860      	ldr	r0, [r4, #4]
c0d00ef2:	17c1      	asrs	r1, r0, #31
c0d00ef4:	4634      	mov	r4, r6
c0d00ef6:	6862      	ldr	r2, [r4, #4]
c0d00ef8:	17d3      	asrs	r3, r2, #31
c0d00efa:	f003 fd03 	bl	c0d04904 <__aeabi_lmul>
c0d00efe:	0fc2      	lsrs	r2, r0, #31
c0d00f00:	0049      	lsls	r1, r1, #1
c0d00f02:	4311      	orrs	r1, r2
c0d00f04:	0040      	lsls	r0, r0, #1
c0d00f06:	9a04      	ldr	r2, [sp, #16]
c0d00f08:	1810      	adds	r0, r2, r0
c0d00f0a:	9004      	str	r0, [sp, #16]
c0d00f0c:	4179      	adcs	r1, r7
c0d00f0e:	9103      	str	r1, [sp, #12]
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
c0d00f10:	6a60      	ldr	r0, [r4, #36]	; 0x24
c0d00f12:	17c1      	asrs	r1, r0, #31
c0d00f14:	9f08      	ldr	r7, [sp, #32]
c0d00f16:	68fa      	ldr	r2, [r7, #12]
c0d00f18:	17d3      	asrs	r3, r2, #31
c0d00f1a:	f003 fcf3 	bl	c0d04904 <__aeabi_lmul>
c0d00f1e:	4605      	mov	r5, r0
c0d00f20:	9102      	str	r1, [sp, #8]
c0d00f22:	69e0      	ldr	r0, [r4, #28]
c0d00f24:	17c1      	asrs	r1, r0, #31
c0d00f26:	697a      	ldr	r2, [r7, #20]
c0d00f28:	17d3      	asrs	r3, r2, #31
c0d00f2a:	f003 fceb 	bl	c0d04904 <__aeabi_lmul>
c0d00f2e:	460e      	mov	r6, r1
c0d00f30:	1940      	adds	r0, r0, r5
c0d00f32:	9001      	str	r0, [sp, #4]
c0d00f34:	9802      	ldr	r0, [sp, #8]
c0d00f36:	4146      	adcs	r6, r0
					m64(x[7],y[5]) + m64(x[9],y[3]));
c0d00f38:	6960      	ldr	r0, [r4, #20]
c0d00f3a:	17c1      	asrs	r1, r0, #31
c0d00f3c:	69fa      	ldr	r2, [r7, #28]
c0d00f3e:	17d3      	asrs	r3, r2, #31
c0d00f40:	f003 fce0 	bl	c0d04904 <__aeabi_lmul>
c0d00f44:	460d      	mov	r5, r1
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
			m64(x[9],y[2]));
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[2]) + m64(x[2],y[0]) + 19 * (m64(x[4],y[8])
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
c0d00f46:	9901      	ldr	r1, [sp, #4]
c0d00f48:	1808      	adds	r0, r1, r0
c0d00f4a:	9002      	str	r0, [sp, #8]
c0d00f4c:	4175      	adcs	r5, r6
					m64(x[7],y[5]) + m64(x[9],y[3]));
c0d00f4e:	68e0      	ldr	r0, [r4, #12]
c0d00f50:	4626      	mov	r6, r4
c0d00f52:	17c1      	asrs	r1, r0, #31
c0d00f54:	463c      	mov	r4, r7
c0d00f56:	6a62      	ldr	r2, [r4, #36]	; 0x24
c0d00f58:	17d3      	asrs	r3, r2, #31
c0d00f5a:	f003 fcd3 	bl	c0d04904 <__aeabi_lmul>
c0d00f5e:	9a02      	ldr	r2, [sp, #8]
c0d00f60:	1810      	adds	r0, r2, r0
c0d00f62:	4169      	adcs	r1, r5
			m64(x[6],y[5]) + m64(x[7],y[4]) + m64(x[8],y[3]) +
			m64(x[9],y[2]));
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[2]) + m64(x[2],y[0]) + 19 * (m64(x[4],y[8])
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
c0d00f64:	9a06      	ldr	r2, [sp, #24]
c0d00f66:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00f68:	f003 fccc 	bl	c0d04904 <__aeabi_lmul>
c0d00f6c:	9a04      	ldr	r2, [sp, #16]
c0d00f6e:	e003      	b.n	c0d00f78 <mul25519+0x4f4>
c0d00f70:	03ffffff 	.word	0x03ffffff
c0d00f74:	01ffffff 	.word	0x01ffffff
c0d00f78:	1810      	adds	r0, r2, r0
c0d00f7a:	9a03      	ldr	r2, [sp, #12]
c0d00f7c:	4151      	adcs	r1, r2
					m64(x[7],y[5]) + m64(x[9],y[3]));
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
c0d00f7e:	0e82      	lsrs	r2, r0, #26
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[2]) + m64(x[2],y[0]) + 19 * (m64(x[4],y[8])
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
					m64(x[7],y[5]) + m64(x[9],y[3]));
	xy[2] = t & ((1 << 26) - 1);
c0d00f80:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d00f82:	4018      	ands	r0, r3
c0d00f84:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d00f86:	6098      	str	r0, [r3, #8]
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
c0d00f88:	018d      	lsls	r5, r1, #6
c0d00f8a:	4315      	orrs	r5, r2
c0d00f8c:	1688      	asrs	r0, r1, #26
c0d00f8e:	9004      	str	r0, [sp, #16]
c0d00f90:	68f0      	ldr	r0, [r6, #12]
c0d00f92:	4637      	mov	r7, r6
c0d00f94:	17c1      	asrs	r1, r0, #31
c0d00f96:	6822      	ldr	r2, [r4, #0]
c0d00f98:	4626      	mov	r6, r4
c0d00f9a:	17d3      	asrs	r3, r2, #31
c0d00f9c:	f003 fcb2 	bl	c0d04904 <__aeabi_lmul>
c0d00fa0:	460c      	mov	r4, r1
c0d00fa2:	1828      	adds	r0, r5, r0
c0d00fa4:	9003      	str	r0, [sp, #12]
c0d00fa6:	9804      	ldr	r0, [sp, #16]
c0d00fa8:	4144      	adcs	r4, r0
c0d00faa:	68b8      	ldr	r0, [r7, #8]
c0d00fac:	17c1      	asrs	r1, r0, #31
c0d00fae:	6872      	ldr	r2, [r6, #4]
c0d00fb0:	17d3      	asrs	r3, r2, #31
c0d00fb2:	f003 fca7 	bl	c0d04904 <__aeabi_lmul>
c0d00fb6:	460d      	mov	r5, r1
c0d00fb8:	9903      	ldr	r1, [sp, #12]
c0d00fba:	1808      	adds	r0, r1, r0
c0d00fbc:	9004      	str	r0, [sp, #16]
c0d00fbe:	4165      	adcs	r5, r4
c0d00fc0:	463c      	mov	r4, r7
c0d00fc2:	6860      	ldr	r0, [r4, #4]
c0d00fc4:	17c1      	asrs	r1, r0, #31
c0d00fc6:	68b2      	ldr	r2, [r6, #8]
c0d00fc8:	17d3      	asrs	r3, r2, #31
c0d00fca:	f003 fc9b 	bl	c0d04904 <__aeabi_lmul>
c0d00fce:	460f      	mov	r7, r1
c0d00fd0:	9904      	ldr	r1, [sp, #16]
c0d00fd2:	1808      	adds	r0, r1, r0
c0d00fd4:	9004      	str	r0, [sp, #16]
c0d00fd6:	416f      	adcs	r7, r5
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
c0d00fd8:	6820      	ldr	r0, [r4, #0]
c0d00fda:	17c1      	asrs	r1, r0, #31
c0d00fdc:	68f2      	ldr	r2, [r6, #12]
c0d00fde:	17d3      	asrs	r3, r2, #31
c0d00fe0:	f003 fc90 	bl	c0d04904 <__aeabi_lmul>
	t = (t >> 25) + m64(x[0],y[2]) + m64(x[2],y[0]) + 19 * (m64(x[4],y[8])
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
					m64(x[7],y[5]) + m64(x[9],y[3]));
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
c0d00fe4:	9a04      	ldr	r2, [sp, #16]
c0d00fe6:	1810      	adds	r0, r2, r0
c0d00fe8:	9004      	str	r0, [sp, #16]
c0d00fea:	4179      	adcs	r1, r7
c0d00fec:	9103      	str	r1, [sp, #12]
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
c0d00fee:	6a60      	ldr	r0, [r4, #36]	; 0x24
c0d00ff0:	17c1      	asrs	r1, r0, #31
c0d00ff2:	6932      	ldr	r2, [r6, #16]
c0d00ff4:	17d3      	asrs	r3, r2, #31
c0d00ff6:	f003 fc85 	bl	c0d04904 <__aeabi_lmul>
c0d00ffa:	4607      	mov	r7, r0
c0d00ffc:	9102      	str	r1, [sp, #8]
c0d00ffe:	6a20      	ldr	r0, [r4, #32]
c0d01000:	17c1      	asrs	r1, r0, #31
c0d01002:	6972      	ldr	r2, [r6, #20]
c0d01004:	17d3      	asrs	r3, r2, #31
c0d01006:	f003 fc7d 	bl	c0d04904 <__aeabi_lmul>
c0d0100a:	460d      	mov	r5, r1
c0d0100c:	19c0      	adds	r0, r0, r7
c0d0100e:	9001      	str	r0, [sp, #4]
c0d01010:	9802      	ldr	r0, [sp, #8]
c0d01012:	4145      	adcs	r5, r0
				m64(x[6],y[7]) + m64(x[7],y[6]) +
c0d01014:	69e0      	ldr	r0, [r4, #28]
c0d01016:	17c1      	asrs	r1, r0, #31
c0d01018:	69b2      	ldr	r2, [r6, #24]
c0d0101a:	17d3      	asrs	r3, r2, #31
c0d0101c:	f003 fc72 	bl	c0d04904 <__aeabi_lmul>
c0d01020:	460f      	mov	r7, r1
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
					m64(x[7],y[5]) + m64(x[9],y[3]));
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
c0d01022:	9901      	ldr	r1, [sp, #4]
c0d01024:	1808      	adds	r0, r1, r0
c0d01026:	9002      	str	r0, [sp, #8]
c0d01028:	416f      	adcs	r7, r5
				m64(x[6],y[7]) + m64(x[7],y[6]) +
c0d0102a:	69a0      	ldr	r0, [r4, #24]
c0d0102c:	17c1      	asrs	r1, r0, #31
c0d0102e:	69f2      	ldr	r2, [r6, #28]
c0d01030:	17d3      	asrs	r3, r2, #31
c0d01032:	f003 fc67 	bl	c0d04904 <__aeabi_lmul>
c0d01036:	460d      	mov	r5, r1
c0d01038:	9902      	ldr	r1, [sp, #8]
c0d0103a:	1808      	adds	r0, r1, r0
c0d0103c:	9002      	str	r0, [sp, #8]
c0d0103e:	417d      	adcs	r5, r7
				m64(x[8],y[5]) + m64(x[9],y[4]));
c0d01040:	6960      	ldr	r0, [r4, #20]
c0d01042:	17c1      	asrs	r1, r0, #31
c0d01044:	6a32      	ldr	r2, [r6, #32]
c0d01046:	17d3      	asrs	r3, r2, #31
c0d01048:	f003 fc5c 	bl	c0d04904 <__aeabi_lmul>
c0d0104c:	460f      	mov	r7, r1
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
					m64(x[7],y[5]) + m64(x[9],y[3]));
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
				m64(x[6],y[7]) + m64(x[7],y[6]) +
c0d0104e:	9902      	ldr	r1, [sp, #8]
c0d01050:	1808      	adds	r0, r1, r0
c0d01052:	9002      	str	r0, [sp, #8]
c0d01054:	416f      	adcs	r7, r5
				m64(x[8],y[5]) + m64(x[9],y[4]));
c0d01056:	6920      	ldr	r0, [r4, #16]
c0d01058:	17c1      	asrs	r1, r0, #31
c0d0105a:	6a72      	ldr	r2, [r6, #36]	; 0x24
c0d0105c:	17d3      	asrs	r3, r2, #31
c0d0105e:	f003 fc51 	bl	c0d04904 <__aeabi_lmul>
c0d01062:	9a02      	ldr	r2, [sp, #8]
c0d01064:	1810      	adds	r0, r2, r0
c0d01066:	4179      	adcs	r1, r7
			+ m64(x[6],y[6]) + m64(x[8],y[4])) + 2 * m64(x[1],y[1])
			+ 38 * (m64(x[3],y[9]) + m64(x[5],y[7]) +
					m64(x[7],y[5]) + m64(x[9],y[3]));
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
c0d01068:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d0106a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0106c:	f003 fc4a 	bl	c0d04904 <__aeabi_lmul>
c0d01070:	9a04      	ldr	r2, [sp, #16]
c0d01072:	1810      	adds	r0, r2, r0
c0d01074:	9a03      	ldr	r2, [sp, #12]
c0d01076:	4151      	adcs	r1, r2
				m64(x[6],y[7]) + m64(x[7],y[6]) +
				m64(x[8],y[5]) + m64(x[9],y[4]));
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[4]) + m64(x[2],y[2]) + m64(x[4],y[0]) + 19 *
c0d01078:	0e42      	lsrs	r2, r0, #25
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
				m64(x[6],y[7]) + m64(x[7],y[6]) +
				m64(x[8],y[5]) + m64(x[9],y[4]));
	xy[3] = t & ((1 << 25) - 1);
c0d0107a:	9b07      	ldr	r3, [sp, #28]
c0d0107c:	4018      	ands	r0, r3
c0d0107e:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d01080:	60d8      	str	r0, [r3, #12]
	t = (t >> 25) + m64(x[0],y[4]) + m64(x[2],y[2]) + m64(x[4],y[0]) + 19 *
c0d01082:	01cf      	lsls	r7, r1, #7
c0d01084:	4317      	orrs	r7, r2
c0d01086:	1648      	asrs	r0, r1, #25
c0d01088:	9004      	str	r0, [sp, #16]
c0d0108a:	6920      	ldr	r0, [r4, #16]
c0d0108c:	17c1      	asrs	r1, r0, #31
c0d0108e:	4635      	mov	r5, r6
c0d01090:	682a      	ldr	r2, [r5, #0]
c0d01092:	17d3      	asrs	r3, r2, #31
c0d01094:	f003 fc36 	bl	c0d04904 <__aeabi_lmul>
c0d01098:	460e      	mov	r6, r1
c0d0109a:	1838      	adds	r0, r7, r0
c0d0109c:	9003      	str	r0, [sp, #12]
c0d0109e:	9804      	ldr	r0, [sp, #16]
c0d010a0:	4146      	adcs	r6, r0
c0d010a2:	68a0      	ldr	r0, [r4, #8]
c0d010a4:	17c1      	asrs	r1, r0, #31
c0d010a6:	68aa      	ldr	r2, [r5, #8]
c0d010a8:	462f      	mov	r7, r5
c0d010aa:	17d3      	asrs	r3, r2, #31
c0d010ac:	f003 fc2a 	bl	c0d04904 <__aeabi_lmul>
c0d010b0:	460d      	mov	r5, r1
c0d010b2:	9903      	ldr	r1, [sp, #12]
c0d010b4:	1808      	adds	r0, r1, r0
c0d010b6:	9004      	str	r0, [sp, #16]
c0d010b8:	4175      	adcs	r5, r6
c0d010ba:	6820      	ldr	r0, [r4, #0]
c0d010bc:	17c1      	asrs	r1, r0, #31
c0d010be:	693a      	ldr	r2, [r7, #16]
c0d010c0:	17d3      	asrs	r3, r2, #31
c0d010c2:	f003 fc1f 	bl	c0d04904 <__aeabi_lmul>
c0d010c6:	9a04      	ldr	r2, [sp, #16]
c0d010c8:	1810      	adds	r0, r2, r0
c0d010ca:	9004      	str	r0, [sp, #16]
c0d010cc:	4169      	adcs	r1, r5
c0d010ce:	9103      	str	r1, [sp, #12]
		(m64(x[6],y[8]) + m64(x[8],y[6])) + 2 * (m64(x[1],y[3]) +
c0d010d0:	6a20      	ldr	r0, [r4, #32]
c0d010d2:	17c1      	asrs	r1, r0, #31
c0d010d4:	463e      	mov	r6, r7
c0d010d6:	69b2      	ldr	r2, [r6, #24]
c0d010d8:	17d3      	asrs	r3, r2, #31
c0d010da:	f003 fc13 	bl	c0d04904 <__aeabi_lmul>
c0d010de:	4605      	mov	r5, r0
c0d010e0:	460f      	mov	r7, r1
c0d010e2:	69a0      	ldr	r0, [r4, #24]
c0d010e4:	17c1      	asrs	r1, r0, #31
c0d010e6:	6a32      	ldr	r2, [r6, #32]
c0d010e8:	4634      	mov	r4, r6
c0d010ea:	17d3      	asrs	r3, r2, #31
c0d010ec:	f003 fc0a 	bl	c0d04904 <__aeabi_lmul>
c0d010f0:	1940      	adds	r0, r0, r5
c0d010f2:	4179      	adcs	r1, r7
	t = (t >> 26) + m64(x[0],y[3]) + m64(x[1],y[2]) + m64(x[2],y[1]) +
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
				m64(x[6],y[7]) + m64(x[7],y[6]) +
				m64(x[8],y[5]) + m64(x[9],y[4]));
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[4]) + m64(x[2],y[2]) + m64(x[4],y[0]) + 19 *
c0d010f4:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d010f6:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d010f8:	f003 fc04 	bl	c0d04904 <__aeabi_lmul>
c0d010fc:	460d      	mov	r5, r1
c0d010fe:	9904      	ldr	r1, [sp, #16]
c0d01100:	1808      	adds	r0, r1, r0
c0d01102:	9004      	str	r0, [sp, #16]
c0d01104:	9803      	ldr	r0, [sp, #12]
c0d01106:	4145      	adcs	r5, r0
c0d01108:	9e05      	ldr	r6, [sp, #20]
		(m64(x[6],y[8]) + m64(x[8],y[6])) + 2 * (m64(x[1],y[3]) +
c0d0110a:	68f0      	ldr	r0, [r6, #12]
c0d0110c:	17c1      	asrs	r1, r0, #31
c0d0110e:	4627      	mov	r7, r4
c0d01110:	687a      	ldr	r2, [r7, #4]
c0d01112:	17d3      	asrs	r3, r2, #31
c0d01114:	f003 fbf6 	bl	c0d04904 <__aeabi_lmul>
c0d01118:	9002      	str	r0, [sp, #8]
c0d0111a:	9103      	str	r1, [sp, #12]
							 m64(x[3],y[1])) + 38 *
c0d0111c:	6870      	ldr	r0, [r6, #4]
c0d0111e:	17c1      	asrs	r1, r0, #31
c0d01120:	68fa      	ldr	r2, [r7, #12]
c0d01122:	17d3      	asrs	r3, r2, #31
c0d01124:	f003 fbee 	bl	c0d04904 <__aeabi_lmul>
		m64(x[3],y[0]) + 19 * (m64(x[4],y[9]) + m64(x[5],y[8]) +
				m64(x[6],y[7]) + m64(x[7],y[6]) +
				m64(x[8],y[5]) + m64(x[9],y[4]));
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[4]) + m64(x[2],y[2]) + m64(x[4],y[0]) + 19 *
		(m64(x[6],y[8]) + m64(x[8],y[6])) + 2 * (m64(x[1],y[3]) +
c0d01128:	9a02      	ldr	r2, [sp, #8]
c0d0112a:	1880      	adds	r0, r0, r2
c0d0112c:	9a03      	ldr	r2, [sp, #12]
c0d0112e:	4151      	adcs	r1, r2
c0d01130:	0fc2      	lsrs	r2, r0, #31
c0d01132:	004e      	lsls	r6, r1, #1
c0d01134:	4316      	orrs	r6, r2
c0d01136:	0040      	lsls	r0, r0, #1
c0d01138:	9904      	ldr	r1, [sp, #16]
c0d0113a:	1808      	adds	r0, r1, r0
c0d0113c:	9004      	str	r0, [sp, #16]
c0d0113e:	416e      	adcs	r6, r5
c0d01140:	9d05      	ldr	r5, [sp, #20]
							 m64(x[3],y[1])) + 38 *
		(m64(x[5],y[9]) + m64(x[7],y[7]) + m64(x[9],y[5]));
c0d01142:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01144:	17c1      	asrs	r1, r0, #31
c0d01146:	697a      	ldr	r2, [r7, #20]
c0d01148:	17d3      	asrs	r3, r2, #31
c0d0114a:	f003 fbdb 	bl	c0d04904 <__aeabi_lmul>
c0d0114e:	9002      	str	r0, [sp, #8]
c0d01150:	9103      	str	r1, [sp, #12]
c0d01152:	69e8      	ldr	r0, [r5, #28]
c0d01154:	17c1      	asrs	r1, r0, #31
c0d01156:	69fa      	ldr	r2, [r7, #28]
c0d01158:	17d3      	asrs	r3, r2, #31
c0d0115a:	f003 fbd3 	bl	c0d04904 <__aeabi_lmul>
c0d0115e:	460c      	mov	r4, r1
c0d01160:	9902      	ldr	r1, [sp, #8]
c0d01162:	1840      	adds	r0, r0, r1
c0d01164:	9002      	str	r0, [sp, #8]
c0d01166:	9803      	ldr	r0, [sp, #12]
c0d01168:	4144      	adcs	r4, r0
c0d0116a:	6968      	ldr	r0, [r5, #20]
c0d0116c:	17c1      	asrs	r1, r0, #31
c0d0116e:	6a7a      	ldr	r2, [r7, #36]	; 0x24
c0d01170:	17d3      	asrs	r3, r2, #31
c0d01172:	f003 fbc7 	bl	c0d04904 <__aeabi_lmul>
c0d01176:	9a02      	ldr	r2, [sp, #8]
c0d01178:	1810      	adds	r0, r2, r0
c0d0117a:	4161      	adcs	r1, r4
				m64(x[6],y[7]) + m64(x[7],y[6]) +
				m64(x[8],y[5]) + m64(x[9],y[4]));
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[4]) + m64(x[2],y[2]) + m64(x[4],y[0]) + 19 *
		(m64(x[6],y[8]) + m64(x[8],y[6])) + 2 * (m64(x[1],y[3]) +
							 m64(x[3],y[1])) + 38 *
c0d0117c:	9a06      	ldr	r2, [sp, #24]
c0d0117e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01180:	f003 fbc0 	bl	c0d04904 <__aeabi_lmul>
c0d01184:	9a04      	ldr	r2, [sp, #16]
c0d01186:	1810      	adds	r0, r2, r0
c0d01188:	4171      	adcs	r1, r6
		(m64(x[5],y[9]) + m64(x[7],y[7]) + m64(x[9],y[5]));
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[5]) + m64(x[1],y[4]) + m64(x[2],y[3]) +
c0d0118a:	0e82      	lsrs	r2, r0, #26
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[4]) + m64(x[2],y[2]) + m64(x[4],y[0]) + 19 *
		(m64(x[6],y[8]) + m64(x[8],y[6])) + 2 * (m64(x[1],y[3]) +
							 m64(x[3],y[1])) + 38 *
		(m64(x[5],y[9]) + m64(x[7],y[7]) + m64(x[9],y[5]));
	xy[4] = t & ((1 << 26) - 1);
c0d0118c:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d0118e:	4018      	ands	r0, r3
c0d01190:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d01192:	6118      	str	r0, [r3, #16]
	t = (t >> 26) + m64(x[0],y[5]) + m64(x[1],y[4]) + m64(x[2],y[3]) +
c0d01194:	018f      	lsls	r7, r1, #6
c0d01196:	4317      	orrs	r7, r2
c0d01198:	1688      	asrs	r0, r1, #26
c0d0119a:	9004      	str	r0, [sp, #16]
c0d0119c:	6968      	ldr	r0, [r5, #20]
c0d0119e:	17c1      	asrs	r1, r0, #31
c0d011a0:	9c08      	ldr	r4, [sp, #32]
c0d011a2:	6822      	ldr	r2, [r4, #0]
c0d011a4:	17d3      	asrs	r3, r2, #31
c0d011a6:	f003 fbad 	bl	c0d04904 <__aeabi_lmul>
c0d011aa:	460e      	mov	r6, r1
c0d011ac:	1838      	adds	r0, r7, r0
c0d011ae:	9003      	str	r0, [sp, #12]
c0d011b0:	9804      	ldr	r0, [sp, #16]
c0d011b2:	4146      	adcs	r6, r0
c0d011b4:	6928      	ldr	r0, [r5, #16]
c0d011b6:	462f      	mov	r7, r5
c0d011b8:	17c1      	asrs	r1, r0, #31
c0d011ba:	6862      	ldr	r2, [r4, #4]
c0d011bc:	17d3      	asrs	r3, r2, #31
c0d011be:	f003 fba1 	bl	c0d04904 <__aeabi_lmul>
c0d011c2:	460d      	mov	r5, r1
c0d011c4:	9903      	ldr	r1, [sp, #12]
c0d011c6:	1808      	adds	r0, r1, r0
c0d011c8:	9004      	str	r0, [sp, #16]
c0d011ca:	4175      	adcs	r5, r6
c0d011cc:	463e      	mov	r6, r7
c0d011ce:	68f0      	ldr	r0, [r6, #12]
c0d011d0:	17c1      	asrs	r1, r0, #31
c0d011d2:	68a2      	ldr	r2, [r4, #8]
c0d011d4:	4627      	mov	r7, r4
c0d011d6:	17d3      	asrs	r3, r2, #31
c0d011d8:	f003 fb94 	bl	c0d04904 <__aeabi_lmul>
c0d011dc:	460c      	mov	r4, r1
c0d011de:	9904      	ldr	r1, [sp, #16]
c0d011e0:	1808      	adds	r0, r1, r0
c0d011e2:	9004      	str	r0, [sp, #16]
c0d011e4:	416c      	adcs	r4, r5
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
c0d011e6:	68b0      	ldr	r0, [r6, #8]
c0d011e8:	17c1      	asrs	r1, r0, #31
c0d011ea:	68fa      	ldr	r2, [r7, #12]
c0d011ec:	17d3      	asrs	r3, r2, #31
c0d011ee:	f003 fb89 	bl	c0d04904 <__aeabi_lmul>
c0d011f2:	460d      	mov	r5, r1
	t = (t >> 25) + m64(x[0],y[4]) + m64(x[2],y[2]) + m64(x[4],y[0]) + 19 *
		(m64(x[6],y[8]) + m64(x[8],y[6])) + 2 * (m64(x[1],y[3]) +
							 m64(x[3],y[1])) + 38 *
		(m64(x[5],y[9]) + m64(x[7],y[7]) + m64(x[9],y[5]));
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[5]) + m64(x[1],y[4]) + m64(x[2],y[3]) +
c0d011f4:	9904      	ldr	r1, [sp, #16]
c0d011f6:	1808      	adds	r0, r1, r0
c0d011f8:	9004      	str	r0, [sp, #16]
c0d011fa:	4165      	adcs	r5, r4
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
c0d011fc:	6870      	ldr	r0, [r6, #4]
c0d011fe:	17c1      	asrs	r1, r0, #31
c0d01200:	693a      	ldr	r2, [r7, #16]
c0d01202:	17d3      	asrs	r3, r2, #31
c0d01204:	f003 fb7e 	bl	c0d04904 <__aeabi_lmul>
c0d01208:	460c      	mov	r4, r1
c0d0120a:	9904      	ldr	r1, [sp, #16]
c0d0120c:	1808      	adds	r0, r1, r0
c0d0120e:	9004      	str	r0, [sp, #16]
c0d01210:	416c      	adcs	r4, r5
c0d01212:	6830      	ldr	r0, [r6, #0]
c0d01214:	17c1      	asrs	r1, r0, #31
c0d01216:	697a      	ldr	r2, [r7, #20]
c0d01218:	17d3      	asrs	r3, r2, #31
c0d0121a:	f003 fb73 	bl	c0d04904 <__aeabi_lmul>
c0d0121e:	9a04      	ldr	r2, [sp, #16]
c0d01220:	1810      	adds	r0, r2, r0
c0d01222:	9004      	str	r0, [sp, #16]
c0d01224:	4161      	adcs	r1, r4
c0d01226:	9103      	str	r1, [sp, #12]
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
c0d01228:	6a70      	ldr	r0, [r6, #36]	; 0x24
c0d0122a:	17c1      	asrs	r1, r0, #31
c0d0122c:	463c      	mov	r4, r7
c0d0122e:	69a2      	ldr	r2, [r4, #24]
c0d01230:	17d3      	asrs	r3, r2, #31
c0d01232:	f003 fb67 	bl	c0d04904 <__aeabi_lmul>
c0d01236:	4607      	mov	r7, r0
c0d01238:	9102      	str	r1, [sp, #8]
c0d0123a:	6a30      	ldr	r0, [r6, #32]
c0d0123c:	17c1      	asrs	r1, r0, #31
c0d0123e:	69e2      	ldr	r2, [r4, #28]
c0d01240:	17d3      	asrs	r3, r2, #31
c0d01242:	f003 fb5f 	bl	c0d04904 <__aeabi_lmul>
c0d01246:	460d      	mov	r5, r1
c0d01248:	19c0      	adds	r0, r0, r7
c0d0124a:	9001      	str	r0, [sp, #4]
c0d0124c:	9802      	ldr	r0, [sp, #8]
c0d0124e:	4145      	adcs	r5, r0
c0d01250:	69f0      	ldr	r0, [r6, #28]
c0d01252:	17c1      	asrs	r1, r0, #31
c0d01254:	6a22      	ldr	r2, [r4, #32]
c0d01256:	17d3      	asrs	r3, r2, #31
c0d01258:	f003 fb54 	bl	c0d04904 <__aeabi_lmul>
c0d0125c:	460f      	mov	r7, r1
c0d0125e:	9901      	ldr	r1, [sp, #4]
c0d01260:	1808      	adds	r0, r1, r0
c0d01262:	9002      	str	r0, [sp, #8]
c0d01264:	416f      	adcs	r7, r5
		 m64(x[9],y[6]));
c0d01266:	69b0      	ldr	r0, [r6, #24]
c0d01268:	17c1      	asrs	r1, r0, #31
c0d0126a:	6a62      	ldr	r2, [r4, #36]	; 0x24
c0d0126c:	17d3      	asrs	r3, r2, #31
c0d0126e:	f003 fb49 	bl	c0d04904 <__aeabi_lmul>
							 m64(x[3],y[1])) + 38 *
		(m64(x[5],y[9]) + m64(x[7],y[7]) + m64(x[9],y[5]));
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[5]) + m64(x[1],y[4]) + m64(x[2],y[3]) +
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
c0d01272:	9a02      	ldr	r2, [sp, #8]
c0d01274:	1810      	adds	r0, r2, r0
c0d01276:	4179      	adcs	r1, r7
		(m64(x[6],y[8]) + m64(x[8],y[6])) + 2 * (m64(x[1],y[3]) +
							 m64(x[3],y[1])) + 38 *
		(m64(x[5],y[9]) + m64(x[7],y[7]) + m64(x[9],y[5]));
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[5]) + m64(x[1],y[4]) + m64(x[2],y[3]) +
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
c0d01278:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d0127a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0127c:	f003 fb42 	bl	c0d04904 <__aeabi_lmul>
c0d01280:	9a04      	ldr	r2, [sp, #16]
c0d01282:	1810      	adds	r0, r2, r0
c0d01284:	9a03      	ldr	r2, [sp, #12]
c0d01286:	4151      	adcs	r1, r2
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
		 m64(x[9],y[6]));
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
c0d01288:	0e42      	lsrs	r2, r0, #25
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[5]) + m64(x[1],y[4]) + m64(x[2],y[3]) +
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
		 m64(x[9],y[6]));
	xy[5] = t & ((1 << 25) - 1);
c0d0128a:	9b07      	ldr	r3, [sp, #28]
c0d0128c:	4018      	ands	r0, r3
c0d0128e:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d01290:	6158      	str	r0, [r3, #20]
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
c0d01292:	01cd      	lsls	r5, r1, #7
c0d01294:	4315      	orrs	r5, r2
c0d01296:	1648      	asrs	r0, r1, #25
c0d01298:	9004      	str	r0, [sp, #16]
c0d0129a:	69b0      	ldr	r0, [r6, #24]
c0d0129c:	17c1      	asrs	r1, r0, #31
c0d0129e:	4627      	mov	r7, r4
c0d012a0:	683a      	ldr	r2, [r7, #0]
c0d012a2:	17d3      	asrs	r3, r2, #31
c0d012a4:	f003 fb2e 	bl	c0d04904 <__aeabi_lmul>
c0d012a8:	460c      	mov	r4, r1
c0d012aa:	1828      	adds	r0, r5, r0
c0d012ac:	9003      	str	r0, [sp, #12]
c0d012ae:	9804      	ldr	r0, [sp, #16]
c0d012b0:	4144      	adcs	r4, r0
c0d012b2:	6930      	ldr	r0, [r6, #16]
c0d012b4:	17c1      	asrs	r1, r0, #31
c0d012b6:	68ba      	ldr	r2, [r7, #8]
c0d012b8:	17d3      	asrs	r3, r2, #31
c0d012ba:	f003 fb23 	bl	c0d04904 <__aeabi_lmul>
c0d012be:	460d      	mov	r5, r1
c0d012c0:	9903      	ldr	r1, [sp, #12]
c0d012c2:	1808      	adds	r0, r1, r0
c0d012c4:	9004      	str	r0, [sp, #16]
c0d012c6:	4165      	adcs	r5, r4
c0d012c8:	4634      	mov	r4, r6
c0d012ca:	68a0      	ldr	r0, [r4, #8]
c0d012cc:	17c1      	asrs	r1, r0, #31
c0d012ce:	693a      	ldr	r2, [r7, #16]
c0d012d0:	17d3      	asrs	r3, r2, #31
c0d012d2:	f003 fb17 	bl	c0d04904 <__aeabi_lmul>
c0d012d6:	460e      	mov	r6, r1
c0d012d8:	9904      	ldr	r1, [sp, #16]
c0d012da:	1808      	adds	r0, r1, r0
c0d012dc:	9004      	str	r0, [sp, #16]
c0d012de:	416e      	adcs	r6, r5
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
c0d012e0:	6820      	ldr	r0, [r4, #0]
c0d012e2:	4625      	mov	r5, r4
c0d012e4:	17c1      	asrs	r1, r0, #31
c0d012e6:	463c      	mov	r4, r7
c0d012e8:	69a2      	ldr	r2, [r4, #24]
c0d012ea:	17d3      	asrs	r3, r2, #31
c0d012ec:	f003 fb0a 	bl	c0d04904 <__aeabi_lmul>
c0d012f0:	460f      	mov	r7, r1
	t = (t >> 26) + m64(x[0],y[5]) + m64(x[1],y[4]) + m64(x[2],y[3]) +
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
		 m64(x[9],y[6]));
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
c0d012f2:	9904      	ldr	r1, [sp, #16]
c0d012f4:	1808      	adds	r0, r1, r0
c0d012f6:	9004      	str	r0, [sp, #16]
c0d012f8:	4177      	adcs	r7, r6
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
c0d012fa:	6a20      	ldr	r0, [r4, #32]
c0d012fc:	4626      	mov	r6, r4
c0d012fe:	17c1      	asrs	r1, r0, #31
c0d01300:	6a2a      	ldr	r2, [r5, #32]
c0d01302:	17d3      	asrs	r3, r2, #31
c0d01304:	f003 fafe 	bl	c0d04904 <__aeabi_lmul>
c0d01308:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d0130a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0130c:	f003 fafa 	bl	c0d04904 <__aeabi_lmul>
c0d01310:	9a04      	ldr	r2, [sp, #16]
c0d01312:	1810      	adds	r0, r2, r0
c0d01314:	9004      	str	r0, [sp, #16]
c0d01316:	4179      	adcs	r1, r7
c0d01318:	9103      	str	r1, [sp, #12]
c0d0131a:	462c      	mov	r4, r5
c0d0131c:	6960      	ldr	r0, [r4, #20]
c0d0131e:	17c1      	asrs	r1, r0, #31
c0d01320:	6872      	ldr	r2, [r6, #4]
c0d01322:	17d3      	asrs	r3, r2, #31
c0d01324:	f003 faee 	bl	c0d04904 <__aeabi_lmul>
c0d01328:	4607      	mov	r7, r0
c0d0132a:	9102      	str	r1, [sp, #8]
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
c0d0132c:	68e0      	ldr	r0, [r4, #12]
c0d0132e:	17c1      	asrs	r1, r0, #31
c0d01330:	68f2      	ldr	r2, [r6, #12]
c0d01332:	17d3      	asrs	r3, r2, #31
c0d01334:	f003 fae6 	bl	c0d04904 <__aeabi_lmul>
c0d01338:	460d      	mov	r5, r1
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
		 m64(x[9],y[6]));
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
c0d0133a:	19c7      	adds	r7, r0, r7
c0d0133c:	9802      	ldr	r0, [sp, #8]
c0d0133e:	4145      	adcs	r5, r0
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
c0d01340:	6860      	ldr	r0, [r4, #4]
c0d01342:	17c1      	asrs	r1, r0, #31
c0d01344:	6972      	ldr	r2, [r6, #20]
c0d01346:	17d3      	asrs	r3, r2, #31
c0d01348:	f003 fadc 	bl	c0d04904 <__aeabi_lmul>
c0d0134c:	1838      	adds	r0, r7, r0
c0d0134e:	4169      	adcs	r1, r5
		m64(x[3],y[2]) + m64(x[4],y[1]) + m64(x[5],y[0]) + 19 *
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
		 m64(x[9],y[6]));
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
c0d01350:	0fc2      	lsrs	r2, r0, #31
c0d01352:	004f      	lsls	r7, r1, #1
c0d01354:	4317      	orrs	r7, r2
c0d01356:	0040      	lsls	r0, r0, #1
c0d01358:	9904      	ldr	r1, [sp, #16]
c0d0135a:	1808      	adds	r0, r1, r0
c0d0135c:	9004      	str	r0, [sp, #16]
c0d0135e:	9803      	ldr	r0, [sp, #12]
c0d01360:	4147      	adcs	r7, r0
c0d01362:	4626      	mov	r6, r4
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
		(m64(x[7],y[9]) + m64(x[9],y[7]));
c0d01364:	6a70      	ldr	r0, [r6, #36]	; 0x24
c0d01366:	17c1      	asrs	r1, r0, #31
c0d01368:	9c08      	ldr	r4, [sp, #32]
c0d0136a:	69e2      	ldr	r2, [r4, #28]
c0d0136c:	17d3      	asrs	r3, r2, #31
c0d0136e:	f003 fac9 	bl	c0d04904 <__aeabi_lmul>
c0d01372:	4605      	mov	r5, r0
c0d01374:	9103      	str	r1, [sp, #12]
c0d01376:	69f0      	ldr	r0, [r6, #28]
c0d01378:	17c1      	asrs	r1, r0, #31
c0d0137a:	6a62      	ldr	r2, [r4, #36]	; 0x24
c0d0137c:	17d3      	asrs	r3, r2, #31
c0d0137e:	f003 fac1 	bl	c0d04904 <__aeabi_lmul>
c0d01382:	1940      	adds	r0, r0, r5
c0d01384:	9a03      	ldr	r2, [sp, #12]
c0d01386:	4151      	adcs	r1, r2
		(m64(x[6],y[9]) + m64(x[7],y[8]) + m64(x[8],y[7]) +
		 m64(x[9],y[6]));
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
c0d01388:	9a06      	ldr	r2, [sp, #24]
c0d0138a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0138c:	f003 faba 	bl	c0d04904 <__aeabi_lmul>
c0d01390:	9a04      	ldr	r2, [sp, #16]
c0d01392:	1810      	adds	r0, r2, r0
c0d01394:	4179      	adcs	r1, r7
		(m64(x[7],y[9]) + m64(x[9],y[7]));
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[7]) + m64(x[1],y[6]) + m64(x[2],y[5]) +
c0d01396:	0e82      	lsrs	r2, r0, #26
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
		(m64(x[7],y[9]) + m64(x[9],y[7]));
	xy[6] = t & ((1 << 26) - 1);
c0d01398:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d0139a:	4018      	ands	r0, r3
c0d0139c:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d0139e:	6198      	str	r0, [r3, #24]
	t = (t >> 26) + m64(x[0],y[7]) + m64(x[1],y[6]) + m64(x[2],y[5]) +
c0d013a0:	018d      	lsls	r5, r1, #6
c0d013a2:	4315      	orrs	r5, r2
c0d013a4:	1688      	asrs	r0, r1, #26
c0d013a6:	9006      	str	r0, [sp, #24]
c0d013a8:	69f0      	ldr	r0, [r6, #28]
c0d013aa:	17c1      	asrs	r1, r0, #31
c0d013ac:	6822      	ldr	r2, [r4, #0]
c0d013ae:	4627      	mov	r7, r4
c0d013b0:	17d3      	asrs	r3, r2, #31
c0d013b2:	f003 faa7 	bl	c0d04904 <__aeabi_lmul>
c0d013b6:	460c      	mov	r4, r1
c0d013b8:	1828      	adds	r0, r5, r0
c0d013ba:	9004      	str	r0, [sp, #16]
c0d013bc:	9806      	ldr	r0, [sp, #24]
c0d013be:	4144      	adcs	r4, r0
c0d013c0:	69b0      	ldr	r0, [r6, #24]
c0d013c2:	17c1      	asrs	r1, r0, #31
c0d013c4:	687a      	ldr	r2, [r7, #4]
c0d013c6:	17d3      	asrs	r3, r2, #31
c0d013c8:	f003 fa9c 	bl	c0d04904 <__aeabi_lmul>
c0d013cc:	460d      	mov	r5, r1
c0d013ce:	9904      	ldr	r1, [sp, #16]
c0d013d0:	1808      	adds	r0, r1, r0
c0d013d2:	9006      	str	r0, [sp, #24]
c0d013d4:	4165      	adcs	r5, r4
c0d013d6:	6970      	ldr	r0, [r6, #20]
c0d013d8:	17c1      	asrs	r1, r0, #31
c0d013da:	68ba      	ldr	r2, [r7, #8]
c0d013dc:	17d3      	asrs	r3, r2, #31
c0d013de:	f003 fa91 	bl	c0d04904 <__aeabi_lmul>
c0d013e2:	460c      	mov	r4, r1
c0d013e4:	9906      	ldr	r1, [sp, #24]
c0d013e6:	1808      	adds	r0, r1, r0
c0d013e8:	9006      	str	r0, [sp, #24]
c0d013ea:	416c      	adcs	r4, r5
		m64(x[3],y[4]) + m64(x[4],y[3]) + m64(x[5],y[2]) +
c0d013ec:	6930      	ldr	r0, [r6, #16]
c0d013ee:	17c1      	asrs	r1, r0, #31
c0d013f0:	68fa      	ldr	r2, [r7, #12]
c0d013f2:	17d3      	asrs	r3, r2, #31
c0d013f4:	f003 fa86 	bl	c0d04904 <__aeabi_lmul>
c0d013f8:	460d      	mov	r5, r1
	t = (t >> 25) + m64(x[0],y[6]) + m64(x[2],y[4]) + m64(x[4],y[2]) +
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
		(m64(x[7],y[9]) + m64(x[9],y[7]));
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[7]) + m64(x[1],y[6]) + m64(x[2],y[5]) +
c0d013fa:	9906      	ldr	r1, [sp, #24]
c0d013fc:	1808      	adds	r0, r1, r0
c0d013fe:	9006      	str	r0, [sp, #24]
c0d01400:	4165      	adcs	r5, r4
		m64(x[3],y[4]) + m64(x[4],y[3]) + m64(x[5],y[2]) +
c0d01402:	68f0      	ldr	r0, [r6, #12]
c0d01404:	17c1      	asrs	r1, r0, #31
c0d01406:	693a      	ldr	r2, [r7, #16]
c0d01408:	17d3      	asrs	r3, r2, #31
c0d0140a:	f003 fa7b 	bl	c0d04904 <__aeabi_lmul>
c0d0140e:	460c      	mov	r4, r1
c0d01410:	9906      	ldr	r1, [sp, #24]
c0d01412:	1808      	adds	r0, r1, r0
c0d01414:	9006      	str	r0, [sp, #24]
c0d01416:	416c      	adcs	r4, r5
c0d01418:	68b0      	ldr	r0, [r6, #8]
c0d0141a:	17c1      	asrs	r1, r0, #31
c0d0141c:	697a      	ldr	r2, [r7, #20]
c0d0141e:	17d3      	asrs	r3, r2, #31
c0d01420:	f003 fa70 	bl	c0d04904 <__aeabi_lmul>
c0d01424:	460d      	mov	r5, r1
c0d01426:	9906      	ldr	r1, [sp, #24]
c0d01428:	1808      	adds	r0, r1, r0
c0d0142a:	9006      	str	r0, [sp, #24]
c0d0142c:	4165      	adcs	r5, r4
		m64(x[6],y[1]) + m64(x[7],y[0]) + 19 * (m64(x[8],y[9]) +
c0d0142e:	6870      	ldr	r0, [r6, #4]
c0d01430:	17c1      	asrs	r1, r0, #31
c0d01432:	463c      	mov	r4, r7
c0d01434:	69a2      	ldr	r2, [r4, #24]
c0d01436:	17d3      	asrs	r3, r2, #31
c0d01438:	f003 fa64 	bl	c0d04904 <__aeabi_lmul>
c0d0143c:	460f      	mov	r7, r1
		m64(x[6],y[0]) + 19 * m64(x[8],y[8]) + 2 * (m64(x[1],y[5]) +
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
		(m64(x[7],y[9]) + m64(x[9],y[7]));
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[7]) + m64(x[1],y[6]) + m64(x[2],y[5]) +
		m64(x[3],y[4]) + m64(x[4],y[3]) + m64(x[5],y[2]) +
c0d0143e:	9906      	ldr	r1, [sp, #24]
c0d01440:	1808      	adds	r0, r1, r0
c0d01442:	9006      	str	r0, [sp, #24]
c0d01444:	416f      	adcs	r7, r5
c0d01446:	4635      	mov	r5, r6
		m64(x[6],y[1]) + m64(x[7],y[0]) + 19 * (m64(x[8],y[9]) +
c0d01448:	6828      	ldr	r0, [r5, #0]
c0d0144a:	17c1      	asrs	r1, r0, #31
c0d0144c:	69e2      	ldr	r2, [r4, #28]
c0d0144e:	4626      	mov	r6, r4
c0d01450:	17d3      	asrs	r3, r2, #31
c0d01452:	f003 fa57 	bl	c0d04904 <__aeabi_lmul>
c0d01456:	460c      	mov	r4, r1
c0d01458:	9906      	ldr	r1, [sp, #24]
c0d0145a:	1808      	adds	r0, r1, r0
c0d0145c:	9006      	str	r0, [sp, #24]
c0d0145e:	417c      	adcs	r4, r7
c0d01460:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01462:	17c1      	asrs	r1, r0, #31
c0d01464:	6a32      	ldr	r2, [r6, #32]
c0d01466:	17d3      	asrs	r3, r2, #31
c0d01468:	f003 fa4c 	bl	c0d04904 <__aeabi_lmul>
c0d0146c:	4607      	mov	r7, r0
c0d0146e:	9104      	str	r1, [sp, #16]
				m64(x[9],y[8]));
c0d01470:	6a28      	ldr	r0, [r5, #32]
c0d01472:	17c1      	asrs	r1, r0, #31
c0d01474:	6a72      	ldr	r2, [r6, #36]	; 0x24
c0d01476:	17d3      	asrs	r3, r2, #31
c0d01478:	f003 fa44 	bl	c0d04904 <__aeabi_lmul>
				m64(x[3],y[3]) + m64(x[5],y[1])) + 38 *
		(m64(x[7],y[9]) + m64(x[9],y[7]));
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[0],y[7]) + m64(x[1],y[6]) + m64(x[2],y[5]) +
		m64(x[3],y[4]) + m64(x[4],y[3]) + m64(x[5],y[2]) +
		m64(x[6],y[1]) + m64(x[7],y[0]) + 19 * (m64(x[8],y[9]) +
c0d0147c:	19c0      	adds	r0, r0, r7
c0d0147e:	9a04      	ldr	r2, [sp, #16]
c0d01480:	4151      	adcs	r1, r2
c0d01482:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01484:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01486:	f003 fa3d 	bl	c0d04904 <__aeabi_lmul>
c0d0148a:	9a06      	ldr	r2, [sp, #24]
c0d0148c:	1810      	adds	r0, r2, r0
c0d0148e:	4161      	adcs	r1, r4
c0d01490:	9a07      	ldr	r2, [sp, #28]
				m64(x[9],y[8]));
	xy[7] = t & ((1 << 25) - 1);
c0d01492:	4002      	ands	r2, r0
c0d01494:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d01496:	61e2      	str	r2, [r4, #28]
	t = (t >> 25) + xy[8];
c0d01498:	01ca      	lsls	r2, r1, #7
c0d0149a:	0e40      	lsrs	r0, r0, #25
c0d0149c:	4310      	orrs	r0, r2
c0d0149e:	1649      	asrs	r1, r1, #25
c0d014a0:	6a22      	ldr	r2, [r4, #32]
c0d014a2:	17d3      	asrs	r3, r2, #31
c0d014a4:	1880      	adds	r0, r0, r2
c0d014a6:	414b      	adcs	r3, r1
c0d014a8:	9909      	ldr	r1, [sp, #36]	; 0x24
	xy[8] = t & ((1 << 26) - 1);
c0d014aa:	4001      	ands	r1, r0
c0d014ac:	6221      	str	r1, [r4, #32]
	xy[9] += (int32_t)(t >> 26);
c0d014ae:	0199      	lsls	r1, r3, #6
c0d014b0:	0e80      	lsrs	r0, r0, #26
c0d014b2:	4308      	orrs	r0, r1
c0d014b4:	6a61      	ldr	r1, [r4, #36]	; 0x24
c0d014b6:	1840      	adds	r0, r0, r1
c0d014b8:	6260      	str	r0, [r4, #36]	; 0x24
c0d014ba:	b00d      	add	sp, #52	; 0x34
c0d014bc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d014be <add25519>:
}

/* Add/subtract two numbers.  The inputs must be in reduced form, and the 
 * output isn't, so to do another addition or subtraction on the output, 
 * first multiply it by one to reduce it. */
static void add25519(i25519 xy, const i25519 x, const i25519 y) {
c0d014be:	b510      	push	{r4, lr}
	xy[0] = x[0] + y[0];	xy[1] = x[1] + y[1];
c0d014c0:	680b      	ldr	r3, [r1, #0]
c0d014c2:	6814      	ldr	r4, [r2, #0]
c0d014c4:	18e3      	adds	r3, r4, r3
c0d014c6:	6003      	str	r3, [r0, #0]
c0d014c8:	684b      	ldr	r3, [r1, #4]
c0d014ca:	6854      	ldr	r4, [r2, #4]
c0d014cc:	18e3      	adds	r3, r4, r3
c0d014ce:	6043      	str	r3, [r0, #4]
	xy[2] = x[2] + y[2];	xy[3] = x[3] + y[3];
c0d014d0:	688b      	ldr	r3, [r1, #8]
c0d014d2:	6894      	ldr	r4, [r2, #8]
c0d014d4:	18e3      	adds	r3, r4, r3
c0d014d6:	6083      	str	r3, [r0, #8]
c0d014d8:	68cb      	ldr	r3, [r1, #12]
c0d014da:	68d4      	ldr	r4, [r2, #12]
c0d014dc:	18e3      	adds	r3, r4, r3
c0d014de:	60c3      	str	r3, [r0, #12]
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
c0d014e0:	690b      	ldr	r3, [r1, #16]
c0d014e2:	6914      	ldr	r4, [r2, #16]
c0d014e4:	18e3      	adds	r3, r4, r3
c0d014e6:	6103      	str	r3, [r0, #16]
c0d014e8:	694b      	ldr	r3, [r1, #20]
c0d014ea:	6954      	ldr	r4, [r2, #20]
c0d014ec:	18e3      	adds	r3, r4, r3
c0d014ee:	6143      	str	r3, [r0, #20]
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
c0d014f0:	698b      	ldr	r3, [r1, #24]
c0d014f2:	6994      	ldr	r4, [r2, #24]
c0d014f4:	18e3      	adds	r3, r4, r3
c0d014f6:	6183      	str	r3, [r0, #24]
c0d014f8:	69cb      	ldr	r3, [r1, #28]
c0d014fa:	69d4      	ldr	r4, [r2, #28]
c0d014fc:	18e3      	adds	r3, r4, r3
c0d014fe:	61c3      	str	r3, [r0, #28]
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
c0d01500:	6a0b      	ldr	r3, [r1, #32]
c0d01502:	6a14      	ldr	r4, [r2, #32]
c0d01504:	18e3      	adds	r3, r4, r3
c0d01506:	6203      	str	r3, [r0, #32]
c0d01508:	6a49      	ldr	r1, [r1, #36]	; 0x24
c0d0150a:	6a52      	ldr	r2, [r2, #36]	; 0x24
c0d0150c:	1851      	adds	r1, r2, r1
c0d0150e:	6241      	str	r1, [r0, #36]	; 0x24
}
c0d01510:	bd10      	pop	{r4, pc}
	...

c0d01514 <sqr25519>:
	check_reduced("mul output", xy);
	return xy;
}

/* Square a number.  Optimization of  mul25519(x2, x, x)  */
static i25519ptr sqr25519(i25519 x2, const i25519 x) {
c0d01514:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01516:	b08b      	sub	sp, #44	; 0x2c
c0d01518:	460d      	mov	r5, r1
c0d0151a:	900a      	str	r0, [sp, #40]	; 0x28
	register int64_t t;
	check_nonred("sqr input", x);
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
c0d0151c:	69e8      	ldr	r0, [r5, #28]
c0d0151e:	17c1      	asrs	r1, r0, #31
c0d01520:	686a      	ldr	r2, [r5, #4]
c0d01522:	17d3      	asrs	r3, r2, #31
c0d01524:	f003 f9ee 	bl	c0d04904 <__aeabi_lmul>
c0d01528:	4604      	mov	r4, r0
c0d0152a:	460e      	mov	r6, r1
c0d0152c:	6968      	ldr	r0, [r5, #20]
c0d0152e:	17c1      	asrs	r1, r0, #31
c0d01530:	68ea      	ldr	r2, [r5, #12]
c0d01532:	17d3      	asrs	r3, r2, #31
c0d01534:	f003 f9e6 	bl	c0d04904 <__aeabi_lmul>
c0d01538:	1900      	adds	r0, r0, r4
c0d0153a:	9007      	str	r0, [sp, #28]
c0d0153c:	4171      	adcs	r1, r6
c0d0153e:	0f80      	lsrs	r0, r0, #30
c0d01540:	0089      	lsls	r1, r1, #2
c0d01542:	4301      	orrs	r1, r0
c0d01544:	9106      	str	r1, [sp, #24]

/* Square a number.  Optimization of  mul25519(x2, x, x)  */
static i25519ptr sqr25519(i25519 x2, const i25519 x) {
	register int64_t t;
	check_nonred("sqr input", x);
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
c0d01546:	6a28      	ldr	r0, [r5, #32]
c0d01548:	17c1      	asrs	r1, r0, #31
c0d0154a:	682a      	ldr	r2, [r5, #0]
c0d0154c:	17d3      	asrs	r3, r2, #31
c0d0154e:	f003 f9d9 	bl	c0d04904 <__aeabi_lmul>
c0d01552:	4604      	mov	r4, r0
c0d01554:	460e      	mov	r6, r1
c0d01556:	69a8      	ldr	r0, [r5, #24]
c0d01558:	17c1      	asrs	r1, r0, #31
c0d0155a:	68aa      	ldr	r2, [r5, #8]
c0d0155c:	17d3      	asrs	r3, r2, #31
c0d0155e:	f003 f9d1 	bl	c0d04904 <__aeabi_lmul>
c0d01562:	1900      	adds	r0, r0, r4
c0d01564:	4171      	adcs	r1, r6
c0d01566:	0fc2      	lsrs	r2, r0, #31
c0d01568:	004e      	lsls	r6, r1, #1
c0d0156a:	4316      	orrs	r6, r2
c0d0156c:	0047      	lsls	r7, r0, #1
c0d0156e:	6928      	ldr	r0, [r5, #16]
c0d01570:	17c1      	asrs	r1, r0, #31
c0d01572:	4602      	mov	r2, r0
c0d01574:	460b      	mov	r3, r1
c0d01576:	f003 f9c5 	bl	c0d04904 <__aeabi_lmul>
c0d0157a:	460c      	mov	r4, r1
c0d0157c:	183f      	adds	r7, r7, r0
c0d0157e:	4174      	adcs	r4, r6
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
c0d01580:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01582:	17c1      	asrs	r1, r0, #31
c0d01584:	4602      	mov	r2, r0
c0d01586:	460b      	mov	r3, r1
c0d01588:	f003 f9bc 	bl	c0d04904 <__aeabi_lmul>
c0d0158c:	2226      	movs	r2, #38	; 0x26
c0d0158e:	9208      	str	r2, [sp, #32]
c0d01590:	2300      	movs	r3, #0

/* Square a number.  Optimization of  mul25519(x2, x, x)  */
static i25519ptr sqr25519(i25519 x2, const i25519 x) {
	register int64_t t;
	check_nonred("sqr input", x);
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
c0d01592:	9309      	str	r3, [sp, #36]	; 0x24
c0d01594:	f003 f9b6 	bl	c0d04904 <__aeabi_lmul>
c0d01598:	1838      	adds	r0, r7, r0
c0d0159a:	4161      	adcs	r1, r4
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
c0d0159c:	9a07      	ldr	r2, [sp, #28]
c0d0159e:	0092      	lsls	r2, r2, #2
c0d015a0:	1880      	adds	r0, r0, r2
c0d015a2:	9a06      	ldr	r2, [sp, #24]
c0d015a4:	4151      	adcs	r1, r2
	x2[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[7]) + m64(x[1],x[6]) + m64(x[2],x[5]) +
			m64(x[3],x[4])) + 38 * m64(x[8],x[9]);
	x2[7] = t & ((1 << 25) - 1);
	t = (t >> 25) + x2[8];
	x2[8] = t & ((1 << 26) - 1);
c0d015a6:	4bfc      	ldr	r3, [pc, #1008]	; (c0d01998 <sqr25519+0x484>)
	register int64_t t;
	check_nonred("sqr input", x);
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
c0d015a8:	9307      	str	r3, [sp, #28]
c0d015aa:	0e82      	lsrs	r2, r0, #26
static i25519ptr sqr25519(i25519 x2, const i25519 x) {
	register int64_t t;
	check_nonred("sqr input", x);
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
c0d015ac:	4018      	ands	r0, r3
c0d015ae:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d015b0:	6218      	str	r0, [r3, #32]
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
c0d015b2:	0188      	lsls	r0, r1, #6
c0d015b4:	4310      	orrs	r0, r2
c0d015b6:	9005      	str	r0, [sp, #20]
c0d015b8:	1688      	asrs	r0, r1, #26
c0d015ba:	9006      	str	r0, [sp, #24]
c0d015bc:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d015be:	17c1      	asrs	r1, r0, #31
c0d015c0:	682a      	ldr	r2, [r5, #0]
c0d015c2:	17d3      	asrs	r3, r2, #31
c0d015c4:	f003 f99e 	bl	c0d04904 <__aeabi_lmul>
c0d015c8:	4606      	mov	r6, r0
c0d015ca:	460f      	mov	r7, r1
c0d015cc:	6a28      	ldr	r0, [r5, #32]
c0d015ce:	17c1      	asrs	r1, r0, #31
c0d015d0:	686a      	ldr	r2, [r5, #4]
c0d015d2:	17d3      	asrs	r3, r2, #31
c0d015d4:	f003 f996 	bl	c0d04904 <__aeabi_lmul>
c0d015d8:	460c      	mov	r4, r1
c0d015da:	1980      	adds	r0, r0, r6
c0d015dc:	9004      	str	r0, [sp, #16]
c0d015de:	417c      	adcs	r4, r7
c0d015e0:	69e8      	ldr	r0, [r5, #28]
c0d015e2:	17c1      	asrs	r1, r0, #31
c0d015e4:	68aa      	ldr	r2, [r5, #8]
c0d015e6:	17d3      	asrs	r3, r2, #31
c0d015e8:	f003 f98c 	bl	c0d04904 <__aeabi_lmul>
c0d015ec:	460e      	mov	r6, r1
c0d015ee:	9904      	ldr	r1, [sp, #16]
c0d015f0:	180f      	adds	r7, r1, r0
c0d015f2:	4166      	adcs	r6, r4
			m64(x[3],x[6]) + m64(x[4],x[5]));
c0d015f4:	69a8      	ldr	r0, [r5, #24]
c0d015f6:	17c1      	asrs	r1, r0, #31
c0d015f8:	68ea      	ldr	r2, [r5, #12]
c0d015fa:	17d3      	asrs	r3, r2, #31
c0d015fc:	f003 f982 	bl	c0d04904 <__aeabi_lmul>
c0d01600:	460c      	mov	r4, r1
	register int64_t t;
	check_nonred("sqr input", x);
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
c0d01602:	183f      	adds	r7, r7, r0
c0d01604:	4174      	adcs	r4, r6
			m64(x[3],x[6]) + m64(x[4],x[5]));
c0d01606:	692a      	ldr	r2, [r5, #16]
c0d01608:	6968      	ldr	r0, [r5, #20]
c0d0160a:	17c1      	asrs	r1, r0, #31
c0d0160c:	17d3      	asrs	r3, r2, #31
c0d0160e:	f003 f979 	bl	c0d04904 <__aeabi_lmul>
c0d01612:	1838      	adds	r0, r7, r0
c0d01614:	4161      	adcs	r1, r4
	register int64_t t;
	check_nonred("sqr input", x);
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
c0d01616:	0fc2      	lsrs	r2, r0, #31
c0d01618:	0049      	lsls	r1, r1, #1
c0d0161a:	4311      	orrs	r1, r2
c0d0161c:	0040      	lsls	r0, r0, #1
c0d0161e:	9a05      	ldr	r2, [sp, #20]
c0d01620:	1880      	adds	r0, r0, r2
c0d01622:	9a06      	ldr	r2, [sp, #24]
c0d01624:	4151      	adcs	r1, r2
			m64(x[2],x[4]) + m64(x[3],x[3])) + 4 * m64(x[1],x[5]) +
			76 * m64(x[7],x[9]);
	x2[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[7]) + m64(x[1],x[6]) + m64(x[2],x[5]) +
			m64(x[3],x[4])) + 38 * m64(x[8],x[9]);
	x2[7] = t & ((1 << 25) - 1);
c0d01626:	4bdd      	ldr	r3, [pc, #884]	; (c0d0199c <sqr25519+0x488>)
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
			m64(x[3],x[6]) + m64(x[4],x[5]));
	x2[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
c0d01628:	9306      	str	r3, [sp, #24]
c0d0162a:	0e42      	lsrs	r2, r0, #25
	t = m64(x[4],x[4]) + 2 * (m64(x[0],x[8]) + m64(x[2],x[6])) + 38 *
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
			m64(x[3],x[6]) + m64(x[4],x[5]));
	x2[9] = t & ((1 << 25) - 1);
c0d0162c:	4018      	ands	r0, r3
c0d0162e:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01630:	6258      	str	r0, [r3, #36]	; 0x24
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
c0d01632:	01c8      	lsls	r0, r1, #7
c0d01634:	4310      	orrs	r0, r2
c0d01636:	1649      	asrs	r1, r1, #25
c0d01638:	2213      	movs	r2, #19
c0d0163a:	9204      	str	r2, [sp, #16]
c0d0163c:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d0163e:	f003 f961 	bl	c0d04904 <__aeabi_lmul>
c0d01642:	4604      	mov	r4, r0
c0d01644:	460f      	mov	r7, r1
c0d01646:	6828      	ldr	r0, [r5, #0]
c0d01648:	17c1      	asrs	r1, r0, #31
c0d0164a:	4602      	mov	r2, r0
c0d0164c:	460b      	mov	r3, r1
c0d0164e:	f003 f959 	bl	c0d04904 <__aeabi_lmul>
c0d01652:	1820      	adds	r0, r4, r0
c0d01654:	9005      	str	r0, [sp, #20]
c0d01656:	4179      	adcs	r1, r7
c0d01658:	9103      	str	r1, [sp, #12]
c0d0165a:	6a28      	ldr	r0, [r5, #32]
c0d0165c:	17c1      	asrs	r1, r0, #31
c0d0165e:	68aa      	ldr	r2, [r5, #8]
c0d01660:	17d3      	asrs	r3, r2, #31
c0d01662:	f003 f94f 	bl	c0d04904 <__aeabi_lmul>
c0d01666:	4607      	mov	r7, r0
c0d01668:	460e      	mov	r6, r1
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
c0d0166a:	69a8      	ldr	r0, [r5, #24]
c0d0166c:	17c1      	asrs	r1, r0, #31
c0d0166e:	692a      	ldr	r2, [r5, #16]
c0d01670:	17d3      	asrs	r3, r2, #31
c0d01672:	f003 f947 	bl	c0d04904 <__aeabi_lmul>
c0d01676:	460c      	mov	r4, r1
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
			m64(x[3],x[6]) + m64(x[4],x[5]));
	x2[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
c0d01678:	19c7      	adds	r7, r0, r7
c0d0167a:	4174      	adcs	r4, r6
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
c0d0167c:	6968      	ldr	r0, [r5, #20]
c0d0167e:	17c1      	asrs	r1, r0, #31
c0d01680:	4602      	mov	r2, r0
c0d01682:	460b      	mov	r3, r1
c0d01684:	f003 f93e 	bl	c0d04904 <__aeabi_lmul>
c0d01688:	1838      	adds	r0, r7, r0
c0d0168a:	4161      	adcs	r1, r4
		m64(x[9],x[9]) + 4 * (m64(x[1],x[7]) + m64(x[3],x[5]));
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
			m64(x[3],x[6]) + m64(x[4],x[5]));
	x2[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
c0d0168c:	9a08      	ldr	r2, [sp, #32]
c0d0168e:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d01690:	4623      	mov	r3, r4
c0d01692:	f003 f937 	bl	c0d04904 <__aeabi_lmul>
c0d01696:	460e      	mov	r6, r1
c0d01698:	9905      	ldr	r1, [sp, #20]
c0d0169a:	1808      	adds	r0, r1, r0
c0d0169c:	9002      	str	r0, [sp, #8]
c0d0169e:	9803      	ldr	r0, [sp, #12]
c0d016a0:	4146      	adcs	r6, r0
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
c0d016a2:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d016a4:	17c1      	asrs	r1, r0, #31
c0d016a6:	686a      	ldr	r2, [r5, #4]
c0d016a8:	17d3      	asrs	r3, r2, #31
c0d016aa:	f003 f92b 	bl	c0d04904 <__aeabi_lmul>
c0d016ae:	4607      	mov	r7, r0
c0d016b0:	9105      	str	r1, [sp, #20]
			+ m64(x[3],x[7]));
c0d016b2:	69e8      	ldr	r0, [r5, #28]
c0d016b4:	17c1      	asrs	r1, r0, #31
c0d016b6:	68ea      	ldr	r2, [r5, #12]
c0d016b8:	17d3      	asrs	r3, r2, #31
c0d016ba:	f003 f923 	bl	c0d04904 <__aeabi_lmul>
c0d016be:	19c0      	adds	r0, r0, r7
c0d016c0:	9a05      	ldr	r2, [sp, #20]
c0d016c2:	4151      	adcs	r1, r2
c0d016c4:	224c      	movs	r2, #76	; 0x4c
	x2[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[9]) + m64(x[1],x[8]) + m64(x[2],x[7]) +
			m64(x[3],x[6]) + m64(x[4],x[5]));
	x2[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
c0d016c6:	9205      	str	r2, [sp, #20]
c0d016c8:	4623      	mov	r3, r4
c0d016ca:	f003 f91b 	bl	c0d04904 <__aeabi_lmul>
c0d016ce:	9a02      	ldr	r2, [sp, #8]
c0d016d0:	1810      	adds	r0, r2, r0
c0d016d2:	4171      	adcs	r1, r6
			+ m64(x[3],x[7]));
	x2[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * m64(x[0],x[1]) + 38 * (m64(x[2],x[9]) +
c0d016d4:	0e82      	lsrs	r2, r0, #26
			m64(x[3],x[6]) + m64(x[4],x[5]));
	x2[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
			+ m64(x[3],x[7]));
	x2[0] = t & ((1 << 26) - 1);
c0d016d6:	9b07      	ldr	r3, [sp, #28]
c0d016d8:	4018      	ands	r0, r3
c0d016da:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d016dc:	6018      	str	r0, [r3, #0]
	t = (t >> 26) + 2 * m64(x[0],x[1]) + 38 * (m64(x[2],x[9]) +
c0d016de:	018c      	lsls	r4, r1, #6
c0d016e0:	4314      	orrs	r4, r2
c0d016e2:	168e      	asrs	r6, r1, #26
c0d016e4:	cd05      	ldmia	r5!, {r0, r2}
c0d016e6:	17c1      	asrs	r1, r0, #31
c0d016e8:	17d3      	asrs	r3, r2, #31
c0d016ea:	3d08      	subs	r5, #8
c0d016ec:	f003 f90a 	bl	c0d04904 <__aeabi_lmul>
c0d016f0:	0fc2      	lsrs	r2, r0, #31
c0d016f2:	004f      	lsls	r7, r1, #1
c0d016f4:	4317      	orrs	r7, r2
c0d016f6:	0040      	lsls	r0, r0, #1
c0d016f8:	1820      	adds	r0, r4, r0
c0d016fa:	9003      	str	r0, [sp, #12]
c0d016fc:	4177      	adcs	r7, r6
c0d016fe:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01700:	17c1      	asrs	r1, r0, #31
c0d01702:	68aa      	ldr	r2, [r5, #8]
c0d01704:	17d3      	asrs	r3, r2, #31
c0d01706:	f003 f8fd 	bl	c0d04904 <__aeabi_lmul>
c0d0170a:	4606      	mov	r6, r0
c0d0170c:	9102      	str	r1, [sp, #8]
			m64(x[3],x[8]) + m64(x[4],x[7]) + m64(x[5],x[6]));
c0d0170e:	6a28      	ldr	r0, [r5, #32]
c0d01710:	17c1      	asrs	r1, r0, #31
c0d01712:	68ea      	ldr	r2, [r5, #12]
c0d01714:	17d3      	asrs	r3, r2, #31
c0d01716:	f003 f8f5 	bl	c0d04904 <__aeabi_lmul>
c0d0171a:	460c      	mov	r4, r1
	x2[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
			+ m64(x[3],x[7]));
	x2[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * m64(x[0],x[1]) + 38 * (m64(x[2],x[9]) +
c0d0171c:	1980      	adds	r0, r0, r6
c0d0171e:	9001      	str	r0, [sp, #4]
c0d01720:	9802      	ldr	r0, [sp, #8]
c0d01722:	4144      	adcs	r4, r0
			m64(x[3],x[8]) + m64(x[4],x[7]) + m64(x[5],x[6]));
c0d01724:	69e8      	ldr	r0, [r5, #28]
c0d01726:	17c1      	asrs	r1, r0, #31
c0d01728:	692a      	ldr	r2, [r5, #16]
c0d0172a:	17d3      	asrs	r3, r2, #31
c0d0172c:	f003 f8ea 	bl	c0d04904 <__aeabi_lmul>
c0d01730:	460e      	mov	r6, r1
c0d01732:	9901      	ldr	r1, [sp, #4]
c0d01734:	1808      	adds	r0, r1, r0
c0d01736:	9002      	str	r0, [sp, #8]
c0d01738:	4166      	adcs	r6, r4
c0d0173a:	696a      	ldr	r2, [r5, #20]
c0d0173c:	69a8      	ldr	r0, [r5, #24]
c0d0173e:	17c1      	asrs	r1, r0, #31
c0d01740:	17d3      	asrs	r3, r2, #31
c0d01742:	f003 f8df 	bl	c0d04904 <__aeabi_lmul>
c0d01746:	9a02      	ldr	r2, [sp, #8]
c0d01748:	1810      	adds	r0, r2, r0
c0d0174a:	4171      	adcs	r1, r6
	x2[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],x[0]) + 38 * (m64(x[2],x[8]) +
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
			+ m64(x[3],x[7]));
	x2[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * m64(x[0],x[1]) + 38 * (m64(x[2],x[9]) +
c0d0174c:	9a08      	ldr	r2, [sp, #32]
c0d0174e:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d01750:	4623      	mov	r3, r4
c0d01752:	f003 f8d7 	bl	c0d04904 <__aeabi_lmul>
c0d01756:	9a03      	ldr	r2, [sp, #12]
c0d01758:	1810      	adds	r0, r2, r0
c0d0175a:	4179      	adcs	r1, r7
			m64(x[3],x[8]) + m64(x[4],x[7]) + m64(x[5],x[6]));
	x2[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[6],x[6]) + 2 * (m64(x[0],x[2]) +
c0d0175c:	0e42      	lsrs	r2, r0, #25
			m64(x[4],x[6]) + m64(x[5],x[5])) + 76 * (m64(x[1],x[9])
			+ m64(x[3],x[7]));
	x2[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * m64(x[0],x[1]) + 38 * (m64(x[2],x[9]) +
			m64(x[3],x[8]) + m64(x[4],x[7]) + m64(x[5],x[6]));
	x2[1] = t & ((1 << 25) - 1);
c0d0175e:	9b06      	ldr	r3, [sp, #24]
c0d01760:	4018      	ands	r0, r3
c0d01762:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01764:	6058      	str	r0, [r3, #4]
	t = (t >> 25) + 19 * m64(x[6],x[6]) + 2 * (m64(x[0],x[2]) +
c0d01766:	01ce      	lsls	r6, r1, #7
c0d01768:	4316      	orrs	r6, r2
c0d0176a:	164f      	asrs	r7, r1, #25
c0d0176c:	69a8      	ldr	r0, [r5, #24]
c0d0176e:	17c1      	asrs	r1, r0, #31
c0d01770:	4602      	mov	r2, r0
c0d01772:	460b      	mov	r3, r1
c0d01774:	f003 f8c6 	bl	c0d04904 <__aeabi_lmul>
c0d01778:	9a04      	ldr	r2, [sp, #16]
c0d0177a:	4623      	mov	r3, r4
c0d0177c:	f003 f8c2 	bl	c0d04904 <__aeabi_lmul>
c0d01780:	460c      	mov	r4, r1
c0d01782:	1830      	adds	r0, r6, r0
c0d01784:	9003      	str	r0, [sp, #12]
c0d01786:	417c      	adcs	r4, r7
c0d01788:	68a8      	ldr	r0, [r5, #8]
c0d0178a:	17c1      	asrs	r1, r0, #31
c0d0178c:	682a      	ldr	r2, [r5, #0]
c0d0178e:	17d3      	asrs	r3, r2, #31
c0d01790:	f003 f8b8 	bl	c0d04904 <__aeabi_lmul>
c0d01794:	4606      	mov	r6, r0
c0d01796:	460f      	mov	r7, r1
			m64(x[1],x[1])) + 38 * m64(x[4],x[8]) + 76 *
c0d01798:	6868      	ldr	r0, [r5, #4]
c0d0179a:	17c1      	asrs	r1, r0, #31
c0d0179c:	4602      	mov	r2, r0
c0d0179e:	460b      	mov	r3, r1
c0d017a0:	f003 f8b0 	bl	c0d04904 <__aeabi_lmul>
			+ m64(x[3],x[7]));
	x2[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * m64(x[0],x[1]) + 38 * (m64(x[2],x[9]) +
			m64(x[3],x[8]) + m64(x[4],x[7]) + m64(x[5],x[6]));
	x2[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[6],x[6]) + 2 * (m64(x[0],x[2]) +
c0d017a4:	1980      	adds	r0, r0, r6
c0d017a6:	4179      	adcs	r1, r7
c0d017a8:	0fc2      	lsrs	r2, r0, #31
c0d017aa:	004e      	lsls	r6, r1, #1
c0d017ac:	4316      	orrs	r6, r2
c0d017ae:	0040      	lsls	r0, r0, #1
c0d017b0:	9903      	ldr	r1, [sp, #12]
c0d017b2:	1808      	adds	r0, r1, r0
c0d017b4:	9003      	str	r0, [sp, #12]
c0d017b6:	4166      	adcs	r6, r4
			m64(x[1],x[1])) + 38 * m64(x[4],x[8]) + 76 *
c0d017b8:	6928      	ldr	r0, [r5, #16]
c0d017ba:	17c1      	asrs	r1, r0, #31
c0d017bc:	6a2a      	ldr	r2, [r5, #32]
c0d017be:	17d3      	asrs	r3, r2, #31
c0d017c0:	f003 f8a0 	bl	c0d04904 <__aeabi_lmul>
c0d017c4:	9a08      	ldr	r2, [sp, #32]
c0d017c6:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d017c8:	4623      	mov	r3, r4
c0d017ca:	f003 f89b 	bl	c0d04904 <__aeabi_lmul>
c0d017ce:	460f      	mov	r7, r1
c0d017d0:	9903      	ldr	r1, [sp, #12]
c0d017d2:	1808      	adds	r0, r1, r0
c0d017d4:	9003      	str	r0, [sp, #12]
c0d017d6:	4177      	adcs	r7, r6
			(m64(x[3],x[9]) + m64(x[5],x[7]));
c0d017d8:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d017da:	17c1      	asrs	r1, r0, #31
c0d017dc:	68ea      	ldr	r2, [r5, #12]
c0d017de:	17d3      	asrs	r3, r2, #31
c0d017e0:	f003 f890 	bl	c0d04904 <__aeabi_lmul>
c0d017e4:	4606      	mov	r6, r0
c0d017e6:	9102      	str	r1, [sp, #8]
c0d017e8:	69e8      	ldr	r0, [r5, #28]
c0d017ea:	17c1      	asrs	r1, r0, #31
c0d017ec:	696a      	ldr	r2, [r5, #20]
c0d017ee:	17d3      	asrs	r3, r2, #31
c0d017f0:	f003 f888 	bl	c0d04904 <__aeabi_lmul>
c0d017f4:	1980      	adds	r0, r0, r6
c0d017f6:	9a02      	ldr	r2, [sp, #8]
c0d017f8:	4151      	adcs	r1, r2
	x2[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * m64(x[0],x[1]) + 38 * (m64(x[2],x[9]) +
			m64(x[3],x[8]) + m64(x[4],x[7]) + m64(x[5],x[6]));
	x2[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[6],x[6]) + 2 * (m64(x[0],x[2]) +
			m64(x[1],x[1])) + 38 * m64(x[4],x[8]) + 76 *
c0d017fa:	9a05      	ldr	r2, [sp, #20]
c0d017fc:	4623      	mov	r3, r4
c0d017fe:	f003 f881 	bl	c0d04904 <__aeabi_lmul>
c0d01802:	9a03      	ldr	r2, [sp, #12]
c0d01804:	1810      	adds	r0, r2, r0
c0d01806:	4179      	adcs	r1, r7
			(m64(x[3],x[9]) + m64(x[5],x[7]));
	x2[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[3]) + m64(x[1],x[2])) + 38 *
c0d01808:	0e82      	lsrs	r2, r0, #26
			m64(x[3],x[8]) + m64(x[4],x[7]) + m64(x[5],x[6]));
	x2[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[6],x[6]) + 2 * (m64(x[0],x[2]) +
			m64(x[1],x[1])) + 38 * m64(x[4],x[8]) + 76 *
			(m64(x[3],x[9]) + m64(x[5],x[7]));
	x2[2] = t & ((1 << 26) - 1);
c0d0180a:	9b07      	ldr	r3, [sp, #28]
c0d0180c:	4018      	ands	r0, r3
c0d0180e:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01810:	6098      	str	r0, [r3, #8]
	t = (t >> 26) + 2 * (m64(x[0],x[3]) + m64(x[1],x[2])) + 38 *
c0d01812:	018f      	lsls	r7, r1, #6
c0d01814:	4317      	orrs	r7, r2
c0d01816:	1688      	asrs	r0, r1, #26
c0d01818:	9002      	str	r0, [sp, #8]
c0d0181a:	68e8      	ldr	r0, [r5, #12]
c0d0181c:	17c1      	asrs	r1, r0, #31
c0d0181e:	682a      	ldr	r2, [r5, #0]
c0d01820:	17d3      	asrs	r3, r2, #31
c0d01822:	f003 f86f 	bl	c0d04904 <__aeabi_lmul>
c0d01826:	4604      	mov	r4, r0
c0d01828:	460e      	mov	r6, r1
c0d0182a:	686a      	ldr	r2, [r5, #4]
c0d0182c:	68a8      	ldr	r0, [r5, #8]
c0d0182e:	17c1      	asrs	r1, r0, #31
c0d01830:	17d3      	asrs	r3, r2, #31
c0d01832:	f003 f867 	bl	c0d04904 <__aeabi_lmul>
c0d01836:	1900      	adds	r0, r0, r4
c0d01838:	4171      	adcs	r1, r6
c0d0183a:	0fc2      	lsrs	r2, r0, #31
c0d0183c:	004e      	lsls	r6, r1, #1
c0d0183e:	4316      	orrs	r6, r2
c0d01840:	0040      	lsls	r0, r0, #1
c0d01842:	19c0      	adds	r0, r0, r7
c0d01844:	9003      	str	r0, [sp, #12]
c0d01846:	9802      	ldr	r0, [sp, #8]
c0d01848:	4146      	adcs	r6, r0
		(m64(x[4],x[9]) + m64(x[5],x[8]) + m64(x[6],x[7]));
c0d0184a:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0184c:	17c1      	asrs	r1, r0, #31
c0d0184e:	692a      	ldr	r2, [r5, #16]
c0d01850:	17d3      	asrs	r3, r2, #31
c0d01852:	f003 f857 	bl	c0d04904 <__aeabi_lmul>
c0d01856:	4607      	mov	r7, r0
c0d01858:	9102      	str	r1, [sp, #8]
c0d0185a:	6a28      	ldr	r0, [r5, #32]
c0d0185c:	17c1      	asrs	r1, r0, #31
c0d0185e:	696a      	ldr	r2, [r5, #20]
c0d01860:	17d3      	asrs	r3, r2, #31
c0d01862:	f003 f84f 	bl	c0d04904 <__aeabi_lmul>
c0d01866:	460c      	mov	r4, r1
c0d01868:	19c7      	adds	r7, r0, r7
c0d0186a:	9802      	ldr	r0, [sp, #8]
c0d0186c:	4144      	adcs	r4, r0
c0d0186e:	69aa      	ldr	r2, [r5, #24]
c0d01870:	69e8      	ldr	r0, [r5, #28]
c0d01872:	17c1      	asrs	r1, r0, #31
c0d01874:	17d3      	asrs	r3, r2, #31
c0d01876:	f003 f845 	bl	c0d04904 <__aeabi_lmul>
c0d0187a:	1838      	adds	r0, r7, r0
c0d0187c:	4161      	adcs	r1, r4
	x2[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[6],x[6]) + 2 * (m64(x[0],x[2]) +
			m64(x[1],x[1])) + 38 * m64(x[4],x[8]) + 76 *
			(m64(x[3],x[9]) + m64(x[5],x[7]));
	x2[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[3]) + m64(x[1],x[2])) + 38 *
c0d0187e:	9a08      	ldr	r2, [sp, #32]
c0d01880:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01882:	f003 f83f 	bl	c0d04904 <__aeabi_lmul>
c0d01886:	9a03      	ldr	r2, [sp, #12]
c0d01888:	1810      	adds	r0, r2, r0
c0d0188a:	4171      	adcs	r1, r6
		(m64(x[4],x[9]) + m64(x[5],x[8]) + m64(x[6],x[7]));
	x2[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[2],x[2]) + 2 * m64(x[0],x[4]) + 38 *
c0d0188c:	0e42      	lsrs	r2, r0, #25
			m64(x[1],x[1])) + 38 * m64(x[4],x[8]) + 76 *
			(m64(x[3],x[9]) + m64(x[5],x[7]));
	x2[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[3]) + m64(x[1],x[2])) + 38 *
		(m64(x[4],x[9]) + m64(x[5],x[8]) + m64(x[6],x[7]));
	x2[3] = t & ((1 << 25) - 1);
c0d0188e:	9b06      	ldr	r3, [sp, #24]
c0d01890:	4018      	ands	r0, r3
c0d01892:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01894:	60d8      	str	r0, [r3, #12]
	t = (t >> 25) + m64(x[2],x[2]) + 2 * m64(x[0],x[4]) + 38 *
c0d01896:	01ce      	lsls	r6, r1, #7
c0d01898:	4316      	orrs	r6, r2
c0d0189a:	164f      	asrs	r7, r1, #25
c0d0189c:	68a8      	ldr	r0, [r5, #8]
c0d0189e:	17c1      	asrs	r1, r0, #31
c0d018a0:	4602      	mov	r2, r0
c0d018a2:	460b      	mov	r3, r1
c0d018a4:	f003 f82e 	bl	c0d04904 <__aeabi_lmul>
c0d018a8:	460c      	mov	r4, r1
c0d018aa:	1836      	adds	r6, r6, r0
c0d018ac:	417c      	adcs	r4, r7
c0d018ae:	6828      	ldr	r0, [r5, #0]
c0d018b0:	17c1      	asrs	r1, r0, #31
c0d018b2:	692a      	ldr	r2, [r5, #16]
c0d018b4:	17d3      	asrs	r3, r2, #31
c0d018b6:	f003 f825 	bl	c0d04904 <__aeabi_lmul>
c0d018ba:	0fc2      	lsrs	r2, r0, #31
c0d018bc:	004f      	lsls	r7, r1, #1
c0d018be:	4317      	orrs	r7, r2
c0d018c0:	0040      	lsls	r0, r0, #1
c0d018c2:	1830      	adds	r0, r6, r0
c0d018c4:	9003      	str	r0, [sp, #12]
c0d018c6:	4167      	adcs	r7, r4
		(m64(x[6],x[8]) + m64(x[7],x[7])) + 4 * m64(x[1],x[3]) + 76 *
c0d018c8:	6a28      	ldr	r0, [r5, #32]
c0d018ca:	17c1      	asrs	r1, r0, #31
c0d018cc:	69aa      	ldr	r2, [r5, #24]
c0d018ce:	17d3      	asrs	r3, r2, #31
c0d018d0:	f003 f818 	bl	c0d04904 <__aeabi_lmul>
c0d018d4:	4604      	mov	r4, r0
c0d018d6:	460e      	mov	r6, r1
c0d018d8:	69e8      	ldr	r0, [r5, #28]
c0d018da:	17c1      	asrs	r1, r0, #31
c0d018dc:	4602      	mov	r2, r0
c0d018de:	460b      	mov	r3, r1
c0d018e0:	f003 f810 	bl	c0d04904 <__aeabi_lmul>
c0d018e4:	1900      	adds	r0, r0, r4
c0d018e6:	4171      	adcs	r1, r6
			(m64(x[3],x[9]) + m64(x[5],x[7]));
	x2[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[3]) + m64(x[1],x[2])) + 38 *
		(m64(x[4],x[9]) + m64(x[5],x[8]) + m64(x[6],x[7]));
	x2[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[2],x[2]) + 2 * m64(x[0],x[4]) + 38 *
c0d018e8:	9a08      	ldr	r2, [sp, #32]
c0d018ea:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d018ec:	f003 f80a 	bl	c0d04904 <__aeabi_lmul>
c0d018f0:	460c      	mov	r4, r1
c0d018f2:	9903      	ldr	r1, [sp, #12]
c0d018f4:	1808      	adds	r0, r1, r0
c0d018f6:	9003      	str	r0, [sp, #12]
c0d018f8:	417c      	adcs	r4, r7
		(m64(x[6],x[8]) + m64(x[7],x[7])) + 4 * m64(x[1],x[3]) + 76 *
c0d018fa:	6868      	ldr	r0, [r5, #4]
c0d018fc:	17c1      	asrs	r1, r0, #31
c0d018fe:	68ea      	ldr	r2, [r5, #12]
c0d01900:	17d3      	asrs	r3, r2, #31
c0d01902:	f002 ffff 	bl	c0d04904 <__aeabi_lmul>
c0d01906:	0f82      	lsrs	r2, r0, #30
c0d01908:	008e      	lsls	r6, r1, #2
c0d0190a:	4316      	orrs	r6, r2
c0d0190c:	0080      	lsls	r0, r0, #2
c0d0190e:	9903      	ldr	r1, [sp, #12]
c0d01910:	180f      	adds	r7, r1, r0
c0d01912:	4166      	adcs	r6, r4
		m64(x[5],x[9]);
c0d01914:	6968      	ldr	r0, [r5, #20]
c0d01916:	17c1      	asrs	r1, r0, #31
c0d01918:	6a6a      	ldr	r2, [r5, #36]	; 0x24
c0d0191a:	17d3      	asrs	r3, r2, #31
c0d0191c:	f002 fff2 	bl	c0d04904 <__aeabi_lmul>
	x2[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[3]) + m64(x[1],x[2])) + 38 *
		(m64(x[4],x[9]) + m64(x[5],x[8]) + m64(x[6],x[7]));
	x2[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[2],x[2]) + 2 * m64(x[0],x[4]) + 38 *
		(m64(x[6],x[8]) + m64(x[7],x[7])) + 4 * m64(x[1],x[3]) + 76 *
c0d01920:	9a05      	ldr	r2, [sp, #20]
c0d01922:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01924:	f002 ffee 	bl	c0d04904 <__aeabi_lmul>
c0d01928:	1838      	adds	r0, r7, r0
c0d0192a:	4171      	adcs	r1, r6
		m64(x[5],x[9]);
	x2[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[5]) + m64(x[1],x[4]) + m64(x[2],x[3]))
c0d0192c:	0e82      	lsrs	r2, r0, #26
		(m64(x[4],x[9]) + m64(x[5],x[8]) + m64(x[6],x[7]));
	x2[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[2],x[2]) + 2 * m64(x[0],x[4]) + 38 *
		(m64(x[6],x[8]) + m64(x[7],x[7])) + 4 * m64(x[1],x[3]) + 76 *
		m64(x[5],x[9]);
	x2[4] = t & ((1 << 26) - 1);
c0d0192e:	9b07      	ldr	r3, [sp, #28]
c0d01930:	4018      	ands	r0, r3
c0d01932:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01934:	6118      	str	r0, [r3, #16]
	t = (t >> 26) + 2 * (m64(x[0],x[5]) + m64(x[1],x[4]) + m64(x[2],x[3]))
c0d01936:	018e      	lsls	r6, r1, #6
c0d01938:	4316      	orrs	r6, r2
c0d0193a:	1688      	asrs	r0, r1, #26
c0d0193c:	9003      	str	r0, [sp, #12]
c0d0193e:	6968      	ldr	r0, [r5, #20]
c0d01940:	17c1      	asrs	r1, r0, #31
c0d01942:	682a      	ldr	r2, [r5, #0]
c0d01944:	17d3      	asrs	r3, r2, #31
c0d01946:	f002 ffdd 	bl	c0d04904 <__aeabi_lmul>
c0d0194a:	4607      	mov	r7, r0
c0d0194c:	9102      	str	r1, [sp, #8]
c0d0194e:	6928      	ldr	r0, [r5, #16]
c0d01950:	17c1      	asrs	r1, r0, #31
c0d01952:	686a      	ldr	r2, [r5, #4]
c0d01954:	17d3      	asrs	r3, r2, #31
c0d01956:	f002 ffd5 	bl	c0d04904 <__aeabi_lmul>
c0d0195a:	460c      	mov	r4, r1
c0d0195c:	19c7      	adds	r7, r0, r7
c0d0195e:	9802      	ldr	r0, [sp, #8]
c0d01960:	4144      	adcs	r4, r0
c0d01962:	68aa      	ldr	r2, [r5, #8]
c0d01964:	68e8      	ldr	r0, [r5, #12]
c0d01966:	17c1      	asrs	r1, r0, #31
c0d01968:	17d3      	asrs	r3, r2, #31
c0d0196a:	f002 ffcb 	bl	c0d04904 <__aeabi_lmul>
c0d0196e:	1838      	adds	r0, r7, r0
c0d01970:	4161      	adcs	r1, r4
c0d01972:	0fc2      	lsrs	r2, r0, #31
c0d01974:	004f      	lsls	r7, r1, #1
c0d01976:	4317      	orrs	r7, r2
c0d01978:	0040      	lsls	r0, r0, #1
c0d0197a:	1980      	adds	r0, r0, r6
c0d0197c:	9002      	str	r0, [sp, #8]
c0d0197e:	9803      	ldr	r0, [sp, #12]
c0d01980:	4147      	adcs	r7, r0
		+ 38 * (m64(x[6],x[9]) + m64(x[7],x[8]));
c0d01982:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01984:	17c1      	asrs	r1, r0, #31
c0d01986:	69aa      	ldr	r2, [r5, #24]
c0d01988:	17d3      	asrs	r3, r2, #31
c0d0198a:	f002 ffbb 	bl	c0d04904 <__aeabi_lmul>
c0d0198e:	4604      	mov	r4, r0
c0d01990:	460e      	mov	r6, r1
c0d01992:	69ea      	ldr	r2, [r5, #28]
c0d01994:	6a28      	ldr	r0, [r5, #32]
c0d01996:	e003      	b.n	c0d019a0 <sqr25519+0x48c>
c0d01998:	03ffffff 	.word	0x03ffffff
c0d0199c:	01ffffff 	.word	0x01ffffff
c0d019a0:	17c1      	asrs	r1, r0, #31
c0d019a2:	17d3      	asrs	r3, r2, #31
c0d019a4:	f002 ffae 	bl	c0d04904 <__aeabi_lmul>
c0d019a8:	1900      	adds	r0, r0, r4
c0d019aa:	4171      	adcs	r1, r6
c0d019ac:	9a08      	ldr	r2, [sp, #32]
c0d019ae:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d019b0:	4633      	mov	r3, r6
c0d019b2:	f002 ffa7 	bl	c0d04904 <__aeabi_lmul>
c0d019b6:	9a02      	ldr	r2, [sp, #8]
c0d019b8:	1810      	adds	r0, r2, r0
c0d019ba:	4179      	adcs	r1, r7
	x2[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[8],x[8]) + 2 * (m64(x[0],x[6]) +
c0d019bc:	0e42      	lsrs	r2, r0, #25
		(m64(x[6],x[8]) + m64(x[7],x[7])) + 4 * m64(x[1],x[3]) + 76 *
		m64(x[5],x[9]);
	x2[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[5]) + m64(x[1],x[4]) + m64(x[2],x[3]))
		+ 38 * (m64(x[6],x[9]) + m64(x[7],x[8]));
	x2[5] = t & ((1 << 25) - 1);
c0d019be:	9b06      	ldr	r3, [sp, #24]
c0d019c0:	4018      	ands	r0, r3
c0d019c2:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d019c4:	6158      	str	r0, [r3, #20]
	t = (t >> 25) + 19 * m64(x[8],x[8]) + 2 * (m64(x[0],x[6]) +
c0d019c6:	01cc      	lsls	r4, r1, #7
c0d019c8:	4314      	orrs	r4, r2
c0d019ca:	164f      	asrs	r7, r1, #25
c0d019cc:	6a28      	ldr	r0, [r5, #32]
c0d019ce:	17c1      	asrs	r1, r0, #31
c0d019d0:	4602      	mov	r2, r0
c0d019d2:	460b      	mov	r3, r1
c0d019d4:	f002 ff96 	bl	c0d04904 <__aeabi_lmul>
c0d019d8:	9a04      	ldr	r2, [sp, #16]
c0d019da:	4633      	mov	r3, r6
c0d019dc:	f002 ff92 	bl	c0d04904 <__aeabi_lmul>
c0d019e0:	460e      	mov	r6, r1
c0d019e2:	1820      	adds	r0, r4, r0
c0d019e4:	9004      	str	r0, [sp, #16]
c0d019e6:	417e      	adcs	r6, r7
c0d019e8:	69a8      	ldr	r0, [r5, #24]
c0d019ea:	17c1      	asrs	r1, r0, #31
c0d019ec:	682a      	ldr	r2, [r5, #0]
c0d019ee:	17d3      	asrs	r3, r2, #31
c0d019f0:	f002 ff88 	bl	c0d04904 <__aeabi_lmul>
c0d019f4:	4607      	mov	r7, r0
c0d019f6:	9103      	str	r1, [sp, #12]
			m64(x[2],x[4]) + m64(x[3],x[3])) + 4 * m64(x[1],x[5]) +
c0d019f8:	6928      	ldr	r0, [r5, #16]
c0d019fa:	17c1      	asrs	r1, r0, #31
c0d019fc:	68aa      	ldr	r2, [r5, #8]
c0d019fe:	17d3      	asrs	r3, r2, #31
c0d01a00:	f002 ff80 	bl	c0d04904 <__aeabi_lmul>
c0d01a04:	460c      	mov	r4, r1
		m64(x[5],x[9]);
	x2[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[5]) + m64(x[1],x[4]) + m64(x[2],x[3]))
		+ 38 * (m64(x[6],x[9]) + m64(x[7],x[8]));
	x2[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[8],x[8]) + 2 * (m64(x[0],x[6]) +
c0d01a06:	19c7      	adds	r7, r0, r7
c0d01a08:	9803      	ldr	r0, [sp, #12]
c0d01a0a:	4144      	adcs	r4, r0
			m64(x[2],x[4]) + m64(x[3],x[3])) + 4 * m64(x[1],x[5]) +
c0d01a0c:	68e8      	ldr	r0, [r5, #12]
c0d01a0e:	17c1      	asrs	r1, r0, #31
c0d01a10:	4602      	mov	r2, r0
c0d01a12:	460b      	mov	r3, r1
c0d01a14:	f002 ff76 	bl	c0d04904 <__aeabi_lmul>
c0d01a18:	1838      	adds	r0, r7, r0
c0d01a1a:	4161      	adcs	r1, r4
		m64(x[5],x[9]);
	x2[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[5]) + m64(x[1],x[4]) + m64(x[2],x[3]))
		+ 38 * (m64(x[6],x[9]) + m64(x[7],x[8]));
	x2[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[8],x[8]) + 2 * (m64(x[0],x[6]) +
c0d01a1c:	0fc2      	lsrs	r2, r0, #31
c0d01a1e:	004f      	lsls	r7, r1, #1
c0d01a20:	4317      	orrs	r7, r2
c0d01a22:	0040      	lsls	r0, r0, #1
c0d01a24:	9904      	ldr	r1, [sp, #16]
c0d01a26:	1808      	adds	r0, r1, r0
c0d01a28:	9004      	str	r0, [sp, #16]
c0d01a2a:	4177      	adcs	r7, r6
			m64(x[2],x[4]) + m64(x[3],x[3])) + 4 * m64(x[1],x[5]) +
c0d01a2c:	6868      	ldr	r0, [r5, #4]
c0d01a2e:	17c1      	asrs	r1, r0, #31
c0d01a30:	696a      	ldr	r2, [r5, #20]
c0d01a32:	17d3      	asrs	r3, r2, #31
c0d01a34:	f002 ff66 	bl	c0d04904 <__aeabi_lmul>
c0d01a38:	0f82      	lsrs	r2, r0, #30
c0d01a3a:	008c      	lsls	r4, r1, #2
c0d01a3c:	4314      	orrs	r4, r2
c0d01a3e:	0080      	lsls	r0, r0, #2
c0d01a40:	9904      	ldr	r1, [sp, #16]
c0d01a42:	180e      	adds	r6, r1, r0
c0d01a44:	417c      	adcs	r4, r7
			76 * m64(x[7],x[9]);
c0d01a46:	69e8      	ldr	r0, [r5, #28]
c0d01a48:	17c1      	asrs	r1, r0, #31
c0d01a4a:	6a6a      	ldr	r2, [r5, #36]	; 0x24
c0d01a4c:	17d3      	asrs	r3, r2, #31
c0d01a4e:	f002 ff59 	bl	c0d04904 <__aeabi_lmul>
c0d01a52:	9a05      	ldr	r2, [sp, #20]
c0d01a54:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01a56:	f002 ff55 	bl	c0d04904 <__aeabi_lmul>
	x2[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[5]) + m64(x[1],x[4]) + m64(x[2],x[3]))
		+ 38 * (m64(x[6],x[9]) + m64(x[7],x[8]));
	x2[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[8],x[8]) + 2 * (m64(x[0],x[6]) +
			m64(x[2],x[4]) + m64(x[3],x[3])) + 4 * m64(x[1],x[5]) +
c0d01a5a:	1830      	adds	r0, r6, r0
c0d01a5c:	4161      	adcs	r1, r4
			76 * m64(x[7],x[9]);
	x2[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[7]) + m64(x[1],x[6]) + m64(x[2],x[5]) +
c0d01a5e:	0e82      	lsrs	r2, r0, #26
		+ 38 * (m64(x[6],x[9]) + m64(x[7],x[8]));
	x2[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[8],x[8]) + 2 * (m64(x[0],x[6]) +
			m64(x[2],x[4]) + m64(x[3],x[3])) + 4 * m64(x[1],x[5]) +
			76 * m64(x[7],x[9]);
	x2[6] = t & ((1 << 26) - 1);
c0d01a60:	9b07      	ldr	r3, [sp, #28]
c0d01a62:	4018      	ands	r0, r3
c0d01a64:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01a66:	6198      	str	r0, [r3, #24]
	t = (t >> 26) + 2 * (m64(x[0],x[7]) + m64(x[1],x[6]) + m64(x[2],x[5]) +
c0d01a68:	0188      	lsls	r0, r1, #6
c0d01a6a:	4310      	orrs	r0, r2
c0d01a6c:	9004      	str	r0, [sp, #16]
c0d01a6e:	1688      	asrs	r0, r1, #26
c0d01a70:	9005      	str	r0, [sp, #20]
c0d01a72:	69e8      	ldr	r0, [r5, #28]
c0d01a74:	17c1      	asrs	r1, r0, #31
c0d01a76:	682a      	ldr	r2, [r5, #0]
c0d01a78:	17d3      	asrs	r3, r2, #31
c0d01a7a:	f002 ff43 	bl	c0d04904 <__aeabi_lmul>
c0d01a7e:	4606      	mov	r6, r0
c0d01a80:	460f      	mov	r7, r1
c0d01a82:	69a8      	ldr	r0, [r5, #24]
c0d01a84:	17c1      	asrs	r1, r0, #31
c0d01a86:	686a      	ldr	r2, [r5, #4]
c0d01a88:	17d3      	asrs	r3, r2, #31
c0d01a8a:	f002 ff3b 	bl	c0d04904 <__aeabi_lmul>
c0d01a8e:	460c      	mov	r4, r1
c0d01a90:	1980      	adds	r0, r0, r6
c0d01a92:	9003      	str	r0, [sp, #12]
c0d01a94:	417c      	adcs	r4, r7
c0d01a96:	6968      	ldr	r0, [r5, #20]
c0d01a98:	17c1      	asrs	r1, r0, #31
c0d01a9a:	68aa      	ldr	r2, [r5, #8]
c0d01a9c:	17d3      	asrs	r3, r2, #31
c0d01a9e:	f002 ff31 	bl	c0d04904 <__aeabi_lmul>
c0d01aa2:	460e      	mov	r6, r1
c0d01aa4:	9903      	ldr	r1, [sp, #12]
c0d01aa6:	180f      	adds	r7, r1, r0
c0d01aa8:	4166      	adcs	r6, r4
			m64(x[3],x[4])) + 38 * m64(x[8],x[9]);
c0d01aaa:	68ea      	ldr	r2, [r5, #12]
c0d01aac:	6928      	ldr	r0, [r5, #16]
c0d01aae:	17c1      	asrs	r1, r0, #31
c0d01ab0:	17d3      	asrs	r3, r2, #31
c0d01ab2:	f002 ff27 	bl	c0d04904 <__aeabi_lmul>
	x2[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + 19 * m64(x[8],x[8]) + 2 * (m64(x[0],x[6]) +
			m64(x[2],x[4]) + m64(x[3],x[3])) + 4 * m64(x[1],x[5]) +
			76 * m64(x[7],x[9]);
	x2[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + 2 * (m64(x[0],x[7]) + m64(x[1],x[6]) + m64(x[2],x[5]) +
c0d01ab6:	1838      	adds	r0, r7, r0
c0d01ab8:	4171      	adcs	r1, r6
c0d01aba:	0fc2      	lsrs	r2, r0, #31
c0d01abc:	004c      	lsls	r4, r1, #1
c0d01abe:	4314      	orrs	r4, r2
c0d01ac0:	0040      	lsls	r0, r0, #1
c0d01ac2:	9904      	ldr	r1, [sp, #16]
c0d01ac4:	1846      	adds	r6, r0, r1
c0d01ac6:	9805      	ldr	r0, [sp, #20]
c0d01ac8:	4144      	adcs	r4, r0
			m64(x[3],x[4])) + 38 * m64(x[8],x[9]);
c0d01aca:	6a28      	ldr	r0, [r5, #32]
c0d01acc:	6a6a      	ldr	r2, [r5, #36]	; 0x24
c0d01ace:	17c1      	asrs	r1, r0, #31
c0d01ad0:	17d3      	asrs	r3, r2, #31
c0d01ad2:	f002 ff17 	bl	c0d04904 <__aeabi_lmul>
c0d01ad6:	9a08      	ldr	r2, [sp, #32]
c0d01ad8:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01ada:	f002 ff13 	bl	c0d04904 <__aeabi_lmul>
c0d01ade:	1830      	adds	r0, r6, r0
c0d01ae0:	4161      	adcs	r1, r4
c0d01ae2:	9a06      	ldr	r2, [sp, #24]
	x2[7] = t & ((1 << 25) - 1);
c0d01ae4:	4002      	ands	r2, r0
c0d01ae6:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d01ae8:	61e2      	str	r2, [r4, #28]
	t = (t >> 25) + x2[8];
c0d01aea:	01ca      	lsls	r2, r1, #7
c0d01aec:	0e40      	lsrs	r0, r0, #25
c0d01aee:	4310      	orrs	r0, r2
c0d01af0:	1649      	asrs	r1, r1, #25
c0d01af2:	6a22      	ldr	r2, [r4, #32]
c0d01af4:	17d3      	asrs	r3, r2, #31
c0d01af6:	1880      	adds	r0, r0, r2
c0d01af8:	414b      	adcs	r3, r1
c0d01afa:	9907      	ldr	r1, [sp, #28]
	x2[8] = t & ((1 << 26) - 1);
c0d01afc:	4001      	ands	r1, r0
c0d01afe:	6221      	str	r1, [r4, #32]
	x2[9] += (t >> 26);
c0d01b00:	0199      	lsls	r1, r3, #6
c0d01b02:	0e80      	lsrs	r0, r0, #26
c0d01b04:	4308      	orrs	r0, r1
c0d01b06:	6a61      	ldr	r1, [r4, #36]	; 0x24
c0d01b08:	1840      	adds	r0, r0, r1
c0d01b0a:	6260      	str	r0, [r4, #36]	; 0x24
c0d01b0c:	b00b      	add	sp, #44	; 0x2c
c0d01b0e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01b10 <sub25519>:
	xy[2] = x[2] + y[2];	xy[3] = x[3] + y[3];
	xy[4] = x[4] + y[4];	xy[5] = x[5] + y[5];
	xy[6] = x[6] + y[6];	xy[7] = x[7] + y[7];
	xy[8] = x[8] + y[8];	xy[9] = x[9] + y[9];
}
static void sub25519(i25519 xy, const i25519 x, const i25519 y) {
c0d01b10:	b510      	push	{r4, lr}
	xy[0] = x[0] - y[0];	xy[1] = x[1] - y[1];
c0d01b12:	6813      	ldr	r3, [r2, #0]
c0d01b14:	680c      	ldr	r4, [r1, #0]
c0d01b16:	1ae3      	subs	r3, r4, r3
c0d01b18:	6003      	str	r3, [r0, #0]
c0d01b1a:	6853      	ldr	r3, [r2, #4]
c0d01b1c:	684c      	ldr	r4, [r1, #4]
c0d01b1e:	1ae3      	subs	r3, r4, r3
c0d01b20:	6043      	str	r3, [r0, #4]
	xy[2] = x[2] - y[2];	xy[3] = x[3] - y[3];
c0d01b22:	6893      	ldr	r3, [r2, #8]
c0d01b24:	688c      	ldr	r4, [r1, #8]
c0d01b26:	1ae3      	subs	r3, r4, r3
c0d01b28:	6083      	str	r3, [r0, #8]
c0d01b2a:	68d3      	ldr	r3, [r2, #12]
c0d01b2c:	68cc      	ldr	r4, [r1, #12]
c0d01b2e:	1ae3      	subs	r3, r4, r3
c0d01b30:	60c3      	str	r3, [r0, #12]
	xy[4] = x[4] - y[4];	xy[5] = x[5] - y[5];
c0d01b32:	6913      	ldr	r3, [r2, #16]
c0d01b34:	690c      	ldr	r4, [r1, #16]
c0d01b36:	1ae3      	subs	r3, r4, r3
c0d01b38:	6103      	str	r3, [r0, #16]
c0d01b3a:	6953      	ldr	r3, [r2, #20]
c0d01b3c:	694c      	ldr	r4, [r1, #20]
c0d01b3e:	1ae3      	subs	r3, r4, r3
c0d01b40:	6143      	str	r3, [r0, #20]
	xy[6] = x[6] - y[6];	xy[7] = x[7] - y[7];
c0d01b42:	6993      	ldr	r3, [r2, #24]
c0d01b44:	698c      	ldr	r4, [r1, #24]
c0d01b46:	1ae3      	subs	r3, r4, r3
c0d01b48:	6183      	str	r3, [r0, #24]
c0d01b4a:	69d3      	ldr	r3, [r2, #28]
c0d01b4c:	69cc      	ldr	r4, [r1, #28]
c0d01b4e:	1ae3      	subs	r3, r4, r3
c0d01b50:	61c3      	str	r3, [r0, #28]
	xy[8] = x[8] - y[8];	xy[9] = x[9] - y[9];
c0d01b52:	6a13      	ldr	r3, [r2, #32]
c0d01b54:	6a0c      	ldr	r4, [r1, #32]
c0d01b56:	1ae3      	subs	r3, r4, r3
c0d01b58:	6203      	str	r3, [r0, #32]
c0d01b5a:	6a52      	ldr	r2, [r2, #36]	; 0x24
c0d01b5c:	6a49      	ldr	r1, [r1, #36]	; 0x24
c0d01b5e:	1a89      	subs	r1, r1, r2
c0d01b60:	6241      	str	r1, [r0, #36]	; 0x24
}
c0d01b62:	bd10      	pop	{r4, pc}

c0d01b64 <divmod>:
/* divide r (size n) by d (size t), returning quotient q and remainder r
 * quotient is size n-t+1, remainder is size t
 * requires t > 0 && d[t-1] != 0
 * requires that r[-1] and d[-1] are valid memory locations
 * q may overlap with r+t */
static void divmod(dstptr q, dstptr r, unsigned n, srcptr d, unsigned t) {
c0d01b64:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b66:	b08d      	sub	sp, #52	; 0x34
c0d01b68:	461d      	mov	r5, r3
c0d01b6a:	4616      	mov	r6, r2
c0d01b6c:	460c      	mov	r4, r1
c0d01b6e:	9004      	str	r0, [sp, #16]
c0d01b70:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d01b72:	18a8      	adds	r0, r5, r2
	int rn = 0;
	int dt = d[t-1] << 8 | (d[t-2] & -(t > 1));
c0d01b74:	2101      	movs	r1, #1
c0d01b76:	43c9      	mvns	r1, r1
c0d01b78:	2300      	movs	r3, #0
c0d01b7a:	920a      	str	r2, [sp, #40]	; 0x28
c0d01b7c:	2a01      	cmp	r2, #1
c0d01b7e:	9101      	str	r1, [sp, #4]
c0d01b80:	d802      	bhi.n	c0d01b88 <divmod+0x24>
c0d01b82:	461a      	mov	r2, r3
c0d01b84:	4618      	mov	r0, r3
c0d01b86:	e001      	b.n	c0d01b8c <divmod+0x28>
c0d01b88:	461a      	mov	r2, r3
c0d01b8a:	5c40      	ldrb	r0, [r0, r1]
c0d01b8c:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01b8e:	1e59      	subs	r1, r3, #1
c0d01b90:	9100      	str	r1, [sp, #0]
c0d01b92:	5c69      	ldrb	r1, [r5, r1]
c0d01b94:	0209      	lsls	r1, r1, #8
c0d01b96:	4301      	orrs	r1, r0
c0d01b98:	9105      	str	r1, [sp, #20]

	while (n-- >= t) {
c0d01b9a:	429e      	cmp	r6, r3
c0d01b9c:	d362      	bcc.n	c0d01c64 <divmod+0x100>
c0d01b9e:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01ba0:	1a70      	subs	r0, r6, r1
c0d01ba2:	1827      	adds	r7, r4, r0
c0d01ba4:	2000      	movs	r0, #0
c0d01ba6:	4602      	mov	r2, r0
c0d01ba8:	43c0      	mvns	r0, r0
c0d01baa:	9002      	str	r0, [sp, #8]
c0d01bac:	4248      	negs	r0, r1
c0d01bae:	900b      	str	r0, [sp, #44]	; 0x2c
c0d01bb0:	9403      	str	r4, [sp, #12]
		int z = (rn << 16 | r[n] << 8 | (r[n-1] & -(n > 0))) / dt;
c0d01bb2:	19a0      	adds	r0, r4, r6
 * q may overlap with r+t */
static void divmod(dstptr q, dstptr r, unsigned n, srcptr d, unsigned t) {
	int rn = 0;
	int dt = d[t-1] << 8 | (d[t-2] & -(t > 1));

	while (n-- >= t) {
c0d01bb4:	1e76      	subs	r6, r6, #1
c0d01bb6:	d101      	bne.n	c0d01bbc <divmod+0x58>
		int z = (rn << 16 | r[n] << 8 | (r[n-1] & -(n > 0))) / dt;
c0d01bb8:	4631      	mov	r1, r6
c0d01bba:	e001      	b.n	c0d01bc0 <divmod+0x5c>
c0d01bbc:	9901      	ldr	r1, [sp, #4]
c0d01bbe:	5c41      	ldrb	r1, [r0, r1]
c0d01bc0:	4613      	mov	r3, r2
c0d01bc2:	930c      	str	r3, [sp, #48]	; 0x30
c0d01bc4:	5da0      	ldrb	r0, [r4, r6]
c0d01bc6:	0202      	lsls	r2, r0, #8
c0d01bc8:	0418      	lsls	r0, r3, #16
c0d01bca:	4310      	orrs	r0, r2
c0d01bcc:	4308      	orrs	r0, r1
c0d01bce:	9905      	ldr	r1, [sp, #20]
c0d01bd0:	f002 fe0c 	bl	c0d047ec <__aeabi_uidiv>
c0d01bd4:	19a3      	adds	r3, r4, r6
c0d01bd6:	990a      	ldr	r1, [sp, #40]	; 0x28
		rn += mula_small(r,r, n-t+1, d, t, -z);
c0d01bd8:	1a72      	subs	r2, r6, r1
c0d01bda:	1c52      	adds	r2, r2, #1
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d01bdc:	2900      	cmp	r1, #0
c0d01bde:	9609      	str	r6, [sp, #36]	; 0x24
c0d01be0:	9308      	str	r3, [sp, #32]
c0d01be2:	d030      	beq.n	c0d01c46 <divmod+0xe2>
c0d01be4:	9206      	str	r2, [sp, #24]
c0d01be6:	2300      	movs	r3, #0
c0d01be8:	9707      	str	r7, [sp, #28]
c0d01bea:	463c      	mov	r4, r7
c0d01bec:	461a      	mov	r2, r3
c0d01bee:	9e0a      	ldr	r6, [sp, #40]	; 0x28
c0d01bf0:	9f02      	ldr	r7, [sp, #8]
		p[i+m] = v += q[i+m] + z * x[i];
c0d01bf2:	7821      	ldrb	r1, [r4, #0]
c0d01bf4:	1889      	adds	r1, r1, r2
c0d01bf6:	463a      	mov	r2, r7
c0d01bf8:	435a      	muls	r2, r3
c0d01bfa:	5caa      	ldrb	r2, [r5, r2]
	int rn = 0;
	int dt = d[t-1] << 8 | (d[t-2] & -(t > 1));

	while (n-- >= t) {
		int z = (rn << 16 | r[n] << 8 | (r[n-1] & -(n > 0))) / dt;
		rn += mula_small(r,r, n-t+1, d, t, -z);
c0d01bfc:	4342      	muls	r2, r0
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d01bfe:	1a89      	subs	r1, r1, r2
c0d01c00:	7021      	strb	r1, [r4, #0]
		v >>= 8;
c0d01c02:	120a      	asrs	r2, r1, #8
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d01c04:	1e5b      	subs	r3, r3, #1
c0d01c06:	18f1      	adds	r1, r6, r3
c0d01c08:	1c64      	adds	r4, r4, #1
c0d01c0a:	2900      	cmp	r1, #0
c0d01c0c:	d1f1      	bne.n	c0d01bf2 <divmod+0x8e>
	int rn = 0;
	int dt = d[t-1] << 8 | (d[t-2] & -(t > 1));

	while (n-- >= t) {
		int z = (rn << 16 | r[n] << 8 | (r[n-1] & -(n > 0))) / dt;
		rn += mula_small(r,r, n-t+1, d, t, -z);
c0d01c0e:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d01c10:	1851      	adds	r1, r2, r1
c0d01c12:	910c      	str	r1, [sp, #48]	; 0x30
		q[n-t+1] = z + rn; /* rn is 0 or -1 (underflow) */
c0d01c14:	1808      	adds	r0, r1, r0
c0d01c16:	9904      	ldr	r1, [sp, #16]
c0d01c18:	9a06      	ldr	r2, [sp, #24]
c0d01c1a:	5488      	strb	r0, [r1, r2]
c0d01c1c:	2000      	movs	r0, #0
c0d01c1e:	4602      	mov	r2, r0
c0d01c20:	463b      	mov	r3, r7
c0d01c22:	9f07      	ldr	r7, [sp, #28]
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d01c24:	4619      	mov	r1, r3
c0d01c26:	4341      	muls	r1, r0
c0d01c28:	5c6c      	ldrb	r4, [r5, r1]

	while (n-- >= t) {
		int z = (rn << 16 | r[n] << 8 | (r[n-1] & -(n > 0))) / dt;
		rn += mula_small(r,r, n-t+1, d, t, -z);
		q[n-t+1] = z + rn; /* rn is 0 or -1 (underflow) */
		mula_small(r,r, n-t+1, d, t, -rn);
c0d01c2a:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d01c2c:	4374      	muls	r4, r6
c0d01c2e:	462e      	mov	r6, r5
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d01c30:	5c7d      	ldrb	r5, [r7, r1]
c0d01c32:	18aa      	adds	r2, r5, r2
c0d01c34:	4635      	mov	r5, r6
c0d01c36:	1b12      	subs	r2, r2, r4
c0d01c38:	547a      	strb	r2, [r7, r1]
		v >>= 8;
c0d01c3a:	1212      	asrs	r2, r2, #8
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d01c3c:	1e40      	subs	r0, r0, #1
c0d01c3e:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01c40:	4281      	cmp	r1, r0
c0d01c42:	d1ef      	bne.n	c0d01c24 <divmod+0xc0>
c0d01c44:	e004      	b.n	c0d01c50 <divmod+0xec>
	int dt = d[t-1] << 8 | (d[t-2] & -(t > 1));

	while (n-- >= t) {
		int z = (rn << 16 | r[n] << 8 | (r[n-1] & -(n > 0))) / dt;
		rn += mula_small(r,r, n-t+1, d, t, -z);
		q[n-t+1] = z + rn; /* rn is 0 or -1 (underflow) */
c0d01c46:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d01c48:	1840      	adds	r0, r0, r1
c0d01c4a:	9904      	ldr	r1, [sp, #16]
c0d01c4c:	5488      	strb	r0, [r1, r2]
c0d01c4e:	9b02      	ldr	r3, [sp, #8]
c0d01c50:	9908      	ldr	r1, [sp, #32]
		mula_small(r,r, n-t+1, d, t, -rn);
		rn = r[n];
c0d01c52:	780a      	ldrb	r2, [r1, #0]
		r[n] = 0;
c0d01c54:	2000      	movs	r0, #0
c0d01c56:	7008      	strb	r0, [r1, #0]
 * q may overlap with r+t */
static void divmod(dstptr q, dstptr r, unsigned n, srcptr d, unsigned t) {
	int rn = 0;
	int dt = d[t-1] << 8 | (d[t-2] & -(t > 1));

	while (n-- >= t) {
c0d01c58:	18ff      	adds	r7, r7, r3
c0d01c5a:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d01c5c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01c5e:	4286      	cmp	r6, r0
c0d01c60:	9c03      	ldr	r4, [sp, #12]
c0d01c62:	d2a6      	bcs.n	c0d01bb2 <divmod+0x4e>
		mula_small(r,r, n-t+1, d, t, -rn);
		rn = r[n];
		r[n] = 0;
	}

	r[t-1] = rn;
c0d01c64:	9800      	ldr	r0, [sp, #0]
c0d01c66:	5422      	strb	r2, [r4, r0]
}
c0d01c68:	b00d      	add	sp, #52	; 0x34
c0d01c6a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01c6c <sign25519>:
			mula_small(s, s, 0, order25519, 32, 1);
	}
}

/* v = (x - h) s  mod q  */
int sign25519(k25519 v, const k25519 h, const priv25519 x, const spriv25519 s) {
c0d01c6c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c6e:	b097      	sub	sp, #92	; 0x5c
c0d01c70:	9303      	str	r3, [sp, #12]
c0d01c72:	9205      	str	r2, [sp, #20]
c0d01c74:	460e      	mov	r6, r1
c0d01c76:	4604      	mov	r4, r0
	uint8_t tmp[65];
	unsigned w;
	int i;
	for (i = 0; i < 32; i++)
		v[i] = 0;
c0d01c78:	2120      	movs	r1, #32
c0d01c7a:	9104      	str	r1, [sp, #16]
c0d01c7c:	f002 fe6e 	bl	c0d0495c <__aeabi_memclr>
c0d01c80:	2000      	movs	r0, #0
c0d01c82:	43c5      	mvns	r5, r0
c0d01c84:	4601      	mov	r1, r0
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d01c86:	462a      	mov	r2, r5
c0d01c88:	4342      	muls	r2, r0
c0d01c8a:	5cb3      	ldrb	r3, [r6, r2]
c0d01c8c:	9f05      	ldr	r7, [sp, #20]
c0d01c8e:	5cbf      	ldrb	r7, [r7, r2]
c0d01c90:	1879      	adds	r1, r7, r1
c0d01c92:	1ac9      	subs	r1, r1, r3
c0d01c94:	54a1      	strb	r1, [r4, r2]
		v >>= 8;
c0d01c96:	1209      	asrs	r1, r1, #8
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d01c98:	1e40      	subs	r0, r0, #1
c0d01c9a:	4602      	mov	r2, r0
c0d01c9c:	3220      	adds	r2, #32
c0d01c9e:	d1f2      	bne.n	c0d01c86 <sign25519+0x1a>
c0d01ca0:	201f      	movs	r0, #31
	unsigned w;
	int i;
	for (i = 0; i < 32; i++)
		v[i] = 0;
	i = mula_small(v, x, 0, h, 32, -1);
	mula_small(v, v, 0, order25519, 32, (15-(int8_t) v[31])/16);
c0d01ca2:	5620      	ldrsb	r0, [r4, r0]
c0d01ca4:	210f      	movs	r1, #15
c0d01ca6:	1a08      	subs	r0, r1, r0
c0d01ca8:	17c1      	asrs	r1, r0, #31
c0d01caa:	0f09      	lsrs	r1, r1, #28
c0d01cac:	1840      	adds	r0, r0, r1
c0d01cae:	1100      	asrs	r0, r0, #4
c0d01cb0:	2100      	movs	r1, #0
c0d01cb2:	460a      	mov	r2, r1
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d01cb4:	462b      	mov	r3, r5
c0d01cb6:	434b      	muls	r3, r1
c0d01cb8:	4e1e      	ldr	r6, [pc, #120]	; (c0d01d34 <sign25519+0xc8>)
c0d01cba:	447e      	add	r6, pc
c0d01cbc:	5cf6      	ldrb	r6, [r6, r3]
c0d01cbe:	4346      	muls	r6, r0
c0d01cc0:	5ce7      	ldrb	r7, [r4, r3]
c0d01cc2:	18ba      	adds	r2, r7, r2
c0d01cc4:	1992      	adds	r2, r2, r6
c0d01cc6:	54e2      	strb	r2, [r4, r3]
		v >>= 8;
c0d01cc8:	1212      	asrs	r2, r2, #8
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d01cca:	1e49      	subs	r1, r1, #1
c0d01ccc:	460b      	mov	r3, r1
c0d01cce:	3320      	adds	r3, #32
c0d01cd0:	d1f0      	bne.n	c0d01cb4 <sign25519+0x48>
c0d01cd2:	ae06      	add	r6, sp, #24
	for (i = 0; i < 32; i++)
		v[i] = 0;
	i = mula_small(v, x, 0, h, 32, -1);
	mula_small(v, v, 0, order25519, 32, (15-(int8_t) v[31])/16);
	for (i = 0; i < 64; i++)
		tmp[i] = 0;
c0d01cd4:	2140      	movs	r1, #64	; 0x40
c0d01cd6:	9102      	str	r1, [sp, #8]
c0d01cd8:	4630      	mov	r0, r6
c0d01cda:	f002 fe3f 	bl	c0d0495c <__aeabi_memclr>
	mula32(tmp, v, s, 32, 1);
c0d01cde:	2101      	movs	r1, #1
c0d01ce0:	4668      	mov	r0, sp
c0d01ce2:	9105      	str	r1, [sp, #20]
c0d01ce4:	6001      	str	r1, [r0, #0]
c0d01ce6:	4630      	mov	r0, r6
c0d01ce8:	4621      	mov	r1, r4
c0d01cea:	9a03      	ldr	r2, [sp, #12]
c0d01cec:	9f04      	ldr	r7, [sp, #16]
c0d01cee:	463b      	mov	r3, r7
c0d01cf0:	f000 f824 	bl	c0d01d3c <mula32>
	divmod(tmp+32, tmp, 64, order25519, 32);
c0d01cf4:	4668      	mov	r0, sp
c0d01cf6:	6007      	str	r7, [r0, #0]
c0d01cf8:	4630      	mov	r0, r6
c0d01cfa:	3020      	adds	r0, #32
c0d01cfc:	4b0e      	ldr	r3, [pc, #56]	; (c0d01d38 <sign25519+0xcc>)
c0d01cfe:	447b      	add	r3, pc
c0d01d00:	4631      	mov	r1, r6
c0d01d02:	9a02      	ldr	r2, [sp, #8]
c0d01d04:	f7ff ff2e 	bl	c0d01b64 <divmod>
	for (w = 0, i = 0; i < 32; i++)
		w |= v[i] = tmp[i];
c0d01d08:	4620      	mov	r0, r4
c0d01d0a:	4631      	mov	r1, r6
c0d01d0c:	463a      	mov	r2, r7
c0d01d0e:	f002 fe2b 	bl	c0d04968 <__aeabi_memcpy>
c0d01d12:	2100      	movs	r1, #0
c0d01d14:	460c      	mov	r4, r1
c0d01d16:	462a      	mov	r2, r5
c0d01d18:	434a      	muls	r2, r1
c0d01d1a:	ab06      	add	r3, sp, #24
c0d01d1c:	5c9a      	ldrb	r2, [r3, r2]
c0d01d1e:	4314      	orrs	r4, r2
	mula_small(v, v, 0, order25519, 32, (15-(int8_t) v[31])/16);
	for (i = 0; i < 64; i++)
		tmp[i] = 0;
	mula32(tmp, v, s, 32, 1);
	divmod(tmp+32, tmp, 64, order25519, 32);
	for (w = 0, i = 0; i < 32; i++)
c0d01d20:	1e49      	subs	r1, r1, #1
c0d01d22:	460a      	mov	r2, r1
c0d01d24:	3220      	adds	r2, #32
c0d01d26:	d1f6      	bne.n	c0d01d16 <sign25519+0xaa>
		w |= v[i] = tmp[i];
	return w != 0;
c0d01d28:	2c00      	cmp	r4, #0
c0d01d2a:	9805      	ldr	r0, [sp, #20]
c0d01d2c:	d100      	bne.n	c0d01d30 <sign25519+0xc4>
c0d01d2e:	4620      	mov	r0, r4
c0d01d30:	b017      	add	sp, #92	; 0x5c
c0d01d32:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01d34:	00002e66 	.word	0x00002e66
c0d01d38:	00002e22 	.word	0x00002e22

c0d01d3c <mula32>:
}

/* p += x * y * z  where z is a small integer
 * x is size 32, y is size t, p is size 32+t
 * y is allowed to overlap with p+32 if you don't care about the upper half  */
static int mula32(dstptr p, srcptr x, srcptr y, unsigned t, int z) {
c0d01d3c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d3e:	b087      	sub	sp, #28
c0d01d40:	9202      	str	r2, [sp, #8]
c0d01d42:	9004      	str	r0, [sp, #16]
c0d01d44:	2400      	movs	r4, #0
c0d01d46:	201f      	movs	r0, #31
c0d01d48:	9303      	str	r3, [sp, #12]
	const unsigned n = 31;
	int w = 0;
	unsigned i;
	for (i = 0; i < t; i++) {
c0d01d4a:	2b00      	cmp	r3, #0
c0d01d4c:	d02c      	beq.n	c0d01da8 <mula32+0x6c>
c0d01d4e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01d50:	9001      	str	r0, [sp, #4]
c0d01d52:	2000      	movs	r0, #0
c0d01d54:	4604      	mov	r4, r0
c0d01d56:	9000      	str	r0, [sp, #0]
c0d01d58:	4602      	mov	r2, r0
c0d01d5a:	9406      	str	r4, [sp, #24]
c0d01d5c:	9804      	ldr	r0, [sp, #16]
c0d01d5e:	1885      	adds	r5, r0, r2
		int zy = z * y[i];
c0d01d60:	9802      	ldr	r0, [sp, #8]
c0d01d62:	9205      	str	r2, [sp, #20]
c0d01d64:	5c80      	ldrb	r0, [r0, r2]
c0d01d66:	9a01      	ldr	r2, [sp, #4]
c0d01d68:	4350      	muls	r0, r2
c0d01d6a:	9e00      	ldr	r6, [sp, #0]
c0d01d6c:	4632      	mov	r2, r6
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
		p[i+m] = v += q[i+m] + z * x[i];
c0d01d6e:	1a8b      	subs	r3, r1, r2
c0d01d70:	781b      	ldrb	r3, [r3, #0]
c0d01d72:	4343      	muls	r3, r0
c0d01d74:	1aac      	subs	r4, r5, r2
c0d01d76:	7827      	ldrb	r7, [r4, #0]
c0d01d78:	19be      	adds	r6, r7, r6
c0d01d7a:	18f3      	adds	r3, r6, r3
c0d01d7c:	7023      	strb	r3, [r4, #0]
		v >>= 8;
c0d01d7e:	121e      	asrs	r6, r3, #8
/* n+m is the size of p and q */
static inline
int mula_small(dstptr p, srcptr q, unsigned m, srcptr x, unsigned n, int z) {
	int v = 0;
	unsigned i;
	for (i = 0; i < n; i++) {
c0d01d80:	1e52      	subs	r2, r2, #1
c0d01d82:	4613      	mov	r3, r2
c0d01d84:	331f      	adds	r3, #31
c0d01d86:	d1f2      	bne.n	c0d01d6e <mula32+0x32>
	const unsigned n = 31;
	int w = 0;
	unsigned i;
	for (i = 0; i < t; i++) {
		int zy = z * y[i];
		p[i+n] = w += mula_small(p,p, i, x, n, zy) + p[i+n] + zy * x[n];
c0d01d88:	9a06      	ldr	r2, [sp, #24]
c0d01d8a:	18b2      	adds	r2, r6, r2
c0d01d8c:	7feb      	ldrb	r3, [r5, #31]
c0d01d8e:	18d2      	adds	r2, r2, r3
c0d01d90:	7fcb      	ldrb	r3, [r1, #31]
c0d01d92:	4358      	muls	r0, r3
c0d01d94:	1810      	adds	r0, r2, r0
c0d01d96:	77e8      	strb	r0, [r5, #31]
		w >>= 8;
c0d01d98:	1204      	asrs	r4, r0, #8
c0d01d9a:	9a05      	ldr	r2, [sp, #20]
 * y is allowed to overlap with p+32 if you don't care about the upper half  */
static int mula32(dstptr p, srcptr x, srcptr y, unsigned t, int z) {
	const unsigned n = 31;
	int w = 0;
	unsigned i;
	for (i = 0; i < t; i++) {
c0d01d9c:	1c52      	adds	r2, r2, #1
c0d01d9e:	9803      	ldr	r0, [sp, #12]
c0d01da0:	4282      	cmp	r2, r0
c0d01da2:	d1da      	bne.n	c0d01d5a <mula32+0x1e>
c0d01da4:	9803      	ldr	r0, [sp, #12]
		int zy = z * y[i];
		p[i+n] = w += mula_small(p,p, i, x, n, zy) + p[i+n] + zy * x[n];
		w >>= 8;
	}
	p[i+n] += w;
c0d01da6:	301f      	adds	r0, #31
c0d01da8:	9a04      	ldr	r2, [sp, #16]
c0d01daa:	5c11      	ldrb	r1, [r2, r0]
c0d01dac:	1909      	adds	r1, r1, r4
c0d01dae:	5411      	strb	r1, [r2, r0]
c0d01db0:	b007      	add	sp, #28
c0d01db2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01db4 <mul25519small>:
}

/* Multiply a number by a small integer in range -185861411 .. 185861411.
 * The output is in reduced form, the input x need not be.  x and xy may point
 * to the same buffer. */
static i25519ptr mul25519small(i25519 xy, const i25519 x, const int32_t y) {
c0d01db4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01db6:	b08b      	sub	sp, #44	; 0x2c
c0d01db8:	920a      	str	r2, [sp, #40]	; 0x28
c0d01dba:	460e      	mov	r6, r1
c0d01dbc:	4604      	mov	r4, r0
	register int64_t t;
	check_nonred("mul small x input", x);
	check_range("mul small y input", y, -185861411, 185861411);
	t = m64(x[8],y);
c0d01dbe:	17d7      	asrs	r7, r2, #31
c0d01dc0:	6a30      	ldr	r0, [r6, #32]
c0d01dc2:	9608      	str	r6, [sp, #32]
c0d01dc4:	17c1      	asrs	r1, r0, #31
c0d01dc6:	463b      	mov	r3, r7
c0d01dc8:	9706      	str	r7, [sp, #24]
c0d01dca:	f002 fd9b 	bl	c0d04904 <__aeabi_lmul>
c0d01dce:	9004      	str	r0, [sp, #16]
	t = (t >> 25) + m64(x[6],y);
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[7],y);
	xy[7] = t & ((1 << 25) - 1);
	t = (t >> 25) + xy[8];
	xy[8] = t & ((1 << 26) - 1);
c0d01dd0:	4a64      	ldr	r2, [pc, #400]	; (c0d01f64 <mul25519small+0x1b0>)
static i25519ptr mul25519small(i25519 xy, const i25519 x, const int32_t y) {
	register int64_t t;
	check_nonred("mul small x input", x);
	check_range("mul small y input", y, -185861411, 185861411);
	t = m64(x[8],y);
	xy[8] = t & ((1 << 26) - 1);
c0d01dd2:	9209      	str	r2, [sp, #36]	; 0x24
c0d01dd4:	4603      	mov	r3, r0
c0d01dd6:	4013      	ands	r3, r2
c0d01dd8:	6223      	str	r3, [r4, #32]
	t = (t >> 26) + m64(x[9],y);
c0d01dda:	9405      	str	r4, [sp, #20]
c0d01ddc:	018a      	lsls	r2, r1, #6
c0d01dde:	0e85      	lsrs	r5, r0, #26
c0d01de0:	4315      	orrs	r5, r2
c0d01de2:	1688      	asrs	r0, r1, #26
c0d01de4:	9007      	str	r0, [sp, #28]
c0d01de6:	6a70      	ldr	r0, [r6, #36]	; 0x24
c0d01de8:	17c1      	asrs	r1, r0, #31
c0d01dea:	9e0a      	ldr	r6, [sp, #40]	; 0x28
c0d01dec:	4632      	mov	r2, r6
c0d01dee:	463b      	mov	r3, r7
c0d01df0:	f002 fd88 	bl	c0d04904 <__aeabi_lmul>
c0d01df4:	1940      	adds	r0, r0, r5
c0d01df6:	9a07      	ldr	r2, [sp, #28]
c0d01df8:	4151      	adcs	r1, r2
	t = (t >> 26) + m64(x[5],y);
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[6],y);
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[7],y);
	xy[7] = t & ((1 << 25) - 1);
c0d01dfa:	4b5b      	ldr	r3, [pc, #364]	; (c0d01f68 <mul25519small+0x1b4>)
	check_range("mul small y input", y, -185861411, 185861411);
	t = m64(x[8],y);
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[9],y);
	xy[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],y);
c0d01dfc:	9307      	str	r3, [sp, #28]
c0d01dfe:	0e42      	lsrs	r2, r0, #25
	check_nonred("mul small x input", x);
	check_range("mul small y input", y, -185861411, 185861411);
	t = m64(x[8],y);
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[9],y);
	xy[9] = t & ((1 << 25) - 1);
c0d01e00:	4018      	ands	r0, r3
c0d01e02:	9003      	str	r0, [sp, #12]
c0d01e04:	6260      	str	r0, [r4, #36]	; 0x24
	t = 19 * (t >> 25) + m64(x[0],y);
c0d01e06:	01c8      	lsls	r0, r1, #7
c0d01e08:	4310      	orrs	r0, r2
c0d01e0a:	1649      	asrs	r1, r1, #25
c0d01e0c:	2213      	movs	r2, #19
c0d01e0e:	2300      	movs	r3, #0
c0d01e10:	9302      	str	r3, [sp, #8]
c0d01e12:	f002 fd77 	bl	c0d04904 <__aeabi_lmul>
c0d01e16:	4605      	mov	r5, r0
c0d01e18:	9101      	str	r1, [sp, #4]
c0d01e1a:	9f08      	ldr	r7, [sp, #32]
c0d01e1c:	6838      	ldr	r0, [r7, #0]
c0d01e1e:	17c1      	asrs	r1, r0, #31
c0d01e20:	4632      	mov	r2, r6
c0d01e22:	9c06      	ldr	r4, [sp, #24]
c0d01e24:	4623      	mov	r3, r4
c0d01e26:	f002 fd6d 	bl	c0d04904 <__aeabi_lmul>
c0d01e2a:	1828      	adds	r0, r5, r0
c0d01e2c:	9a01      	ldr	r2, [sp, #4]
c0d01e2e:	4151      	adcs	r1, r2
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[1],y);
c0d01e30:	0e82      	lsrs	r2, r0, #26
	t = m64(x[8],y);
	xy[8] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[9],y);
	xy[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],y);
	xy[0] = t & ((1 << 26) - 1);
c0d01e32:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01e34:	4018      	ands	r0, r3
c0d01e36:	9e05      	ldr	r6, [sp, #20]
c0d01e38:	6030      	str	r0, [r6, #0]
	t = (t >> 26) + m64(x[1],y);
c0d01e3a:	018d      	lsls	r5, r1, #6
c0d01e3c:	4315      	orrs	r5, r2
c0d01e3e:	1688      	asrs	r0, r1, #26
c0d01e40:	9001      	str	r0, [sp, #4]
c0d01e42:	6878      	ldr	r0, [r7, #4]
c0d01e44:	17c1      	asrs	r1, r0, #31
c0d01e46:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01e48:	4623      	mov	r3, r4
c0d01e4a:	4627      	mov	r7, r4
c0d01e4c:	f002 fd5a 	bl	c0d04904 <__aeabi_lmul>
c0d01e50:	1828      	adds	r0, r5, r0
c0d01e52:	9a01      	ldr	r2, [sp, #4]
c0d01e54:	4151      	adcs	r1, r2
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[2],y);
c0d01e56:	0e42      	lsrs	r2, r0, #25
	t = (t >> 26) + m64(x[9],y);
	xy[9] = t & ((1 << 25) - 1);
	t = 19 * (t >> 25) + m64(x[0],y);
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[1],y);
	xy[1] = t & ((1 << 25) - 1);
c0d01e58:	9b07      	ldr	r3, [sp, #28]
c0d01e5a:	4018      	ands	r0, r3
c0d01e5c:	6070      	str	r0, [r6, #4]
	t = (t >> 25) + m64(x[2],y);
c0d01e5e:	01cd      	lsls	r5, r1, #7
c0d01e60:	4315      	orrs	r5, r2
c0d01e62:	1648      	asrs	r0, r1, #25
c0d01e64:	9001      	str	r0, [sp, #4]
c0d01e66:	9c08      	ldr	r4, [sp, #32]
c0d01e68:	68a0      	ldr	r0, [r4, #8]
c0d01e6a:	17c1      	asrs	r1, r0, #31
c0d01e6c:	9e0a      	ldr	r6, [sp, #40]	; 0x28
c0d01e6e:	4632      	mov	r2, r6
c0d01e70:	463b      	mov	r3, r7
c0d01e72:	f002 fd47 	bl	c0d04904 <__aeabi_lmul>
c0d01e76:	1828      	adds	r0, r5, r0
c0d01e78:	9a01      	ldr	r2, [sp, #4]
c0d01e7a:	4151      	adcs	r1, r2
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[3],y);
c0d01e7c:	0e82      	lsrs	r2, r0, #26
	t = 19 * (t >> 25) + m64(x[0],y);
	xy[0] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[1],y);
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[2],y);
	xy[2] = t & ((1 << 26) - 1);
c0d01e7e:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01e80:	4018      	ands	r0, r3
c0d01e82:	9f05      	ldr	r7, [sp, #20]
c0d01e84:	60b8      	str	r0, [r7, #8]
	t = (t >> 26) + m64(x[3],y);
c0d01e86:	018d      	lsls	r5, r1, #6
c0d01e88:	4315      	orrs	r5, r2
c0d01e8a:	1688      	asrs	r0, r1, #26
c0d01e8c:	9001      	str	r0, [sp, #4]
c0d01e8e:	68e0      	ldr	r0, [r4, #12]
c0d01e90:	17c1      	asrs	r1, r0, #31
c0d01e92:	4632      	mov	r2, r6
c0d01e94:	9c06      	ldr	r4, [sp, #24]
c0d01e96:	4623      	mov	r3, r4
c0d01e98:	f002 fd34 	bl	c0d04904 <__aeabi_lmul>
c0d01e9c:	1828      	adds	r0, r5, r0
c0d01e9e:	9a01      	ldr	r2, [sp, #4]
c0d01ea0:	4151      	adcs	r1, r2
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[4],y);
c0d01ea2:	0e42      	lsrs	r2, r0, #25
	t = (t >> 26) + m64(x[1],y);
	xy[1] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[2],y);
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[3],y);
	xy[3] = t & ((1 << 25) - 1);
c0d01ea4:	9b07      	ldr	r3, [sp, #28]
c0d01ea6:	4018      	ands	r0, r3
c0d01ea8:	463e      	mov	r6, r7
c0d01eaa:	60f0      	str	r0, [r6, #12]
	t = (t >> 25) + m64(x[4],y);
c0d01eac:	01cd      	lsls	r5, r1, #7
c0d01eae:	4315      	orrs	r5, r2
c0d01eb0:	1648      	asrs	r0, r1, #25
c0d01eb2:	9001      	str	r0, [sp, #4]
c0d01eb4:	9f08      	ldr	r7, [sp, #32]
c0d01eb6:	6938      	ldr	r0, [r7, #16]
c0d01eb8:	17c1      	asrs	r1, r0, #31
c0d01eba:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01ebc:	4623      	mov	r3, r4
c0d01ebe:	f002 fd21 	bl	c0d04904 <__aeabi_lmul>
c0d01ec2:	1828      	adds	r0, r5, r0
c0d01ec4:	9a01      	ldr	r2, [sp, #4]
c0d01ec6:	4151      	adcs	r1, r2
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[5],y);
c0d01ec8:	0e82      	lsrs	r2, r0, #26
	t = (t >> 25) + m64(x[2],y);
	xy[2] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[3],y);
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[4],y);
	xy[4] = t & ((1 << 26) - 1);
c0d01eca:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01ecc:	4018      	ands	r0, r3
c0d01ece:	6130      	str	r0, [r6, #16]
	t = (t >> 26) + m64(x[5],y);
c0d01ed0:	018d      	lsls	r5, r1, #6
c0d01ed2:	4315      	orrs	r5, r2
c0d01ed4:	1688      	asrs	r0, r1, #26
c0d01ed6:	9001      	str	r0, [sp, #4]
c0d01ed8:	6978      	ldr	r0, [r7, #20]
c0d01eda:	17c1      	asrs	r1, r0, #31
c0d01edc:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d01ede:	463a      	mov	r2, r7
c0d01ee0:	4623      	mov	r3, r4
c0d01ee2:	f002 fd0f 	bl	c0d04904 <__aeabi_lmul>
c0d01ee6:	1828      	adds	r0, r5, r0
c0d01ee8:	9a01      	ldr	r2, [sp, #4]
c0d01eea:	4151      	adcs	r1, r2
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[6],y);
c0d01eec:	0e42      	lsrs	r2, r0, #25
	t = (t >> 26) + m64(x[3],y);
	xy[3] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[4],y);
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[5],y);
	xy[5] = t & ((1 << 25) - 1);
c0d01eee:	9b07      	ldr	r3, [sp, #28]
c0d01ef0:	4018      	ands	r0, r3
c0d01ef2:	6170      	str	r0, [r6, #20]
	t = (t >> 25) + m64(x[6],y);
c0d01ef4:	01cd      	lsls	r5, r1, #7
c0d01ef6:	4315      	orrs	r5, r2
c0d01ef8:	1648      	asrs	r0, r1, #25
c0d01efa:	9001      	str	r0, [sp, #4]
c0d01efc:	9808      	ldr	r0, [sp, #32]
c0d01efe:	6980      	ldr	r0, [r0, #24]
c0d01f00:	17c1      	asrs	r1, r0, #31
c0d01f02:	463a      	mov	r2, r7
c0d01f04:	4623      	mov	r3, r4
c0d01f06:	f002 fcfd 	bl	c0d04904 <__aeabi_lmul>
c0d01f0a:	1828      	adds	r0, r5, r0
c0d01f0c:	9a01      	ldr	r2, [sp, #4]
c0d01f0e:	4151      	adcs	r1, r2
	xy[6] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[7],y);
c0d01f10:	0e82      	lsrs	r2, r0, #26
	t = (t >> 25) + m64(x[4],y);
	xy[4] = t & ((1 << 26) - 1);
	t = (t >> 26) + m64(x[5],y);
	xy[5] = t & ((1 << 25) - 1);
	t = (t >> 25) + m64(x[6],y);
	xy[6] = t & ((1 << 26) - 1);
c0d01f12:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01f14:	4018      	ands	r0, r3
c0d01f16:	4637      	mov	r7, r6
c0d01f18:	61b8      	str	r0, [r7, #24]
	t = (t >> 26) + m64(x[7],y);
c0d01f1a:	018d      	lsls	r5, r1, #6
c0d01f1c:	4315      	orrs	r5, r2
c0d01f1e:	168e      	asrs	r6, r1, #26
c0d01f20:	9808      	ldr	r0, [sp, #32]
c0d01f22:	69c0      	ldr	r0, [r0, #28]
c0d01f24:	17c1      	asrs	r1, r0, #31
c0d01f26:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01f28:	4623      	mov	r3, r4
c0d01f2a:	f002 fceb 	bl	c0d04904 <__aeabi_lmul>
c0d01f2e:	1828      	adds	r0, r5, r0
c0d01f30:	4171      	adcs	r1, r6
c0d01f32:	9a07      	ldr	r2, [sp, #28]
	xy[7] = t & ((1 << 25) - 1);
c0d01f34:	4002      	ands	r2, r0
c0d01f36:	61fa      	str	r2, [r7, #28]
	t = (t >> 25) + xy[8];
c0d01f38:	01ca      	lsls	r2, r1, #7
c0d01f3a:	0e40      	lsrs	r0, r0, #25
c0d01f3c:	4310      	orrs	r0, r2
c0d01f3e:	1649      	asrs	r1, r1, #25
c0d01f40:	223f      	movs	r2, #63	; 0x3f
c0d01f42:	0692      	lsls	r2, r2, #26
c0d01f44:	9d04      	ldr	r5, [sp, #16]
c0d01f46:	4395      	bics	r5, r2
c0d01f48:	1940      	adds	r0, r0, r5
c0d01f4a:	9a02      	ldr	r2, [sp, #8]
c0d01f4c:	4151      	adcs	r1, r2
c0d01f4e:	9a09      	ldr	r2, [sp, #36]	; 0x24
	xy[8] = t & ((1 << 26) - 1);
c0d01f50:	4002      	ands	r2, r0
c0d01f52:	623a      	str	r2, [r7, #32]
	xy[9] += (int32_t)(t >> 26);
c0d01f54:	0189      	lsls	r1, r1, #6
c0d01f56:	0e80      	lsrs	r0, r0, #26
c0d01f58:	4308      	orrs	r0, r1
c0d01f5a:	9903      	ldr	r1, [sp, #12]
c0d01f5c:	1840      	adds	r0, r0, r1
c0d01f5e:	6278      	str	r0, [r7, #36]	; 0x24
c0d01f60:	b00b      	add	sp, #44	; 0x2c
c0d01f62:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01f64:	03ffffff 	.word	0x03ffffff
c0d01f68:	01ffffff 	.word	0x01ffffff

c0d01f6c <cx_hash_X>:
}

int cx_hash_X(cx_hash_t *hash ,
              int mode,
              unsigned char WIDE *in , unsigned int len,
              unsigned char *out) {
c0d01f6c:	b570      	push	{r4, r5, r6, lr}
c0d01f6e:	b082      	sub	sp, #8
c0d01f70:	7805      	ldrb	r5, [r0, #0]
c0d01f72:	2414      	movs	r4, #20
   unsigned int hsz = 0;

    switch (hash->algo) {
c0d01f74:	2d05      	cmp	r5, #5
c0d01f76:	dc09      	bgt.n	c0d01f8c <cx_hash_X+0x20>
c0d01f78:	2d02      	cmp	r5, #2
c0d01f7a:	dd17      	ble.n	c0d01fac <cx_hash_X+0x40>
c0d01f7c:	2d03      	cmp	r5, #3
c0d01f7e:	d01b      	beq.n	c0d01fb8 <cx_hash_X+0x4c>
c0d01f80:	2d04      	cmp	r5, #4
c0d01f82:	d01b      	beq.n	c0d01fbc <cx_hash_X+0x50>
c0d01f84:	2d05      	cmp	r5, #5
c0d01f86:	d11b      	bne.n	c0d01fc0 <cx_hash_X+0x54>
c0d01f88:	2440      	movs	r4, #64	; 0x40
c0d01f8a:	e007      	b.n	c0d01f9c <cx_hash_X+0x30>
c0d01f8c:	1fac      	subs	r4, r5, #6
c0d01f8e:	2c03      	cmp	r4, #3
c0d01f90:	d303      	bcc.n	c0d01f9a <cx_hash_X+0x2e>
c0d01f92:	2d09      	cmp	r5, #9
c0d01f94:	d001      	beq.n	c0d01f9a <cx_hash_X+0x2e>
c0d01f96:	2d0a      	cmp	r5, #10
c0d01f98:	d112      	bne.n	c0d01fc0 <cx_hash_X+0x54>
c0d01f9a:	6884      	ldr	r4, [r0, #8]
c0d01f9c:	9d06      	ldr	r5, [sp, #24]
    default:
        THROW(INVALID_PARAMETER);
        return 0;
    }

    return cx_hash(hash, mode, in, len, out, hsz);
c0d01f9e:	466e      	mov	r6, sp
c0d01fa0:	6035      	str	r5, [r6, #0]
c0d01fa2:	6074      	str	r4, [r6, #4]
c0d01fa4:	f001 fc34 	bl	c0d03810 <cx_hash>
c0d01fa8:	b002      	add	sp, #8
c0d01faa:	bd70      	pop	{r4, r5, r6, pc}
c0d01fac:	2d01      	cmp	r5, #1
c0d01fae:	d0f5      	beq.n	c0d01f9c <cx_hash_X+0x30>
c0d01fb0:	2d02      	cmp	r5, #2
c0d01fb2:	d105      	bne.n	c0d01fc0 <cx_hash_X+0x54>
c0d01fb4:	241c      	movs	r4, #28
c0d01fb6:	e7f1      	b.n	c0d01f9c <cx_hash_X+0x30>
c0d01fb8:	2420      	movs	r4, #32
c0d01fba:	e7ef      	b.n	c0d01f9c <cx_hash_X+0x30>
c0d01fbc:	2430      	movs	r4, #48	; 0x30
c0d01fbe:	e7ed      	b.n	c0d01f9c <cx_hash_X+0x30>
        break;  
    case CX_BLAKE2B:
        hsz =   ((cx_blake2b_t*)hash)->output_size;
        break;
    default:
        THROW(INVALID_PARAMETER);
c0d01fc0:	2002      	movs	r0, #2
c0d01fc2:	f000 ff94 	bl	c0d02eee <os_longjmp>
	...

c0d01fc8 <io_exchange_al>:
    // Display back the original UX
    ui_idle();
    return 0; // do not redraw the widget
}

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d01fc8:	b5b0      	push	{r4, r5, r7, lr}
c0d01fca:	4605      	mov	r5, r0
c0d01fcc:	2007      	movs	r0, #7
    switch (channel & ~(IO_FLAGS)) {
c0d01fce:	4028      	ands	r0, r5
c0d01fd0:	2400      	movs	r4, #0
c0d01fd2:	2801      	cmp	r0, #1
c0d01fd4:	d013      	beq.n	c0d01ffe <io_exchange_al+0x36>
c0d01fd6:	2802      	cmp	r0, #2
c0d01fd8:	d113      	bne.n	c0d02002 <io_exchange_al+0x3a>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d01fda:	2900      	cmp	r1, #0
c0d01fdc:	d008      	beq.n	c0d01ff0 <io_exchange_al+0x28>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d01fde:	480a      	ldr	r0, [pc, #40]	; (c0d02008 <io_exchange_al+0x40>)
c0d01fe0:	f001 fcd0 	bl	c0d03984 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d01fe4:	b268      	sxtb	r0, r5
c0d01fe6:	2800      	cmp	r0, #0
c0d01fe8:	da09      	bge.n	c0d01ffe <io_exchange_al+0x36>
                reset();
c0d01fea:	f001 fbcf 	bl	c0d0378c <reset>
c0d01fee:	e006      	b.n	c0d01ffe <io_exchange_al+0x36>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d01ff0:	2041      	movs	r0, #65	; 0x41
c0d01ff2:	0081      	lsls	r1, r0, #2
c0d01ff4:	4804      	ldr	r0, [pc, #16]	; (c0d02008 <io_exchange_al+0x40>)
c0d01ff6:	2200      	movs	r2, #0
c0d01ff8:	f001 fcf0 	bl	c0d039dc <io_seproxyhal_spi_recv>
c0d01ffc:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d01ffe:	4620      	mov	r0, r4
c0d02000:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d02002:	2002      	movs	r0, #2
c0d02004:	f000 ff73 	bl	c0d02eee <os_longjmp>
c0d02008:	20001a44 	.word	0x20001a44

c0d0200c <io_seproxyhal_display>:

return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d0200c:	b580      	push	{r7, lr}
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0200e:	f001 fa19 	bl	c0d03444 <io_seproxyhal_display_default>
}
c0d02012:	bd80      	pop	{r7, pc}

c0d02014 <io_event>:
#else
    UX_DISPLAY(bagl_ui_approval_nanos, NULL);
#endif
}

unsigned char io_event(unsigned char channel) {
c0d02014:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02016:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d02018:	49f3      	ldr	r1, [pc, #972]	; (c0d023e8 <io_event+0x3d4>)
c0d0201a:	7808      	ldrb	r0, [r1, #0]
c0d0201c:	2501      	movs	r5, #1
c0d0201e:	022f      	lsls	r7, r5, #8
c0d02020:	4ef2      	ldr	r6, [pc, #968]	; (c0d023ec <io_event+0x3d8>)
c0d02022:	280c      	cmp	r0, #12
c0d02024:	dc2b      	bgt.n	c0d0207e <io_event+0x6a>
c0d02026:	2805      	cmp	r0, #5
c0d02028:	d06f      	beq.n	c0d0210a <io_event+0xf6>
c0d0202a:	280c      	cmp	r0, #12
c0d0202c:	d000      	beq.n	c0d02030 <io_event+0x1c>
c0d0202e:	e0b1      	b.n	c0d02194 <io_event+0x180>
c0d02030:	460f      	mov	r7, r1
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d02032:	4cef      	ldr	r4, [pc, #956]	; (c0d023f0 <io_event+0x3dc>)
c0d02034:	7625      	strb	r5, [r4, #24]
c0d02036:	2600      	movs	r6, #0
c0d02038:	61e6      	str	r6, [r4, #28]
c0d0203a:	4620      	mov	r0, r4
c0d0203c:	3018      	adds	r0, #24
c0d0203e:	f001 fc47 	bl	c0d038d0 <os_ux>
c0d02042:	61e0      	str	r0, [r4, #28]
c0d02044:	f001 fb72 	bl	c0d0372c <ux_check_status_default>
c0d02048:	69e0      	ldr	r0, [r4, #28]
c0d0204a:	49fe      	ldr	r1, [pc, #1016]	; (c0d02444 <io_event+0x430>)
c0d0204c:	4288      	cmp	r0, r1
c0d0204e:	d100      	bne.n	c0d02052 <io_event+0x3e>
c0d02050:	e267      	b.n	c0d02522 <io_event+0x50e>
c0d02052:	2800      	cmp	r0, #0
c0d02054:	d100      	bne.n	c0d02058 <io_event+0x44>
c0d02056:	e264      	b.n	c0d02522 <io_event+0x50e>
c0d02058:	49f8      	ldr	r1, [pc, #992]	; (c0d0243c <io_event+0x428>)
c0d0205a:	4288      	cmp	r0, r1
c0d0205c:	d000      	beq.n	c0d02060 <io_event+0x4c>
c0d0205e:	e1f5      	b.n	c0d0244c <io_event+0x438>
c0d02060:	f001 f89c 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d02064:	f001 f8a0 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d02068:	60a6      	str	r6, [r4, #8]
c0d0206a:	6820      	ldr	r0, [r4, #0]
c0d0206c:	2800      	cmp	r0, #0
c0d0206e:	d100      	bne.n	c0d02072 <io_event+0x5e>
c0d02070:	e257      	b.n	c0d02522 <io_event+0x50e>
c0d02072:	69e0      	ldr	r0, [r4, #28]
c0d02074:	49f3      	ldr	r1, [pc, #972]	; (c0d02444 <io_event+0x430>)
c0d02076:	4288      	cmp	r0, r1
c0d02078:	d000      	beq.n	c0d0207c <io_event+0x68>
c0d0207a:	e12a      	b.n	c0d022d2 <io_event+0x2be>
c0d0207c:	e251      	b.n	c0d02522 <io_event+0x50e>
c0d0207e:	280d      	cmp	r0, #13
c0d02080:	d06a      	beq.n	c0d02158 <io_event+0x144>
c0d02082:	280e      	cmp	r0, #14
c0d02084:	d000      	beq.n	c0d02088 <io_event+0x74>
c0d02086:	e085      	b.n	c0d02194 <io_event+0x180>
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        #ifdef TARGET_NANOS
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d02088:	4ced      	ldr	r4, [pc, #948]	; (c0d02440 <io_event+0x42c>)
c0d0208a:	7625      	strb	r5, [r4, #24]
c0d0208c:	2500      	movs	r5, #0
c0d0208e:	61e5      	str	r5, [r4, #28]
c0d02090:	4620      	mov	r0, r4
c0d02092:	3018      	adds	r0, #24
c0d02094:	f001 fc1c 	bl	c0d038d0 <os_ux>
c0d02098:	61e0      	str	r0, [r4, #28]
c0d0209a:	f001 fb47 	bl	c0d0372c <ux_check_status_default>
c0d0209e:	69e0      	ldr	r0, [r4, #28]
c0d020a0:	42b0      	cmp	r0, r6
c0d020a2:	d000      	beq.n	c0d020a6 <io_event+0x92>
c0d020a4:	e13b      	b.n	c0d0231e <io_event+0x30a>
c0d020a6:	f001 f879 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d020aa:	f001 f87d 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d020ae:	2000      	movs	r0, #0
c0d020b0:	60a0      	str	r0, [r4, #8]
c0d020b2:	6821      	ldr	r1, [r4, #0]
c0d020b4:	2900      	cmp	r1, #0
c0d020b6:	d100      	bne.n	c0d020ba <io_event+0xa6>
c0d020b8:	e233      	b.n	c0d02522 <io_event+0x50e>
c0d020ba:	69e1      	ldr	r1, [r4, #28]
c0d020bc:	4ae1      	ldr	r2, [pc, #900]	; (c0d02444 <io_event+0x430>)
c0d020be:	4291      	cmp	r1, r2
c0d020c0:	d120      	bne.n	c0d02104 <io_event+0xf0>
c0d020c2:	e22e      	b.n	c0d02522 <io_event+0x50e>
c0d020c4:	6861      	ldr	r1, [r4, #4]
c0d020c6:	4288      	cmp	r0, r1
c0d020c8:	d300      	bcc.n	c0d020cc <io_event+0xb8>
c0d020ca:	e22a      	b.n	c0d02522 <io_event+0x50e>
c0d020cc:	f001 fc70 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d020d0:	2800      	cmp	r0, #0
c0d020d2:	d000      	beq.n	c0d020d6 <io_event+0xc2>
c0d020d4:	e225      	b.n	c0d02522 <io_event+0x50e>
c0d020d6:	68a0      	ldr	r0, [r4, #8]
c0d020d8:	68e1      	ldr	r1, [r4, #12]
c0d020da:	2538      	movs	r5, #56	; 0x38
c0d020dc:	4368      	muls	r0, r5
c0d020de:	6822      	ldr	r2, [r4, #0]
c0d020e0:	1810      	adds	r0, r2, r0
c0d020e2:	2900      	cmp	r1, #0
c0d020e4:	d002      	beq.n	c0d020ec <io_event+0xd8>
c0d020e6:	4788      	blx	r1
c0d020e8:	2800      	cmp	r0, #0
c0d020ea:	d007      	beq.n	c0d020fc <io_event+0xe8>
c0d020ec:	2801      	cmp	r0, #1
c0d020ee:	d103      	bne.n	c0d020f8 <io_event+0xe4>
c0d020f0:	68a0      	ldr	r0, [r4, #8]
c0d020f2:	4345      	muls	r5, r0
c0d020f4:	6820      	ldr	r0, [r4, #0]
c0d020f6:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d020f8:	f001 f9a4 	bl	c0d03444 <io_seproxyhal_display_default>
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        #ifdef TARGET_NANOS
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d020fc:	68a0      	ldr	r0, [r4, #8]
c0d020fe:	1c40      	adds	r0, r0, #1
c0d02100:	60a0      	str	r0, [r4, #8]
c0d02102:	6821      	ldr	r1, [r4, #0]
c0d02104:	2900      	cmp	r1, #0
c0d02106:	d1dd      	bne.n	c0d020c4 <io_event+0xb0>
c0d02108:	e20b      	b.n	c0d02522 <io_event+0x50e>
c0d0210a:	460f      	mov	r7, r1
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0210c:	4ccc      	ldr	r4, [pc, #816]	; (c0d02440 <io_event+0x42c>)
c0d0210e:	7625      	strb	r5, [r4, #24]
c0d02110:	2600      	movs	r6, #0
c0d02112:	61e6      	str	r6, [r4, #28]
c0d02114:	4620      	mov	r0, r4
c0d02116:	3018      	adds	r0, #24
c0d02118:	f001 fbda 	bl	c0d038d0 <os_ux>
c0d0211c:	61e0      	str	r0, [r4, #28]
c0d0211e:	f001 fb05 	bl	c0d0372c <ux_check_status_default>
c0d02122:	69e0      	ldr	r0, [r4, #28]
c0d02124:	49c7      	ldr	r1, [pc, #796]	; (c0d02444 <io_event+0x430>)
c0d02126:	4288      	cmp	r0, r1
c0d02128:	d100      	bne.n	c0d0212c <io_event+0x118>
c0d0212a:	e1fa      	b.n	c0d02522 <io_event+0x50e>
c0d0212c:	2800      	cmp	r0, #0
c0d0212e:	d100      	bne.n	c0d02132 <io_event+0x11e>
c0d02130:	e1f7      	b.n	c0d02522 <io_event+0x50e>
c0d02132:	49c2      	ldr	r1, [pc, #776]	; (c0d0243c <io_event+0x428>)
c0d02134:	4288      	cmp	r0, r1
c0d02136:	d000      	beq.n	c0d0213a <io_event+0x126>
c0d02138:	e1c2      	b.n	c0d024c0 <io_event+0x4ac>
c0d0213a:	f001 f82f 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d0213e:	f001 f833 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d02142:	60a6      	str	r6, [r4, #8]
c0d02144:	6820      	ldr	r0, [r4, #0]
c0d02146:	2800      	cmp	r0, #0
c0d02148:	d100      	bne.n	c0d0214c <io_event+0x138>
c0d0214a:	e1ea      	b.n	c0d02522 <io_event+0x50e>
c0d0214c:	69e0      	ldr	r0, [r4, #28]
c0d0214e:	49bd      	ldr	r1, [pc, #756]	; (c0d02444 <io_event+0x430>)
c0d02150:	4288      	cmp	r0, r1
c0d02152:	d000      	beq.n	c0d02156 <io_event+0x142>
c0d02154:	e0e0      	b.n	c0d02318 <io_event+0x304>
c0d02156:	e1e4      	b.n	c0d02522 <io_event+0x50e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if ((uiState == UI_TEXT) &&
c0d02158:	48bb      	ldr	r0, [pc, #748]	; (c0d02448 <io_event+0x434>)
c0d0215a:	7800      	ldrb	r0, [r0, #0]
c0d0215c:	2801      	cmp	r0, #1
c0d0215e:	d159      	bne.n	c0d02214 <io_event+0x200>
            (os_seph_features() &
c0d02160:	f001 fbe2 	bl	c0d03928 <os_seph_features>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if ((uiState == UI_TEXT) &&
c0d02164:	4238      	tst	r0, r7
c0d02166:	d055      	beq.n	c0d02214 <io_event+0x200>
            (os_seph_features() &
             SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG)) {
            if (!display_text_part()) {
c0d02168:	f000 fa4e 	bl	c0d02608 <display_text_part>
c0d0216c:	2800      	cmp	r0, #0
c0d0216e:	d100      	bne.n	c0d02172 <io_event+0x15e>
c0d02170:	e20e      	b.n	c0d02590 <io_event+0x57c>
                ui_approval();
            } else {
                UX_REDISPLAY();
c0d02172:	f001 f813 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d02176:	f001 f817 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d0217a:	4cb1      	ldr	r4, [pc, #708]	; (c0d02440 <io_event+0x42c>)
c0d0217c:	2000      	movs	r0, #0
c0d0217e:	60a0      	str	r0, [r4, #8]
c0d02180:	6821      	ldr	r1, [r4, #0]
c0d02182:	2900      	cmp	r1, #0
c0d02184:	d100      	bne.n	c0d02188 <io_event+0x174>
c0d02186:	e1cc      	b.n	c0d02522 <io_event+0x50e>
c0d02188:	69e1      	ldr	r1, [r4, #28]
c0d0218a:	4aae      	ldr	r2, [pc, #696]	; (c0d02444 <io_event+0x430>)
c0d0218c:	4291      	cmp	r1, r2
c0d0218e:	d000      	beq.n	c0d02192 <io_event+0x17e>
c0d02190:	e150      	b.n	c0d02434 <io_event+0x420>
c0d02192:	e1c6      	b.n	c0d02522 <io_event+0x50e>
        #endif 
        break;

    // unknown events are acknowledged
    default:
        UX_DEFAULT_EVENT();
c0d02194:	4caa      	ldr	r4, [pc, #680]	; (c0d02440 <io_event+0x42c>)
c0d02196:	7625      	strb	r5, [r4, #24]
c0d02198:	2500      	movs	r5, #0
c0d0219a:	61e5      	str	r5, [r4, #28]
c0d0219c:	4620      	mov	r0, r4
c0d0219e:	3018      	adds	r0, #24
c0d021a0:	f001 fb96 	bl	c0d038d0 <os_ux>
c0d021a4:	61e0      	str	r0, [r4, #28]
c0d021a6:	f001 fac1 	bl	c0d0372c <ux_check_status_default>
c0d021aa:	69e0      	ldr	r0, [r4, #28]
c0d021ac:	42b0      	cmp	r0, r6
c0d021ae:	d000      	beq.n	c0d021b2 <io_event+0x19e>
c0d021b0:	e0f2      	b.n	c0d02398 <io_event+0x384>
c0d021b2:	f000 fff3 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d021b6:	f000 fff7 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d021ba:	60a5      	str	r5, [r4, #8]
c0d021bc:	6820      	ldr	r0, [r4, #0]
c0d021be:	2800      	cmp	r0, #0
c0d021c0:	d100      	bne.n	c0d021c4 <io_event+0x1b0>
c0d021c2:	e1ae      	b.n	c0d02522 <io_event+0x50e>
c0d021c4:	69e0      	ldr	r0, [r4, #28]
c0d021c6:	499f      	ldr	r1, [pc, #636]	; (c0d02444 <io_event+0x430>)
c0d021c8:	4288      	cmp	r0, r1
c0d021ca:	d120      	bne.n	c0d0220e <io_event+0x1fa>
c0d021cc:	e1a9      	b.n	c0d02522 <io_event+0x50e>
c0d021ce:	6860      	ldr	r0, [r4, #4]
c0d021d0:	4285      	cmp	r5, r0
c0d021d2:	d300      	bcc.n	c0d021d6 <io_event+0x1c2>
c0d021d4:	e1a5      	b.n	c0d02522 <io_event+0x50e>
c0d021d6:	f001 fbeb 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d021da:	2800      	cmp	r0, #0
c0d021dc:	d000      	beq.n	c0d021e0 <io_event+0x1cc>
c0d021de:	e1a0      	b.n	c0d02522 <io_event+0x50e>
c0d021e0:	68a0      	ldr	r0, [r4, #8]
c0d021e2:	68e1      	ldr	r1, [r4, #12]
c0d021e4:	2538      	movs	r5, #56	; 0x38
c0d021e6:	4368      	muls	r0, r5
c0d021e8:	6822      	ldr	r2, [r4, #0]
c0d021ea:	1810      	adds	r0, r2, r0
c0d021ec:	2900      	cmp	r1, #0
c0d021ee:	d002      	beq.n	c0d021f6 <io_event+0x1e2>
c0d021f0:	4788      	blx	r1
c0d021f2:	2800      	cmp	r0, #0
c0d021f4:	d007      	beq.n	c0d02206 <io_event+0x1f2>
c0d021f6:	2801      	cmp	r0, #1
c0d021f8:	d103      	bne.n	c0d02202 <io_event+0x1ee>
c0d021fa:	68a0      	ldr	r0, [r4, #8]
c0d021fc:	4345      	muls	r5, r0
c0d021fe:	6820      	ldr	r0, [r4, #0]
c0d02200:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d02202:	f001 f91f 	bl	c0d03444 <io_seproxyhal_display_default>
        #endif 
        break;

    // unknown events are acknowledged
    default:
        UX_DEFAULT_EVENT();
c0d02206:	68a0      	ldr	r0, [r4, #8]
c0d02208:	1c45      	adds	r5, r0, #1
c0d0220a:	60a5      	str	r5, [r4, #8]
c0d0220c:	6820      	ldr	r0, [r4, #0]
c0d0220e:	2800      	cmp	r0, #0
c0d02210:	d1dd      	bne.n	c0d021ce <io_event+0x1ba>
c0d02212:	e186      	b.n	c0d02522 <io_event+0x50e>
                ui_approval();
            } else {
                UX_REDISPLAY();
            }
        } else {
            UX_DISPLAYED_EVENT();
c0d02214:	4cfa      	ldr	r4, [pc, #1000]	; (c0d02600 <io_event+0x5ec>)
c0d02216:	7625      	strb	r5, [r4, #24]
c0d02218:	2500      	movs	r5, #0
c0d0221a:	61e5      	str	r5, [r4, #28]
c0d0221c:	4620      	mov	r0, r4
c0d0221e:	3018      	adds	r0, #24
c0d02220:	f001 fb56 	bl	c0d038d0 <os_ux>
c0d02224:	61e0      	str	r0, [r4, #28]
c0d02226:	f001 fa81 	bl	c0d0372c <ux_check_status_default>
c0d0222a:	69e0      	ldr	r0, [r4, #28]
c0d0222c:	49f5      	ldr	r1, [pc, #980]	; (c0d02604 <io_event+0x5f0>)
c0d0222e:	4288      	cmp	r0, r1
c0d02230:	d100      	bne.n	c0d02234 <io_event+0x220>
c0d02232:	e176      	b.n	c0d02522 <io_event+0x50e>
c0d02234:	49f1      	ldr	r1, [pc, #964]	; (c0d025fc <io_event+0x5e8>)
c0d02236:	4288      	cmp	r0, r1
c0d02238:	d100      	bne.n	c0d0223c <io_event+0x228>
c0d0223a:	e17b      	b.n	c0d02534 <io_event+0x520>
c0d0223c:	2800      	cmp	r0, #0
c0d0223e:	d100      	bne.n	c0d02242 <io_event+0x22e>
c0d02240:	e16f      	b.n	c0d02522 <io_event+0x50e>
c0d02242:	6820      	ldr	r0, [r4, #0]
c0d02244:	2800      	cmp	r0, #0
c0d02246:	d100      	bne.n	c0d0224a <io_event+0x236>
c0d02248:	e165      	b.n	c0d02516 <io_event+0x502>
c0d0224a:	68a0      	ldr	r0, [r4, #8]
c0d0224c:	6861      	ldr	r1, [r4, #4]
c0d0224e:	4288      	cmp	r0, r1
c0d02250:	d300      	bcc.n	c0d02254 <io_event+0x240>
c0d02252:	e160      	b.n	c0d02516 <io_event+0x502>
c0d02254:	f001 fbac 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d02258:	2800      	cmp	r0, #0
c0d0225a:	d000      	beq.n	c0d0225e <io_event+0x24a>
c0d0225c:	e15b      	b.n	c0d02516 <io_event+0x502>
c0d0225e:	68a0      	ldr	r0, [r4, #8]
c0d02260:	68e1      	ldr	r1, [r4, #12]
c0d02262:	2538      	movs	r5, #56	; 0x38
c0d02264:	4368      	muls	r0, r5
c0d02266:	6822      	ldr	r2, [r4, #0]
c0d02268:	1810      	adds	r0, r2, r0
c0d0226a:	2900      	cmp	r1, #0
c0d0226c:	d002      	beq.n	c0d02274 <io_event+0x260>
c0d0226e:	4788      	blx	r1
c0d02270:	2800      	cmp	r0, #0
c0d02272:	d007      	beq.n	c0d02284 <io_event+0x270>
c0d02274:	2801      	cmp	r0, #1
c0d02276:	d103      	bne.n	c0d02280 <io_event+0x26c>
c0d02278:	68a0      	ldr	r0, [r4, #8]
c0d0227a:	4345      	muls	r5, r0
c0d0227c:	6820      	ldr	r0, [r4, #0]
c0d0227e:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d02280:	f001 f8e0 	bl	c0d03444 <io_seproxyhal_display_default>
                ui_approval();
            } else {
                UX_REDISPLAY();
            }
        } else {
            UX_DISPLAYED_EVENT();
c0d02284:	68a0      	ldr	r0, [r4, #8]
c0d02286:	1c40      	adds	r0, r0, #1
c0d02288:	60a0      	str	r0, [r4, #8]
c0d0228a:	6821      	ldr	r1, [r4, #0]
c0d0228c:	2900      	cmp	r1, #0
c0d0228e:	d1dd      	bne.n	c0d0224c <io_event+0x238>
c0d02290:	e141      	b.n	c0d02516 <io_event+0x502>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d02292:	6860      	ldr	r0, [r4, #4]
c0d02294:	4286      	cmp	r6, r0
c0d02296:	d300      	bcc.n	c0d0229a <io_event+0x286>
c0d02298:	e143      	b.n	c0d02522 <io_event+0x50e>
c0d0229a:	f001 fb89 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d0229e:	2800      	cmp	r0, #0
c0d022a0:	d000      	beq.n	c0d022a4 <io_event+0x290>
c0d022a2:	e13e      	b.n	c0d02522 <io_event+0x50e>
c0d022a4:	68a0      	ldr	r0, [r4, #8]
c0d022a6:	68e1      	ldr	r1, [r4, #12]
c0d022a8:	2538      	movs	r5, #56	; 0x38
c0d022aa:	4368      	muls	r0, r5
c0d022ac:	6822      	ldr	r2, [r4, #0]
c0d022ae:	1810      	adds	r0, r2, r0
c0d022b0:	2900      	cmp	r1, #0
c0d022b2:	d002      	beq.n	c0d022ba <io_event+0x2a6>
c0d022b4:	4788      	blx	r1
c0d022b6:	2800      	cmp	r0, #0
c0d022b8:	d007      	beq.n	c0d022ca <io_event+0x2b6>
c0d022ba:	2801      	cmp	r0, #1
c0d022bc:	d103      	bne.n	c0d022c6 <io_event+0x2b2>
c0d022be:	68a0      	ldr	r0, [r4, #8]
c0d022c0:	4345      	muls	r5, r0
c0d022c2:	6820      	ldr	r0, [r4, #0]
c0d022c4:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d022c6:	f001 f8bd 	bl	c0d03444 <io_seproxyhal_display_default>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d022ca:	68a0      	ldr	r0, [r4, #8]
c0d022cc:	1c46      	adds	r6, r0, #1
c0d022ce:	60a6      	str	r6, [r4, #8]
c0d022d0:	6820      	ldr	r0, [r4, #0]
c0d022d2:	2800      	cmp	r0, #0
c0d022d4:	d1dd      	bne.n	c0d02292 <io_event+0x27e>
c0d022d6:	e124      	b.n	c0d02522 <io_event+0x50e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d022d8:	6860      	ldr	r0, [r4, #4]
c0d022da:	4286      	cmp	r6, r0
c0d022dc:	d300      	bcc.n	c0d022e0 <io_event+0x2cc>
c0d022de:	e120      	b.n	c0d02522 <io_event+0x50e>
c0d022e0:	f001 fb66 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d022e4:	2800      	cmp	r0, #0
c0d022e6:	d000      	beq.n	c0d022ea <io_event+0x2d6>
c0d022e8:	e11b      	b.n	c0d02522 <io_event+0x50e>
c0d022ea:	68a0      	ldr	r0, [r4, #8]
c0d022ec:	68e1      	ldr	r1, [r4, #12]
c0d022ee:	2538      	movs	r5, #56	; 0x38
c0d022f0:	4368      	muls	r0, r5
c0d022f2:	6822      	ldr	r2, [r4, #0]
c0d022f4:	1810      	adds	r0, r2, r0
c0d022f6:	2900      	cmp	r1, #0
c0d022f8:	d002      	beq.n	c0d02300 <io_event+0x2ec>
c0d022fa:	4788      	blx	r1
c0d022fc:	2800      	cmp	r0, #0
c0d022fe:	d007      	beq.n	c0d02310 <io_event+0x2fc>
c0d02300:	2801      	cmp	r0, #1
c0d02302:	d103      	bne.n	c0d0230c <io_event+0x2f8>
c0d02304:	68a0      	ldr	r0, [r4, #8]
c0d02306:	4345      	muls	r5, r0
c0d02308:	6820      	ldr	r0, [r4, #0]
c0d0230a:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0230c:	f001 f89a 	bl	c0d03444 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d02310:	68a0      	ldr	r0, [r4, #8]
c0d02312:	1c46      	adds	r6, r0, #1
c0d02314:	60a6      	str	r6, [r4, #8]
c0d02316:	6820      	ldr	r0, [r4, #0]
c0d02318:	2800      	cmp	r0, #0
c0d0231a:	d1dd      	bne.n	c0d022d8 <io_event+0x2c4>
c0d0231c:	e101      	b.n	c0d02522 <io_event+0x50e>
c0d0231e:	4606      	mov	r6, r0
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        #ifdef TARGET_NANOS
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d02320:	6960      	ldr	r0, [r4, #20]
c0d02322:	2800      	cmp	r0, #0
c0d02324:	d008      	beq.n	c0d02338 <io_event+0x324>
c0d02326:	2164      	movs	r1, #100	; 0x64
c0d02328:	2864      	cmp	r0, #100	; 0x64
c0d0232a:	4602      	mov	r2, r0
c0d0232c:	d300      	bcc.n	c0d02330 <io_event+0x31c>
c0d0232e:	460a      	mov	r2, r1
c0d02330:	1a80      	subs	r0, r0, r2
c0d02332:	6160      	str	r0, [r4, #20]
c0d02334:	d100      	bne.n	c0d02338 <io_event+0x324>
c0d02336:	e12e      	b.n	c0d02596 <io_event+0x582>
c0d02338:	48b2      	ldr	r0, [pc, #712]	; (c0d02604 <io_event+0x5f0>)
c0d0233a:	4286      	cmp	r6, r0
c0d0233c:	4630      	mov	r0, r6
c0d0233e:	d100      	bne.n	c0d02342 <io_event+0x32e>
c0d02340:	e0ef      	b.n	c0d02522 <io_event+0x50e>
c0d02342:	2800      	cmp	r0, #0
c0d02344:	d100      	bne.n	c0d02348 <io_event+0x334>
c0d02346:	e0ec      	b.n	c0d02522 <io_event+0x50e>
c0d02348:	6820      	ldr	r0, [r4, #0]
c0d0234a:	2800      	cmp	r0, #0
c0d0234c:	d100      	bne.n	c0d02350 <io_event+0x33c>
c0d0234e:	e0e2      	b.n	c0d02516 <io_event+0x502>
c0d02350:	68a0      	ldr	r0, [r4, #8]
c0d02352:	6861      	ldr	r1, [r4, #4]
c0d02354:	4288      	cmp	r0, r1
c0d02356:	d300      	bcc.n	c0d0235a <io_event+0x346>
c0d02358:	e0dd      	b.n	c0d02516 <io_event+0x502>
c0d0235a:	f001 fb29 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d0235e:	2800      	cmp	r0, #0
c0d02360:	d000      	beq.n	c0d02364 <io_event+0x350>
c0d02362:	e0d8      	b.n	c0d02516 <io_event+0x502>
c0d02364:	68a0      	ldr	r0, [r4, #8]
c0d02366:	68e1      	ldr	r1, [r4, #12]
c0d02368:	2538      	movs	r5, #56	; 0x38
c0d0236a:	4368      	muls	r0, r5
c0d0236c:	6822      	ldr	r2, [r4, #0]
c0d0236e:	1810      	adds	r0, r2, r0
c0d02370:	2900      	cmp	r1, #0
c0d02372:	d002      	beq.n	c0d0237a <io_event+0x366>
c0d02374:	4788      	blx	r1
c0d02376:	2800      	cmp	r0, #0
c0d02378:	d007      	beq.n	c0d0238a <io_event+0x376>
c0d0237a:	2801      	cmp	r0, #1
c0d0237c:	d103      	bne.n	c0d02386 <io_event+0x372>
c0d0237e:	68a0      	ldr	r0, [r4, #8]
c0d02380:	4345      	muls	r5, r0
c0d02382:	6820      	ldr	r0, [r4, #0]
c0d02384:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d02386:	f001 f85d 	bl	c0d03444 <io_seproxyhal_display_default>
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        #ifdef TARGET_NANOS
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d0238a:	68a0      	ldr	r0, [r4, #8]
c0d0238c:	1c40      	adds	r0, r0, #1
c0d0238e:	60a0      	str	r0, [r4, #8]
c0d02390:	6821      	ldr	r1, [r4, #0]
c0d02392:	2900      	cmp	r1, #0
c0d02394:	d1dd      	bne.n	c0d02352 <io_event+0x33e>
c0d02396:	e0be      	b.n	c0d02516 <io_event+0x502>
        #endif 
        break;

    // unknown events are acknowledged
    default:
        UX_DEFAULT_EVENT();
c0d02398:	6820      	ldr	r0, [r4, #0]
c0d0239a:	2800      	cmp	r0, #0
c0d0239c:	d100      	bne.n	c0d023a0 <io_event+0x38c>
c0d0239e:	e0ba      	b.n	c0d02516 <io_event+0x502>
c0d023a0:	68a0      	ldr	r0, [r4, #8]
c0d023a2:	6861      	ldr	r1, [r4, #4]
c0d023a4:	4288      	cmp	r0, r1
c0d023a6:	d300      	bcc.n	c0d023aa <io_event+0x396>
c0d023a8:	e0b5      	b.n	c0d02516 <io_event+0x502>
c0d023aa:	f001 fb01 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d023ae:	2800      	cmp	r0, #0
c0d023b0:	d000      	beq.n	c0d023b4 <io_event+0x3a0>
c0d023b2:	e0b0      	b.n	c0d02516 <io_event+0x502>
c0d023b4:	68a0      	ldr	r0, [r4, #8]
c0d023b6:	68e1      	ldr	r1, [r4, #12]
c0d023b8:	2538      	movs	r5, #56	; 0x38
c0d023ba:	4368      	muls	r0, r5
c0d023bc:	6822      	ldr	r2, [r4, #0]
c0d023be:	1810      	adds	r0, r2, r0
c0d023c0:	2900      	cmp	r1, #0
c0d023c2:	d002      	beq.n	c0d023ca <io_event+0x3b6>
c0d023c4:	4788      	blx	r1
c0d023c6:	2800      	cmp	r0, #0
c0d023c8:	d007      	beq.n	c0d023da <io_event+0x3c6>
c0d023ca:	2801      	cmp	r0, #1
c0d023cc:	d103      	bne.n	c0d023d6 <io_event+0x3c2>
c0d023ce:	68a0      	ldr	r0, [r4, #8]
c0d023d0:	4345      	muls	r5, r0
c0d023d2:	6820      	ldr	r0, [r4, #0]
c0d023d4:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d023d6:	f001 f835 	bl	c0d03444 <io_seproxyhal_display_default>
        #endif 
        break;

    // unknown events are acknowledged
    default:
        UX_DEFAULT_EVENT();
c0d023da:	68a0      	ldr	r0, [r4, #8]
c0d023dc:	1c40      	adds	r0, r0, #1
c0d023de:	60a0      	str	r0, [r4, #8]
c0d023e0:	6821      	ldr	r1, [r4, #0]
c0d023e2:	2900      	cmp	r1, #0
c0d023e4:	d1dd      	bne.n	c0d023a2 <io_event+0x38e>
c0d023e6:	e096      	b.n	c0d02516 <io_event+0x502>
c0d023e8:	20001800 	.word	0x20001800
c0d023ec:	b0105055 	.word	0xb0105055
c0d023f0:	20001880 	.word	0x20001880
            (os_seph_features() &
             SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG)) {
            if (!display_text_part()) {
                ui_approval();
            } else {
                UX_REDISPLAY();
c0d023f4:	6861      	ldr	r1, [r4, #4]
c0d023f6:	4288      	cmp	r0, r1
c0d023f8:	d300      	bcc.n	c0d023fc <io_event+0x3e8>
c0d023fa:	e092      	b.n	c0d02522 <io_event+0x50e>
c0d023fc:	f001 fad8 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d02400:	2800      	cmp	r0, #0
c0d02402:	d000      	beq.n	c0d02406 <io_event+0x3f2>
c0d02404:	e08d      	b.n	c0d02522 <io_event+0x50e>
c0d02406:	68a0      	ldr	r0, [r4, #8]
c0d02408:	68e1      	ldr	r1, [r4, #12]
c0d0240a:	2538      	movs	r5, #56	; 0x38
c0d0240c:	4368      	muls	r0, r5
c0d0240e:	6822      	ldr	r2, [r4, #0]
c0d02410:	1810      	adds	r0, r2, r0
c0d02412:	2900      	cmp	r1, #0
c0d02414:	d002      	beq.n	c0d0241c <io_event+0x408>
c0d02416:	4788      	blx	r1
c0d02418:	2800      	cmp	r0, #0
c0d0241a:	d007      	beq.n	c0d0242c <io_event+0x418>
c0d0241c:	2801      	cmp	r0, #1
c0d0241e:	d103      	bne.n	c0d02428 <io_event+0x414>
c0d02420:	68a0      	ldr	r0, [r4, #8]
c0d02422:	4345      	muls	r5, r0
c0d02424:	6820      	ldr	r0, [r4, #0]
c0d02426:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d02428:	f001 f80c 	bl	c0d03444 <io_seproxyhal_display_default>
            (os_seph_features() &
             SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG)) {
            if (!display_text_part()) {
                ui_approval();
            } else {
                UX_REDISPLAY();
c0d0242c:	68a0      	ldr	r0, [r4, #8]
c0d0242e:	1c40      	adds	r0, r0, #1
c0d02430:	60a0      	str	r0, [r4, #8]
c0d02432:	6821      	ldr	r1, [r4, #0]
c0d02434:	2900      	cmp	r1, #0
c0d02436:	d1dd      	bne.n	c0d023f4 <io_event+0x3e0>
c0d02438:	e073      	b.n	c0d02522 <io_event+0x50e>
c0d0243a:	46c0      	nop			; (mov r8, r8)
c0d0243c:	b0105055 	.word	0xb0105055
c0d02440:	20001880 	.word	0x20001880
c0d02444:	b0105044 	.word	0xb0105044
c0d02448:	20001930 	.word	0x20001930
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d0244c:	88a0      	ldrh	r0, [r4, #4]
c0d0244e:	9004      	str	r0, [sp, #16]
c0d02450:	6820      	ldr	r0, [r4, #0]
c0d02452:	9003      	str	r0, [sp, #12]
c0d02454:	79fd      	ldrb	r5, [r7, #7]
c0d02456:	79bb      	ldrb	r3, [r7, #6]
c0d02458:	797e      	ldrb	r6, [r7, #5]
c0d0245a:	793a      	ldrb	r2, [r7, #4]
c0d0245c:	78ff      	ldrb	r7, [r7, #3]
c0d0245e:	68e1      	ldr	r1, [r4, #12]
c0d02460:	4668      	mov	r0, sp
c0d02462:	6007      	str	r7, [r0, #0]
c0d02464:	6041      	str	r1, [r0, #4]
c0d02466:	0212      	lsls	r2, r2, #8
c0d02468:	4332      	orrs	r2, r6
c0d0246a:	021b      	lsls	r3, r3, #8
c0d0246c:	432b      	orrs	r3, r5
c0d0246e:	9803      	ldr	r0, [sp, #12]
c0d02470:	9904      	ldr	r1, [sp, #16]
c0d02472:	f000 ff19 	bl	c0d032a8 <io_seproxyhal_touch_element_callback>
c0d02476:	6820      	ldr	r0, [r4, #0]
c0d02478:	2800      	cmp	r0, #0
c0d0247a:	d04c      	beq.n	c0d02516 <io_event+0x502>
c0d0247c:	68a0      	ldr	r0, [r4, #8]
c0d0247e:	6861      	ldr	r1, [r4, #4]
c0d02480:	4288      	cmp	r0, r1
c0d02482:	d248      	bcs.n	c0d02516 <io_event+0x502>
c0d02484:	f001 fa94 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d02488:	2800      	cmp	r0, #0
c0d0248a:	d144      	bne.n	c0d02516 <io_event+0x502>
c0d0248c:	68a0      	ldr	r0, [r4, #8]
c0d0248e:	68e1      	ldr	r1, [r4, #12]
c0d02490:	2538      	movs	r5, #56	; 0x38
c0d02492:	4368      	muls	r0, r5
c0d02494:	6822      	ldr	r2, [r4, #0]
c0d02496:	1810      	adds	r0, r2, r0
c0d02498:	2900      	cmp	r1, #0
c0d0249a:	d002      	beq.n	c0d024a2 <io_event+0x48e>
c0d0249c:	4788      	blx	r1
c0d0249e:	2800      	cmp	r0, #0
c0d024a0:	d007      	beq.n	c0d024b2 <io_event+0x49e>
c0d024a2:	2801      	cmp	r0, #1
c0d024a4:	d103      	bne.n	c0d024ae <io_event+0x49a>
c0d024a6:	68a0      	ldr	r0, [r4, #8]
c0d024a8:	4345      	muls	r5, r0
c0d024aa:	6820      	ldr	r0, [r4, #0]
c0d024ac:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d024ae:	f000 ffc9 	bl	c0d03444 <io_seproxyhal_display_default>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d024b2:	68a0      	ldr	r0, [r4, #8]
c0d024b4:	1c40      	adds	r0, r0, #1
c0d024b6:	60a0      	str	r0, [r4, #8]
c0d024b8:	6821      	ldr	r1, [r4, #0]
c0d024ba:	2900      	cmp	r1, #0
c0d024bc:	d1df      	bne.n	c0d0247e <io_event+0x46a>
c0d024be:	e02a      	b.n	c0d02516 <io_event+0x502>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d024c0:	6920      	ldr	r0, [r4, #16]
c0d024c2:	2800      	cmp	r0, #0
c0d024c4:	d003      	beq.n	c0d024ce <io_event+0x4ba>
c0d024c6:	78f9      	ldrb	r1, [r7, #3]
c0d024c8:	0849      	lsrs	r1, r1, #1
c0d024ca:	f000 fffd 	bl	c0d034c8 <io_seproxyhal_button_push>
c0d024ce:	6820      	ldr	r0, [r4, #0]
c0d024d0:	2800      	cmp	r0, #0
c0d024d2:	d020      	beq.n	c0d02516 <io_event+0x502>
c0d024d4:	68a0      	ldr	r0, [r4, #8]
c0d024d6:	6861      	ldr	r1, [r4, #4]
c0d024d8:	4288      	cmp	r0, r1
c0d024da:	d21c      	bcs.n	c0d02516 <io_event+0x502>
c0d024dc:	f001 fa68 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d024e0:	2800      	cmp	r0, #0
c0d024e2:	d118      	bne.n	c0d02516 <io_event+0x502>
c0d024e4:	68a0      	ldr	r0, [r4, #8]
c0d024e6:	68e1      	ldr	r1, [r4, #12]
c0d024e8:	2538      	movs	r5, #56	; 0x38
c0d024ea:	4368      	muls	r0, r5
c0d024ec:	6822      	ldr	r2, [r4, #0]
c0d024ee:	1810      	adds	r0, r2, r0
c0d024f0:	2900      	cmp	r1, #0
c0d024f2:	d002      	beq.n	c0d024fa <io_event+0x4e6>
c0d024f4:	4788      	blx	r1
c0d024f6:	2800      	cmp	r0, #0
c0d024f8:	d007      	beq.n	c0d0250a <io_event+0x4f6>
c0d024fa:	2801      	cmp	r0, #1
c0d024fc:	d103      	bne.n	c0d02506 <io_event+0x4f2>
c0d024fe:	68a0      	ldr	r0, [r4, #8]
c0d02500:	4345      	muls	r5, r0
c0d02502:	6820      	ldr	r0, [r4, #0]
c0d02504:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d02506:	f000 ff9d 	bl	c0d03444 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0250a:	68a0      	ldr	r0, [r4, #8]
c0d0250c:	1c40      	adds	r0, r0, #1
c0d0250e:	60a0      	str	r0, [r4, #8]
c0d02510:	6821      	ldr	r1, [r4, #0]
c0d02512:	2900      	cmp	r1, #0
c0d02514:	d1df      	bne.n	c0d024d6 <io_event+0x4c2>
c0d02516:	6860      	ldr	r0, [r4, #4]
c0d02518:	68a1      	ldr	r1, [r4, #8]
c0d0251a:	4281      	cmp	r1, r0
c0d0251c:	d301      	bcc.n	c0d02522 <io_event+0x50e>
c0d0251e:	f001 fa47 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
        UX_DEFAULT_EVENT();
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d02522:	f001 fa45 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d02526:	2800      	cmp	r0, #0
c0d02528:	d101      	bne.n	c0d0252e <io_event+0x51a>
        io_seproxyhal_general_status();
c0d0252a:	f000 fced 	bl	c0d02f08 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d0252e:	2001      	movs	r0, #1
c0d02530:	b005      	add	sp, #20
c0d02532:	bdf0      	pop	{r4, r5, r6, r7, pc}
                ui_approval();
            } else {
                UX_REDISPLAY();
            }
        } else {
            UX_DISPLAYED_EVENT();
c0d02534:	f000 fe32 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d02538:	f000 fe36 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d0253c:	60a5      	str	r5, [r4, #8]
c0d0253e:	6820      	ldr	r0, [r4, #0]
c0d02540:	2800      	cmp	r0, #0
c0d02542:	d0ee      	beq.n	c0d02522 <io_event+0x50e>
c0d02544:	69e0      	ldr	r0, [r4, #28]
c0d02546:	492f      	ldr	r1, [pc, #188]	; (c0d02604 <io_event+0x5f0>)
c0d02548:	4288      	cmp	r0, r1
c0d0254a:	d11e      	bne.n	c0d0258a <io_event+0x576>
c0d0254c:	e7e9      	b.n	c0d02522 <io_event+0x50e>
c0d0254e:	6860      	ldr	r0, [r4, #4]
c0d02550:	4285      	cmp	r5, r0
c0d02552:	d2e6      	bcs.n	c0d02522 <io_event+0x50e>
c0d02554:	f001 fa2c 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d02558:	2800      	cmp	r0, #0
c0d0255a:	d1e2      	bne.n	c0d02522 <io_event+0x50e>
c0d0255c:	68a0      	ldr	r0, [r4, #8]
c0d0255e:	68e1      	ldr	r1, [r4, #12]
c0d02560:	2538      	movs	r5, #56	; 0x38
c0d02562:	4368      	muls	r0, r5
c0d02564:	6822      	ldr	r2, [r4, #0]
c0d02566:	1810      	adds	r0, r2, r0
c0d02568:	2900      	cmp	r1, #0
c0d0256a:	d002      	beq.n	c0d02572 <io_event+0x55e>
c0d0256c:	4788      	blx	r1
c0d0256e:	2800      	cmp	r0, #0
c0d02570:	d007      	beq.n	c0d02582 <io_event+0x56e>
c0d02572:	2801      	cmp	r0, #1
c0d02574:	d103      	bne.n	c0d0257e <io_event+0x56a>
c0d02576:	68a0      	ldr	r0, [r4, #8]
c0d02578:	4345      	muls	r5, r0
c0d0257a:	6820      	ldr	r0, [r4, #0]
c0d0257c:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0257e:	f000 ff61 	bl	c0d03444 <io_seproxyhal_display_default>
                ui_approval();
            } else {
                UX_REDISPLAY();
            }
        } else {
            UX_DISPLAYED_EVENT();
c0d02582:	68a0      	ldr	r0, [r4, #8]
c0d02584:	1c45      	adds	r5, r0, #1
c0d02586:	60a5      	str	r5, [r4, #8]
c0d02588:	6820      	ldr	r0, [r4, #0]
c0d0258a:	2800      	cmp	r0, #0
c0d0258c:	d1df      	bne.n	c0d0254e <io_event+0x53a>
c0d0258e:	e7c8      	b.n	c0d02522 <io_event+0x50e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if ((uiState == UI_TEXT) &&
            (os_seph_features() &
             SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG)) {
            if (!display_text_part()) {
                ui_approval();
c0d02590:	f000 f862 	bl	c0d02658 <ui_approval>
c0d02594:	e7c5      	b.n	c0d02522 <io_event+0x50e>
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        #ifdef TARGET_NANOS
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d02596:	37f4      	adds	r7, #244	; 0xf4
c0d02598:	6167      	str	r7, [r4, #20]
c0d0259a:	f000 fdff 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d0259e:	f000 fe03 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d025a2:	60a5      	str	r5, [r4, #8]
c0d025a4:	6820      	ldr	r0, [r4, #0]
c0d025a6:	2800      	cmp	r0, #0
c0d025a8:	d100      	bne.n	c0d025ac <io_event+0x598>
c0d025aa:	e6c5      	b.n	c0d02338 <io_event+0x324>
c0d025ac:	69e0      	ldr	r0, [r4, #28]
c0d025ae:	4915      	ldr	r1, [pc, #84]	; (c0d02604 <io_event+0x5f0>)
c0d025b0:	4288      	cmp	r0, r1
c0d025b2:	d120      	bne.n	c0d025f6 <io_event+0x5e2>
c0d025b4:	e6c0      	b.n	c0d02338 <io_event+0x324>
c0d025b6:	6860      	ldr	r0, [r4, #4]
c0d025b8:	4285      	cmp	r5, r0
c0d025ba:	d300      	bcc.n	c0d025be <io_event+0x5aa>
c0d025bc:	e6bc      	b.n	c0d02338 <io_event+0x324>
c0d025be:	f001 f9f7 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d025c2:	2800      	cmp	r0, #0
c0d025c4:	d000      	beq.n	c0d025c8 <io_event+0x5b4>
c0d025c6:	e6b7      	b.n	c0d02338 <io_event+0x324>
c0d025c8:	68a0      	ldr	r0, [r4, #8]
c0d025ca:	68e1      	ldr	r1, [r4, #12]
c0d025cc:	2538      	movs	r5, #56	; 0x38
c0d025ce:	4368      	muls	r0, r5
c0d025d0:	6822      	ldr	r2, [r4, #0]
c0d025d2:	1810      	adds	r0, r2, r0
c0d025d4:	2900      	cmp	r1, #0
c0d025d6:	d002      	beq.n	c0d025de <io_event+0x5ca>
c0d025d8:	4788      	blx	r1
c0d025da:	2800      	cmp	r0, #0
c0d025dc:	d007      	beq.n	c0d025ee <io_event+0x5da>
c0d025de:	2801      	cmp	r0, #1
c0d025e0:	d103      	bne.n	c0d025ea <io_event+0x5d6>
c0d025e2:	68a0      	ldr	r0, [r4, #8]
c0d025e4:	4345      	muls	r5, r0
c0d025e6:	6820      	ldr	r0, [r4, #0]
c0d025e8:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d025ea:	f000 ff2b 	bl	c0d03444 <io_seproxyhal_display_default>
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        #ifdef TARGET_NANOS
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d025ee:	68a0      	ldr	r0, [r4, #8]
c0d025f0:	1c45      	adds	r5, r0, #1
c0d025f2:	60a5      	str	r5, [r4, #8]
c0d025f4:	6820      	ldr	r0, [r4, #0]
c0d025f6:	2800      	cmp	r0, #0
c0d025f8:	d1dd      	bne.n	c0d025b6 <io_event+0x5a2>
c0d025fa:	e69d      	b.n	c0d02338 <io_event+0x324>
c0d025fc:	b0105055 	.word	0xb0105055
c0d02600:	20001880 	.word	0x20001880
c0d02604:	b0105044 	.word	0xb0105044

c0d02608 <display_text_part>:
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
}

// Pick the text elements to display
static unsigned char display_text_part() {
c0d02608:	b5f0      	push	{r4, r5, r6, r7, lr}
    unsigned int i;
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[current_text_pos] == '\0') {
c0d0260a:	4910      	ldr	r1, [pc, #64]	; (c0d0264c <display_text_part+0x44>)
c0d0260c:	680a      	ldr	r2, [r1, #0]
c0d0260e:	4810      	ldr	r0, [pc, #64]	; (c0d02650 <display_text_part+0x48>)
c0d02610:	1884      	adds	r4, r0, r2
c0d02612:	7963      	ldrb	r3, [r4, #5]
c0d02614:	2000      	movs	r0, #0
c0d02616:	2b00      	cmp	r3, #0
c0d02618:	d017      	beq.n	c0d0264a <display_text_part+0x42>
    io_seproxyhal_display_default((bagl_element_t *)element);
}

// Pick the text elements to display
static unsigned char display_text_part() {
    unsigned int i;
c0d0261a:	1da5      	adds	r5, r4, #6
c0d0261c:	1c56      	adds	r6, r2, #1
c0d0261e:	2000      	movs	r0, #0
c0d02620:	4c0c      	ldr	r4, [pc, #48]	; (c0d02654 <display_text_part+0x4c>)
c0d02622:	e004      	b.n	c0d0262e <display_text_part+0x26>
        return 0;
    }
    i = 0;
    while ((text[current_text_pos] != 0) && (text[current_text_pos] != '\n') &&
           (i < MAX_CHARS_PER_LINE)) {
        lineBuffer[i++] = text[current_text_pos];
c0d02624:	5423      	strb	r3, [r4, r0]
        current_text_pos++;
c0d02626:	1833      	adds	r3, r6, r0
c0d02628:	600b      	str	r3, [r1, #0]
c0d0262a:	5c2b      	ldrb	r3, [r5, r0]
        return 0;
    }
    i = 0;
    while ((text[current_text_pos] != 0) && (text[current_text_pos] != '\n') &&
           (i < MAX_CHARS_PER_LINE)) {
        lineBuffer[i++] = text[current_text_pos];
c0d0262c:	1c40      	adds	r0, r0, #1
c0d0262e:	b2df      	uxtb	r7, r3
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[current_text_pos] == '\0') {
        return 0;
    }
    i = 0;
    while ((text[current_text_pos] != 0) && (text[current_text_pos] != '\n') &&
c0d02630:	2f00      	cmp	r7, #0
c0d02632:	d007      	beq.n	c0d02644 <display_text_part+0x3c>
c0d02634:	2f0a      	cmp	r7, #10
c0d02636:	d002      	beq.n	c0d0263e <display_text_part+0x36>
c0d02638:	2830      	cmp	r0, #48	; 0x30
c0d0263a:	d9f3      	bls.n	c0d02624 <display_text_part+0x1c>
c0d0263c:	e002      	b.n	c0d02644 <display_text_part+0x3c>
           (i < MAX_CHARS_PER_LINE)) {
        lineBuffer[i++] = text[current_text_pos];
        current_text_pos++;
    }
    if (text[current_text_pos] == '\n') {
        current_text_pos++;
c0d0263e:	1812      	adds	r2, r2, r0
c0d02640:	1c52      	adds	r2, r2, #1
c0d02642:	600a      	str	r2, [r1, #0]
    }
    lineBuffer[i] = '\0';
c0d02644:	2100      	movs	r1, #0
c0d02646:	5421      	strb	r1, [r4, r0]
c0d02648:	2001      	movs	r0, #1
    bagl_ui_text[0].component.font_id = DEFAULT_FONT;
    bagl_ui_text[0].text = lineBuffer;
    text_y += TEXT_HEIGHT + TEXT_SPACE;
#endif
    return 1;
}
c0d0264a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0264c:	20001934 	.word	0x20001934
c0d02650:	20001a44 	.word	0x20001a44
c0d02654:	20001999 	.word	0x20001999

c0d02658 <ui_approval>:
#else
    UX_DISPLAY(bagl_ui_text_review_nanos, NULL);
#endif
}

static void ui_approval(void) {
c0d02658:	b5b0      	push	{r4, r5, r7, lr}
    uiState = UI_APPROVAL;
c0d0265a:	4823      	ldr	r0, [pc, #140]	; (c0d026e8 <ui_approval+0x90>)
c0d0265c:	2102      	movs	r1, #2
c0d0265e:	7001      	strb	r1, [r0, #0]
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_approval_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_approval_nanos, NULL);
c0d02660:	4c22      	ldr	r4, [pc, #136]	; (c0d026ec <ui_approval+0x94>)
c0d02662:	4824      	ldr	r0, [pc, #144]	; (c0d026f4 <ui_approval+0x9c>)
c0d02664:	4478      	add	r0, pc
c0d02666:	6020      	str	r0, [r4, #0]
c0d02668:	2004      	movs	r0, #4
c0d0266a:	6060      	str	r0, [r4, #4]
c0d0266c:	4822      	ldr	r0, [pc, #136]	; (c0d026f8 <ui_approval+0xa0>)
c0d0266e:	4478      	add	r0, pc
c0d02670:	6120      	str	r0, [r4, #16]
c0d02672:	2500      	movs	r5, #0
c0d02674:	60e5      	str	r5, [r4, #12]
c0d02676:	2003      	movs	r0, #3
c0d02678:	7620      	strb	r0, [r4, #24]
c0d0267a:	61e5      	str	r5, [r4, #28]
c0d0267c:	4620      	mov	r0, r4
c0d0267e:	3018      	adds	r0, #24
c0d02680:	f001 f926 	bl	c0d038d0 <os_ux>
c0d02684:	61e0      	str	r0, [r4, #28]
c0d02686:	f001 f851 	bl	c0d0372c <ux_check_status_default>
c0d0268a:	f000 fd87 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d0268e:	f000 fd8b 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d02692:	60a5      	str	r5, [r4, #8]
c0d02694:	6820      	ldr	r0, [r4, #0]
c0d02696:	2800      	cmp	r0, #0
c0d02698:	d024      	beq.n	c0d026e4 <ui_approval+0x8c>
c0d0269a:	69e0      	ldr	r0, [r4, #28]
c0d0269c:	4914      	ldr	r1, [pc, #80]	; (c0d026f0 <ui_approval+0x98>)
c0d0269e:	4288      	cmp	r0, r1
c0d026a0:	d11e      	bne.n	c0d026e0 <ui_approval+0x88>
c0d026a2:	e01f      	b.n	c0d026e4 <ui_approval+0x8c>
c0d026a4:	6860      	ldr	r0, [r4, #4]
c0d026a6:	4285      	cmp	r5, r0
c0d026a8:	d21c      	bcs.n	c0d026e4 <ui_approval+0x8c>
c0d026aa:	f001 f981 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d026ae:	2800      	cmp	r0, #0
c0d026b0:	d118      	bne.n	c0d026e4 <ui_approval+0x8c>
c0d026b2:	68a0      	ldr	r0, [r4, #8]
c0d026b4:	68e1      	ldr	r1, [r4, #12]
c0d026b6:	2538      	movs	r5, #56	; 0x38
c0d026b8:	4368      	muls	r0, r5
c0d026ba:	6822      	ldr	r2, [r4, #0]
c0d026bc:	1810      	adds	r0, r2, r0
c0d026be:	2900      	cmp	r1, #0
c0d026c0:	d002      	beq.n	c0d026c8 <ui_approval+0x70>
c0d026c2:	4788      	blx	r1
c0d026c4:	2800      	cmp	r0, #0
c0d026c6:	d007      	beq.n	c0d026d8 <ui_approval+0x80>
c0d026c8:	2801      	cmp	r0, #1
c0d026ca:	d103      	bne.n	c0d026d4 <ui_approval+0x7c>
c0d026cc:	68a0      	ldr	r0, [r4, #8]
c0d026ce:	4345      	muls	r5, r0
c0d026d0:	6820      	ldr	r0, [r4, #0]
c0d026d2:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d026d4:	f000 feb6 	bl	c0d03444 <io_seproxyhal_display_default>
static void ui_approval(void) {
    uiState = UI_APPROVAL;
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_approval_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_approval_nanos, NULL);
c0d026d8:	68a0      	ldr	r0, [r4, #8]
c0d026da:	1c45      	adds	r5, r0, #1
c0d026dc:	60a5      	str	r5, [r4, #8]
c0d026de:	6820      	ldr	r0, [r4, #0]
c0d026e0:	2800      	cmp	r0, #0
c0d026e2:	d1df      	bne.n	c0d026a4 <ui_approval+0x4c>
#endif
}
c0d026e4:	bdb0      	pop	{r4, r5, r7, pc}
c0d026e6:	46c0      	nop			; (mov r8, r8)
c0d026e8:	20001930 	.word	0x20001930
c0d026ec:	20001880 	.word	0x20001880
c0d026f0:	b0105044 	.word	0xb0105044
c0d026f4:	00002524 	.word	0x00002524
c0d026f8:	0000033f 	.word	0x0000033f

c0d026fc <ui_idle>:
    text_y += TEXT_HEIGHT + TEXT_SPACE;
#endif
    return 1;
}

static void ui_idle(void) {
c0d026fc:	b5b0      	push	{r4, r5, r7, lr}
    uiState = UI_IDLE;
c0d026fe:	4822      	ldr	r0, [pc, #136]	; (c0d02788 <ui_idle+0x8c>)
c0d02700:	2500      	movs	r5, #0
c0d02702:	7005      	strb	r5, [r0, #0]
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_idle_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_idle_nanos, NULL);
c0d02704:	4c21      	ldr	r4, [pc, #132]	; (c0d0278c <ui_idle+0x90>)
c0d02706:	4823      	ldr	r0, [pc, #140]	; (c0d02794 <ui_idle+0x98>)
c0d02708:	4478      	add	r0, pc
c0d0270a:	6020      	str	r0, [r4, #0]
c0d0270c:	2003      	movs	r0, #3
c0d0270e:	6060      	str	r0, [r4, #4]
c0d02710:	4921      	ldr	r1, [pc, #132]	; (c0d02798 <ui_idle+0x9c>)
c0d02712:	4479      	add	r1, pc
c0d02714:	6121      	str	r1, [r4, #16]
c0d02716:	60e5      	str	r5, [r4, #12]
c0d02718:	7620      	strb	r0, [r4, #24]
c0d0271a:	61e5      	str	r5, [r4, #28]
c0d0271c:	4620      	mov	r0, r4
c0d0271e:	3018      	adds	r0, #24
c0d02720:	f001 f8d6 	bl	c0d038d0 <os_ux>
c0d02724:	61e0      	str	r0, [r4, #28]
c0d02726:	f001 f801 	bl	c0d0372c <ux_check_status_default>
c0d0272a:	f000 fd37 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d0272e:	f000 fd3b 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d02732:	60a5      	str	r5, [r4, #8]
c0d02734:	6820      	ldr	r0, [r4, #0]
c0d02736:	2800      	cmp	r0, #0
c0d02738:	d024      	beq.n	c0d02784 <ui_idle+0x88>
c0d0273a:	69e0      	ldr	r0, [r4, #28]
c0d0273c:	4914      	ldr	r1, [pc, #80]	; (c0d02790 <ui_idle+0x94>)
c0d0273e:	4288      	cmp	r0, r1
c0d02740:	d11e      	bne.n	c0d02780 <ui_idle+0x84>
c0d02742:	e01f      	b.n	c0d02784 <ui_idle+0x88>
c0d02744:	6860      	ldr	r0, [r4, #4]
c0d02746:	4285      	cmp	r5, r0
c0d02748:	d21c      	bcs.n	c0d02784 <ui_idle+0x88>
c0d0274a:	f001 f931 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d0274e:	2800      	cmp	r0, #0
c0d02750:	d118      	bne.n	c0d02784 <ui_idle+0x88>
c0d02752:	68a0      	ldr	r0, [r4, #8]
c0d02754:	68e1      	ldr	r1, [r4, #12]
c0d02756:	2538      	movs	r5, #56	; 0x38
c0d02758:	4368      	muls	r0, r5
c0d0275a:	6822      	ldr	r2, [r4, #0]
c0d0275c:	1810      	adds	r0, r2, r0
c0d0275e:	2900      	cmp	r1, #0
c0d02760:	d002      	beq.n	c0d02768 <ui_idle+0x6c>
c0d02762:	4788      	blx	r1
c0d02764:	2800      	cmp	r0, #0
c0d02766:	d007      	beq.n	c0d02778 <ui_idle+0x7c>
c0d02768:	2801      	cmp	r0, #1
c0d0276a:	d103      	bne.n	c0d02774 <ui_idle+0x78>
c0d0276c:	68a0      	ldr	r0, [r4, #8]
c0d0276e:	4345      	muls	r5, r0
c0d02770:	6820      	ldr	r0, [r4, #0]
c0d02772:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d02774:	f000 fe66 	bl	c0d03444 <io_seproxyhal_display_default>
static void ui_idle(void) {
    uiState = UI_IDLE;
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_idle_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_idle_nanos, NULL);
c0d02778:	68a0      	ldr	r0, [r4, #8]
c0d0277a:	1c45      	adds	r5, r0, #1
c0d0277c:	60a5      	str	r5, [r4, #8]
c0d0277e:	6820      	ldr	r0, [r4, #0]
c0d02780:	2800      	cmp	r0, #0
c0d02782:	d1df      	bne.n	c0d02744 <ui_idle+0x48>
#endif
}
c0d02784:	bdb0      	pop	{r4, r5, r7, pc}
c0d02786:	46c0      	nop			; (mov r8, r8)
c0d02788:	20001930 	.word	0x20001930
c0d0278c:	20001880 	.word	0x20001880
c0d02790:	b0105044 	.word	0xb0105044
c0d02794:	00002590 	.word	0x00002590
c0d02798:	0000042f 	.word	0x0000042f

c0d0279c <sample_main>:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

static void sample_main(void) {
c0d0279c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0279e:	b0ad      	sub	sp, #180	; 0xb4
c0d027a0:	2600      	movs	r6, #0
    volatile unsigned int rx = 0;
c0d027a2:	962c      	str	r6, [sp, #176]	; 0xb0
    volatile unsigned int tx = 0;
c0d027a4:	962b      	str	r6, [sp, #172]	; 0xac
    volatile unsigned int flags = 0;
c0d027a6:	962a      	str	r6, [sp, #168]	; 0xa8


    // next timer callback in 500 ms
    UX_CALLBACK_SET_INTERVAL(500);
c0d027a8:	207d      	movs	r0, #125	; 0x7d
c0d027aa:	0080      	lsls	r0, r0, #2
c0d027ac:	4f72      	ldr	r7, [pc, #456]	; (c0d02978 <sample_main+0x1dc>)
c0d027ae:	6178      	str	r0, [r7, #20]
c0d027b0:	4c74      	ldr	r4, [pc, #464]	; (c0d02984 <sample_main+0x1e8>)
c0d027b2:	a829      	add	r0, sp, #164	; 0xa4
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d027b4:	8006      	strh	r6, [r0, #0]
c0d027b6:	ad1e      	add	r5, sp, #120	; 0x78

        BEGIN_TRY {
            TRY {
c0d027b8:	4628      	mov	r0, r5
c0d027ba:	f002 f965 	bl	c0d04a88 <setjmp>
c0d027be:	8528      	strh	r0, [r5, #40]	; 0x28
c0d027c0:	496e      	ldr	r1, [pc, #440]	; (c0d0297c <sample_main+0x1e0>)
c0d027c2:	4208      	tst	r0, r1
c0d027c4:	d00f      	beq.n	c0d027e6 <sample_main+0x4a>
c0d027c6:	a91e      	add	r1, sp, #120	; 0x78
                default:
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d027c8:	850e      	strh	r6, [r1, #40]	; 0x28
c0d027ca:	210f      	movs	r1, #15
c0d027cc:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d027ce:	4001      	ands	r1, r0
c0d027d0:	2209      	movs	r2, #9
c0d027d2:	0312      	lsls	r2, r2, #12
c0d027d4:	4291      	cmp	r1, r2
c0d027d6:	d003      	beq.n	c0d027e0 <sample_main+0x44>
c0d027d8:	2203      	movs	r2, #3
c0d027da:	0352      	lsls	r2, r2, #13
c0d027dc:	4291      	cmp	r1, r2
c0d027de:	d17c      	bne.n	c0d028da <sample_main+0x13e>
c0d027e0:	a929      	add	r1, sp, #164	; 0xa4
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d027e2:	8008      	strh	r0, [r1, #0]
c0d027e4:	e080      	b.n	c0d028e8 <sample_main+0x14c>
c0d027e6:	a81e      	add	r0, sp, #120	; 0x78
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
c0d027e8:	f000 fa17 	bl	c0d02c1a <try_context_set>
                rx = tx;
c0d027ec:	982b      	ldr	r0, [sp, #172]	; 0xac
c0d027ee:	902c      	str	r0, [sp, #176]	; 0xb0
c0d027f0:	2500      	movs	r5, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d027f2:	952b      	str	r5, [sp, #172]	; 0xac
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d027f4:	982a      	ldr	r0, [sp, #168]	; 0xa8
c0d027f6:	992c      	ldr	r1, [sp, #176]	; 0xb0
c0d027f8:	b2c0      	uxtb	r0, r0
c0d027fa:	b289      	uxth	r1, r1
c0d027fc:	f000 fec2 	bl	c0d03584 <io_exchange>
c0d02800:	902c      	str	r0, [sp, #176]	; 0xb0
                flags = 0;
c0d02802:	952a      	str	r5, [sp, #168]	; 0xa8

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d02804:	982c      	ldr	r0, [sp, #176]	; 0xb0
c0d02806:	2800      	cmp	r0, #0
c0d02808:	d100      	bne.n	c0d0280c <sample_main+0x70>
c0d0280a:	e08c      	b.n	c0d02926 <sample_main+0x18a>
                    THROW(0x6982);
                }

                if (G_io_apdu_buffer[0] != CLA) {
c0d0280c:	7820      	ldrb	r0, [r4, #0]
c0d0280e:	2880      	cmp	r0, #128	; 0x80
c0d02810:	d000      	beq.n	c0d02814 <sample_main+0x78>
c0d02812:	e08b      	b.n	c0d0292c <sample_main+0x190>
                    THROW(0x6E00);
                }

                switch (G_io_apdu_buffer[1]) {
c0d02814:	7860      	ldrb	r0, [r4, #1]
c0d02816:	2802      	cmp	r0, #2
c0d02818:	d000      	beq.n	c0d0281c <sample_main+0x80>
c0d0281a:	e080      	b.n	c0d0291e <sample_main+0x182>
c0d0281c:	78a0      	ldrb	r0, [r4, #2]
                case INS_SIGN: {
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d0281e:	2180      	movs	r1, #128	; 0x80
c0d02820:	4301      	orrs	r1, r0
c0d02822:	2980      	cmp	r1, #128	; 0x80
c0d02824:	d000      	beq.n	c0d02828 <sample_main+0x8c>
c0d02826:	e0a0      	b.n	c0d0296a <sample_main+0x1ce>
c0d02828:	4857      	ldr	r0, [pc, #348]	; (c0d02988 <sample_main+0x1ec>)
c0d0282a:	7800      	ldrb	r0, [r0, #0]
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }
                    if (hashTainted) {
c0d0282c:	2801      	cmp	r0, #1
c0d0282e:	d105      	bne.n	c0d0283c <sample_main+0xa0>
                        cx_sha256_init(&hash);
c0d02830:	4856      	ldr	r0, [pc, #344]	; (c0d0298c <sample_main+0x1f0>)
c0d02832:	f001 f809 	bl	c0d03848 <cx_sha256_init>
c0d02836:	2000      	movs	r0, #0
c0d02838:	4953      	ldr	r1, [pc, #332]	; (c0d02988 <sample_main+0x1ec>)
c0d0283a:	7008      	strb	r0, [r1, #0]
                        hashTainted = 0;
                    }
                    // Wait for the UI to be completed
                    current_text_pos = 0;
c0d0283c:	4854      	ldr	r0, [pc, #336]	; (c0d02990 <sample_main+0x1f4>)
c0d0283e:	6005      	str	r5, [r0, #0]
                    text_y = 60;
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d02840:	7920      	ldrb	r0, [r4, #4]
c0d02842:	1820      	adds	r0, r4, r0
c0d02844:	7145      	strb	r5, [r0, #5]

                    display_text_part();
c0d02846:	f7ff fedf 	bl	c0d02608 <display_text_part>
    UX_DISPLAY(bagl_ui_idle_nanos, NULL);
#endif
}

static void ui_text(void) {
    uiState = UI_TEXT;
c0d0284a:	2001      	movs	r0, #1
c0d0284c:	4951      	ldr	r1, [pc, #324]	; (c0d02994 <sample_main+0x1f8>)
c0d0284e:	7008      	strb	r0, [r1, #0]
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_text, NULL);
#else
    UX_DISPLAY(bagl_ui_text_review_nanos, NULL);
c0d02850:	4855      	ldr	r0, [pc, #340]	; (c0d029a8 <sample_main+0x20c>)
c0d02852:	4478      	add	r0, pc
c0d02854:	6038      	str	r0, [r7, #0]
                        hashTainted = 0;
                    }
                    // Wait for the UI to be completed
                    current_text_pos = 0;
                    text_y = 60;
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d02856:	2005      	movs	r0, #5
static void ui_text(void) {
    uiState = UI_TEXT;
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_text, NULL);
#else
    UX_DISPLAY(bagl_ui_text_review_nanos, NULL);
c0d02858:	6078      	str	r0, [r7, #4]
c0d0285a:	4854      	ldr	r0, [pc, #336]	; (c0d029ac <sample_main+0x210>)
c0d0285c:	4478      	add	r0, pc
c0d0285e:	6138      	str	r0, [r7, #16]
c0d02860:	60fd      	str	r5, [r7, #12]
c0d02862:	2003      	movs	r0, #3
c0d02864:	7638      	strb	r0, [r7, #24]
c0d02866:	61fd      	str	r5, [r7, #28]
c0d02868:	4638      	mov	r0, r7
c0d0286a:	3018      	adds	r0, #24
c0d0286c:	f001 f830 	bl	c0d038d0 <os_ux>
c0d02870:	61f8      	str	r0, [r7, #28]
c0d02872:	f000 ff5b 	bl	c0d0372c <ux_check_status_default>
c0d02876:	f000 fc91 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d0287a:	f000 fc95 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d0287e:	60bd      	str	r5, [r7, #8]
c0d02880:	6838      	ldr	r0, [r7, #0]
c0d02882:	2800      	cmp	r0, #0
c0d02884:	d024      	beq.n	c0d028d0 <sample_main+0x134>
c0d02886:	69f8      	ldr	r0, [r7, #28]
c0d02888:	4943      	ldr	r1, [pc, #268]	; (c0d02998 <sample_main+0x1fc>)
c0d0288a:	4288      	cmp	r0, r1
c0d0288c:	d117      	bne.n	c0d028be <sample_main+0x122>
c0d0288e:	e01f      	b.n	c0d028d0 <sample_main+0x134>
c0d02890:	68b8      	ldr	r0, [r7, #8]
c0d02892:	68f9      	ldr	r1, [r7, #12]
c0d02894:	2538      	movs	r5, #56	; 0x38
c0d02896:	4368      	muls	r0, r5
c0d02898:	683a      	ldr	r2, [r7, #0]
c0d0289a:	1810      	adds	r0, r2, r0
c0d0289c:	2900      	cmp	r1, #0
c0d0289e:	d002      	beq.n	c0d028a6 <sample_main+0x10a>
c0d028a0:	4788      	blx	r1
c0d028a2:	2800      	cmp	r0, #0
c0d028a4:	d007      	beq.n	c0d028b6 <sample_main+0x11a>
c0d028a6:	2801      	cmp	r0, #1
c0d028a8:	d103      	bne.n	c0d028b2 <sample_main+0x116>
c0d028aa:	68b8      	ldr	r0, [r7, #8]
c0d028ac:	4345      	muls	r5, r0
c0d028ae:	6838      	ldr	r0, [r7, #0]
c0d028b0:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d028b2:	f000 fdc7 	bl	c0d03444 <io_seproxyhal_display_default>
static void ui_text(void) {
    uiState = UI_TEXT;
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_text, NULL);
#else
    UX_DISPLAY(bagl_ui_text_review_nanos, NULL);
c0d028b6:	68b8      	ldr	r0, [r7, #8]
c0d028b8:	1c45      	adds	r5, r0, #1
c0d028ba:	60bd      	str	r5, [r7, #8]
c0d028bc:	6838      	ldr	r0, [r7, #0]
c0d028be:	2800      	cmp	r0, #0
c0d028c0:	d006      	beq.n	c0d028d0 <sample_main+0x134>
c0d028c2:	6878      	ldr	r0, [r7, #4]
c0d028c4:	4285      	cmp	r5, r0
c0d028c6:	d203      	bcs.n	c0d028d0 <sample_main+0x134>
c0d028c8:	f001 f872 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d028cc:	2800      	cmp	r0, #0
c0d028ce:	d0df      	beq.n	c0d02890 <sample_main+0xf4>
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';

                    display_text_part();
                    ui_text();

                    flags |= IO_ASYNCH_REPLY;
c0d028d0:	2010      	movs	r0, #16
c0d028d2:	992a      	ldr	r1, [sp, #168]	; 0xa8
c0d028d4:	4301      	orrs	r1, r0
c0d028d6:	912a      	str	r1, [sp, #168]	; 0xa8
c0d028d8:	e011      	b.n	c0d028fe <sample_main+0x162>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d028da:	4929      	ldr	r1, [pc, #164]	; (c0d02980 <sample_main+0x1e4>)
c0d028dc:	4008      	ands	r0, r1
c0d028de:	210d      	movs	r1, #13
c0d028e0:	02c9      	lsls	r1, r1, #11
c0d028e2:	4301      	orrs	r1, r0
c0d028e4:	a829      	add	r0, sp, #164	; 0xa4
c0d028e6:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d028e8:	9829      	ldr	r0, [sp, #164]	; 0xa4
c0d028ea:	0a00      	lsrs	r0, r0, #8
c0d028ec:	992b      	ldr	r1, [sp, #172]	; 0xac
c0d028ee:	5460      	strb	r0, [r4, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d028f0:	9829      	ldr	r0, [sp, #164]	; 0xa4
c0d028f2:	992b      	ldr	r1, [sp, #172]	; 0xac
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d028f4:	1861      	adds	r1, r4, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d028f6:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d028f8:	982b      	ldr	r0, [sp, #172]	; 0xac
c0d028fa:	1c80      	adds	r0, r0, #2
c0d028fc:	902b      	str	r0, [sp, #172]	; 0xac
            }
            FINALLY {
c0d028fe:	f000 fafb 	bl	c0d02ef8 <try_context_get>
c0d02902:	a91e      	add	r1, sp, #120	; 0x78
c0d02904:	4288      	cmp	r0, r1
c0d02906:	d103      	bne.n	c0d02910 <sample_main+0x174>
c0d02908:	f000 faf8 	bl	c0d02efc <try_context_get_previous>
c0d0290c:	f000 f985 	bl	c0d02c1a <try_context_set>
c0d02910:	a81e      	add	r0, sp, #120	; 0x78
            }
        }
        END_TRY;
c0d02912:	8d00      	ldrh	r0, [r0, #40]	; 0x28
c0d02914:	2800      	cmp	r0, #0
c0d02916:	d100      	bne.n	c0d0291a <sample_main+0x17e>
c0d02918:	e74b      	b.n	c0d027b2 <sample_main+0x16>
c0d0291a:	f000 fae8 	bl	c0d02eee <os_longjmp>
c0d0291e:	28ff      	cmp	r0, #255	; 0xff
c0d02920:	d108      	bne.n	c0d02934 <sample_main+0x198>
    }

return_to_dashboard:
    return;
}
c0d02922:	b02d      	add	sp, #180	; 0xb4
c0d02924:	bdf0      	pop	{r4, r5, r6, r7, pc}
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    THROW(0x6982);
c0d02926:	481e      	ldr	r0, [pc, #120]	; (c0d029a0 <sample_main+0x204>)
c0d02928:	f000 fae1 	bl	c0d02eee <os_longjmp>
                }

                if (G_io_apdu_buffer[0] != CLA) {
                    THROW(0x6E00);
c0d0292c:	2037      	movs	r0, #55	; 0x37
c0d0292e:	0240      	lsls	r0, r0, #9
c0d02930:	f000 fadd 	bl	c0d02eee <os_longjmp>
c0d02934:	2804      	cmp	r0, #4
c0d02936:	d11b      	bne.n	c0d02970 <sample_main+0x1d4>
c0d02938:	ac01      	add	r4, sp, #4
                } break;

                case INS_GET_PUBLIC_KEY: {
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;
                    os_memmove(&privateKey, &N_privateKey,
c0d0293a:	491a      	ldr	r1, [pc, #104]	; (c0d029a4 <sample_main+0x208>)
c0d0293c:	4479      	add	r1, pc
c0d0293e:	2228      	movs	r2, #40	; 0x28
c0d02940:	4620      	mov	r0, r4
c0d02942:	f000 fa20 	bl	c0d02d86 <os_memmove>
c0d02946:	ad0b      	add	r5, sp, #44	; 0x2c
                               sizeof(cx_ecfp_private_key_t));
                    keygen25519(publicKey.W, NULL, privateKey.d);
c0d02948:	3508      	adds	r5, #8
c0d0294a:	3408      	adds	r4, #8
c0d0294c:	4628      	mov	r0, r5
c0d0294e:	4621      	mov	r1, r4
c0d02950:	f000 f8e6 	bl	c0d02b20 <keygen25519>
                    os_memmove(G_io_apdu_buffer, publicKey.W, 32);
c0d02954:	480b      	ldr	r0, [pc, #44]	; (c0d02984 <sample_main+0x1e8>)
c0d02956:	2420      	movs	r4, #32
c0d02958:	4629      	mov	r1, r5
c0d0295a:	4622      	mov	r2, r4
c0d0295c:	f000 fa13 	bl	c0d02d86 <os_memmove>
                    tx = 32;
c0d02960:	942b      	str	r4, [sp, #172]	; 0xac
                    THROW(0x9000);
c0d02962:	2009      	movs	r0, #9
c0d02964:	0300      	lsls	r0, r0, #12
c0d02966:	f000 fac2 	bl	c0d02eee <os_longjmp>

                switch (G_io_apdu_buffer[1]) {
                case INS_SIGN: {
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d0296a:	480c      	ldr	r0, [pc, #48]	; (c0d0299c <sample_main+0x200>)
c0d0296c:	f000 fabf 	bl	c0d02eee <os_longjmp>

                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                default:
                    THROW(0x6D00);
c0d02970:	206d      	movs	r0, #109	; 0x6d
c0d02972:	0200      	lsls	r0, r0, #8
c0d02974:	f000 fabb 	bl	c0d02eee <os_longjmp>
c0d02978:	20001880 	.word	0x20001880
c0d0297c:	0000ffff 	.word	0x0000ffff
c0d02980:	000007ff 	.word	0x000007ff
c0d02984:	20001a44 	.word	0x20001a44
c0d02988:	20001938 	.word	0x20001938
c0d0298c:	200019cc 	.word	0x200019cc
c0d02990:	20001934 	.word	0x20001934
c0d02994:	20001930 	.word	0x20001930
c0d02998:	b0105044 	.word	0xb0105044
c0d0299c:	00006a86 	.word	0x00006a86
c0d029a0:	00006982 	.word	0x00006982
c0d029a4:	00002644 	.word	0x00002644
c0d029a8:	000024ee 	.word	0x000024ee
c0d029ac:	00000301 	.word	0x00000301

c0d029b0 <bagl_ui_approval_nanos_button>:
    },
};

static unsigned int
bagl_ui_approval_nanos_button(unsigned int button_mask,
                              unsigned int button_mask_counter) {
c0d029b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d029b2:	b09b      	sub	sp, #108	; 0x6c
c0d029b4:	2601      	movs	r6, #1
        // return 64 bytes to host
        tx=64;
        G_io_apdu_buffer[0] &= 0xF0; // discard the parity information
        hashTainted = 1;
    }
    G_io_apdu_buffer[tx++] = 0x90;
c0d029b6:	2480      	movs	r4, #128	; 0x80
};

static unsigned int
bagl_ui_approval_nanos_button(unsigned int button_mask,
                              unsigned int button_mask_counter) {
    switch (button_mask) {
c0d029b8:	4952      	ldr	r1, [pc, #328]	; (c0d02b04 <bagl_ui_approval_nanos_button+0x154>)
c0d029ba:	4288      	cmp	r0, r1
c0d029bc:	d100      	bne.n	c0d029c0 <bagl_ui_approval_nanos_button+0x10>
c0d029be:	e090      	b.n	c0d02ae2 <bagl_ui_approval_nanos_button+0x132>
c0d029c0:	4951      	ldr	r1, [pc, #324]	; (c0d02b08 <bagl_ui_approval_nanos_button+0x158>)
c0d029c2:	4288      	cmp	r0, r1
c0d029c4:	d000      	beq.n	c0d029c8 <bagl_ui_approval_nanos_button+0x18>
c0d029c6:	e099      	b.n	c0d02afc <bagl_ui_approval_nanos_button+0x14c>

static const bagl_element_t*
io_seproxyhal_touch_approve(const bagl_element_t *e) {
    unsigned int tx = 0;
    // Update the hash
    cx_hash(&hash.header, 0, G_io_apdu_buffer + 5, G_io_apdu_buffer[4], NULL);
c0d029c8:	4d51      	ldr	r5, [pc, #324]	; (c0d02b10 <bagl_ui_approval_nanos_button+0x160>)
c0d029ca:	792b      	ldrb	r3, [r5, #4]
c0d029cc:	2700      	movs	r7, #0
c0d029ce:	4668      	mov	r0, sp
c0d029d0:	6007      	str	r7, [r0, #0]
c0d029d2:	1d6a      	adds	r2, r5, #5
c0d029d4:	484f      	ldr	r0, [pc, #316]	; (c0d02b14 <bagl_ui_approval_nanos_button+0x164>)
c0d029d6:	4639      	mov	r1, r7
c0d029d8:	f7ff fac8 	bl	c0d01f6c <cx_hash_X>
    if (G_io_apdu_buffer[2] == P1_LAST) {
c0d029dc:	78a8      	ldrb	r0, [r5, #2]
c0d029de:	42a0      	cmp	r0, r4
c0d029e0:	9708      	str	r7, [sp, #32]
c0d029e2:	d175      	bne.n	c0d02ad0 <bagl_ui_approval_nanos_button+0x120>
c0d029e4:	a813      	add	r0, sp, #76	; 0x4c
        // Hash is finalized, send back the signature
        unsigned char result[32];
        cx_hash(&hash.header, CX_LAST, G_io_apdu_buffer, 0, result);
c0d029e6:	4669      	mov	r1, sp
c0d029e8:	6008      	str	r0, [r1, #0]
c0d029ea:	484a      	ldr	r0, [pc, #296]	; (c0d02b14 <bagl_ui_approval_nanos_button+0x164>)
c0d029ec:	2101      	movs	r1, #1
c0d029ee:	9106      	str	r1, [sp, #24]
c0d029f0:	2500      	movs	r5, #0
c0d029f2:	4a47      	ldr	r2, [pc, #284]	; (c0d02b10 <bagl_ui_approval_nanos_button+0x160>)
c0d029f4:	462b      	mov	r3, r5
c0d029f6:	f7ff fab9 	bl	c0d01f6c <cx_hash_X>
c0d029fa:	af09      	add	r7, sp, #36	; 0x24
        cx_ecfp_private_key_t signingKey;
        os_memmove(&signingKey, &N_privateKey,
c0d029fc:	4947      	ldr	r1, [pc, #284]	; (c0d02b1c <bagl_ui_approval_nanos_button+0x16c>)
c0d029fe:	4479      	add	r1, pc
c0d02a00:	2228      	movs	r2, #40	; 0x28
c0d02a02:	4638      	mov	r0, r7
c0d02a04:	9707      	str	r7, [sp, #28]
c0d02a06:	f000 f9be 	bl	c0d02d86 <os_memmove>
                   sizeof(cx_ecfp_private_key_t));

        signingKey.curve = CX_CURVE_Curve25519;
c0d02a0a:	2061      	movs	r0, #97	; 0x61
c0d02a0c:	7038      	strb	r0, [r7, #0]
c0d02a0e:	2020      	movs	r0, #32
        signingKey.d_len = 32;
c0d02a10:	9002      	str	r0, [sp, #8]
c0d02a12:	900a      	str	r0, [sp, #40]	; 0x28
c0d02a14:	9404      	str	r4, [sp, #16]

        // m = hash(Z, message)
        cx_hash(&hash.header, CX_LAST, G_io_apdu_buffer, 0, signingContext.m);
c0d02a16:	4c40      	ldr	r4, [pc, #256]	; (c0d02b18 <bagl_ui_approval_nanos_button+0x168>)
c0d02a18:	4668      	mov	r0, sp
c0d02a1a:	6004      	str	r4, [r0, #0]
c0d02a1c:	483d      	ldr	r0, [pc, #244]	; (c0d02b14 <bagl_ui_approval_nanos_button+0x164>)
c0d02a1e:	4607      	mov	r7, r0
c0d02a20:	9906      	ldr	r1, [sp, #24]
c0d02a22:	4a3b      	ldr	r2, [pc, #236]	; (c0d02b10 <bagl_ui_approval_nanos_button+0x160>)
c0d02a24:	462b      	mov	r3, r5
c0d02a26:	f7ff faa1 	bl	c0d01f6c <cx_hash_X>

        // x = hash(m, s)
        cx_sha256_init(&hash);
c0d02a2a:	4638      	mov	r0, r7
c0d02a2c:	f000 ff0c 	bl	c0d03848 <cx_sha256_init>
        cx_hash(&hash.header, 0, signingContext.m, 32, NULL);
c0d02a30:	4668      	mov	r0, sp
c0d02a32:	6005      	str	r5, [r0, #0]
c0d02a34:	4638      	mov	r0, r7
c0d02a36:	4629      	mov	r1, r5
c0d02a38:	4622      	mov	r2, r4
c0d02a3a:	9f02      	ldr	r7, [sp, #8]
c0d02a3c:	463b      	mov	r3, r7
c0d02a3e:	f7ff fa95 	bl	c0d01f6c <cx_hash_X>
        cx_hash(&hash.header, CX_LAST, signingKey.d, 32, signingContext.x);
c0d02a42:	4621      	mov	r1, r4
c0d02a44:	3120      	adds	r1, #32
c0d02a46:	9105      	str	r1, [sp, #20]
c0d02a48:	4668      	mov	r0, sp
c0d02a4a:	6001      	str	r1, [r0, #0]
c0d02a4c:	9a07      	ldr	r2, [sp, #28]
c0d02a4e:	3208      	adds	r2, #8
c0d02a50:	9207      	str	r2, [sp, #28]
c0d02a52:	4830      	ldr	r0, [pc, #192]	; (c0d02b14 <bagl_ui_approval_nanos_button+0x164>)
c0d02a54:	9906      	ldr	r1, [sp, #24]
c0d02a56:	463b      	mov	r3, r7
c0d02a58:	f7ff fa88 	bl	c0d01f6c <cx_hash_X>
 *   k [out] your private key for key agreement
 *   k  [in]  32 random bytes
 */
static inline
void clamp25519(priv25519 k) {
	k[31] &= 0x7F;
c0d02a5c:	203f      	movs	r0, #63	; 0x3f
c0d02a5e:	5c21      	ldrb	r1, [r4, r0]
c0d02a60:	4001      	ands	r1, r0
c0d02a62:	2240      	movs	r2, #64	; 0x40
	k[31] |= 0x40;
c0d02a64:	9203      	str	r2, [sp, #12]
c0d02a66:	4311      	orrs	r1, r2
c0d02a68:	5421      	strb	r1, [r4, r0]
	k[ 0] &= 0xF8;
c0d02a6a:	5de0      	ldrb	r0, [r4, r7]
c0d02a6c:	21f8      	movs	r1, #248	; 0xf8
c0d02a6e:	4001      	ands	r1, r0
c0d02a70:	55e1      	strb	r1, [r4, r7]
 *
 * WARNING: if s is not NULL, this function has data-dependent timing */
static inline
void keygen25519(pub25519 P, spriv25519 s, priv25519 k) {
	clamp25519(k);
	core25519(P, s, k, NULL);
c0d02a72:	4827      	ldr	r0, [pc, #156]	; (c0d02b10 <bagl_ui_approval_nanos_button+0x160>)
c0d02a74:	4629      	mov	r1, r5
c0d02a76:	9a05      	ldr	r2, [sp, #20]
c0d02a78:	462b      	mov	r3, r5
c0d02a7a:	f7fd fb23 	bl	c0d000c4 <core25519>
c0d02a7e:	4825      	ldr	r0, [pc, #148]	; (c0d02b14 <bagl_ui_approval_nanos_button+0x164>)
        // keygen25519(Y, NULL, x);
        // reuse G_io_apdu_buffer = Y to save some memory.
        keygen25519(G_io_apdu_buffer, NULL, signingContext.x);

        // r = hash(m+Y);
        cx_sha256_init(&hash);
c0d02a80:	f000 fee2 	bl	c0d03848 <cx_sha256_init>
        cx_hash(&hash.header, 0, signingContext.m, 32, NULL);
c0d02a84:	4668      	mov	r0, sp
c0d02a86:	6005      	str	r5, [r0, #0]
c0d02a88:	4822      	ldr	r0, [pc, #136]	; (c0d02b14 <bagl_ui_approval_nanos_button+0x164>)
c0d02a8a:	4629      	mov	r1, r5
c0d02a8c:	4d20      	ldr	r5, [pc, #128]	; (c0d02b10 <bagl_ui_approval_nanos_button+0x160>)
c0d02a8e:	4622      	mov	r2, r4
c0d02a90:	463b      	mov	r3, r7
c0d02a92:	f7ff fa6b 	bl	c0d01f6c <cx_hash_X>
        cx_hash(&hash.header, CX_LAST, G_io_apdu_buffer, 32, signingContext.r);
c0d02a96:	3440      	adds	r4, #64	; 0x40
c0d02a98:	4668      	mov	r0, sp
c0d02a9a:	6004      	str	r4, [r0, #0]
c0d02a9c:	481d      	ldr	r0, [pc, #116]	; (c0d02b14 <bagl_ui_approval_nanos_button+0x164>)
c0d02a9e:	9906      	ldr	r1, [sp, #24]
c0d02aa0:	462a      	mov	r2, r5
c0d02aa2:	463b      	mov	r3, r7
c0d02aa4:	f7ff fa62 	bl	c0d01f6c <cx_hash_X>

        // output (v,r) as the signature
        // put v into G_io_apdu_buffer first, followed by r
        //int sign25519(k25519 v, const k25519 h, const priv25519 x, const spriv25519 s)
        sign25519(G_io_apdu_buffer, signingContext.r, signingContext.x, signingKey.d);
c0d02aa8:	4628      	mov	r0, r5
c0d02aaa:	4621      	mov	r1, r4
c0d02aac:	9a05      	ldr	r2, [sp, #20]
c0d02aae:	9b07      	ldr	r3, [sp, #28]
c0d02ab0:	f7ff f8dc 	bl	c0d01c6c <sign25519>
        os_memcpy(G_io_apdu_buffer+32, signingContext.r, 32);
c0d02ab4:	4628      	mov	r0, r5
c0d02ab6:	3020      	adds	r0, #32
c0d02ab8:	4621      	mov	r1, r4
c0d02aba:	9c04      	ldr	r4, [sp, #16]
c0d02abc:	463a      	mov	r2, r7
c0d02abe:	f000 f962 	bl	c0d02d86 <os_memmove>

        // return 64 bytes to host
        tx=64;
        G_io_apdu_buffer[0] &= 0xF0; // discard the parity information
c0d02ac2:	7828      	ldrb	r0, [r5, #0]
c0d02ac4:	21f0      	movs	r1, #240	; 0xf0
c0d02ac6:	4001      	ands	r1, r0
c0d02ac8:	7029      	strb	r1, [r5, #0]
c0d02aca:	4810      	ldr	r0, [pc, #64]	; (c0d02b0c <bagl_ui_approval_nanos_button+0x15c>)
c0d02acc:	7006      	strb	r6, [r0, #0]
c0d02ace:	9f03      	ldr	r7, [sp, #12]
        hashTainted = 1;
    }
    G_io_apdu_buffer[tx++] = 0x90;
c0d02ad0:	3410      	adds	r4, #16
c0d02ad2:	55ec      	strb	r4, [r5, r7]
c0d02ad4:	433e      	orrs	r6, r7
    G_io_apdu_buffer[tx++] = 0x00;
c0d02ad6:	9808      	ldr	r0, [sp, #32]
c0d02ad8:	55a8      	strb	r0, [r5, r6]
c0d02ada:	1c70      	adds	r0, r6, #1
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d02adc:	b281      	uxth	r1, r0
c0d02ade:	2020      	movs	r0, #32
c0d02ae0:	e008      	b.n	c0d02af4 <bagl_ui_approval_nanos_button+0x144>
c0d02ae2:	480a      	ldr	r0, [pc, #40]	; (c0d02b0c <bagl_ui_approval_nanos_button+0x15c>)
c0d02ae4:	7006      	strb	r6, [r0, #0]
    return 0; // do not redraw the widget
}

static const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e) {
    hashTainted = 1;
    G_io_apdu_buffer[0] = 0x69;
c0d02ae6:	480a      	ldr	r0, [pc, #40]	; (c0d02b10 <bagl_ui_approval_nanos_button+0x160>)
c0d02ae8:	2169      	movs	r1, #105	; 0x69
c0d02aea:	7001      	strb	r1, [r0, #0]
    G_io_apdu_buffer[1] = 0x85;
c0d02aec:	1d61      	adds	r1, r4, #5
c0d02aee:	7041      	strb	r1, [r0, #1]
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d02af0:	2020      	movs	r0, #32
c0d02af2:	2102      	movs	r1, #2
c0d02af4:	f000 fd46 	bl	c0d03584 <io_exchange>
c0d02af8:	f7ff fe00 	bl	c0d026fc <ui_idle>

    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_deny(NULL);
        break;
    }
    return 0;
c0d02afc:	2000      	movs	r0, #0
c0d02afe:	b01b      	add	sp, #108	; 0x6c
c0d02b00:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02b02:	46c0      	nop			; (mov r8, r8)
c0d02b04:	80000001 	.word	0x80000001
c0d02b08:	80000002 	.word	0x80000002
c0d02b0c:	20001938 	.word	0x20001938
c0d02b10:	20001a44 	.word	0x20001a44
c0d02b14:	200019cc 	.word	0x200019cc
c0d02b18:	20001939 	.word	0x20001939
c0d02b1c:	00002582 	.word	0x00002582

c0d02b20 <keygen25519>:
 *   k  [in]  32 random bytes
 * s may be NULL if you don't care
 *
 * WARNING: if s is not NULL, this function has data-dependent timing */
static inline
void keygen25519(pub25519 P, spriv25519 s, priv25519 k) {
c0d02b20:	b580      	push	{r7, lr}
c0d02b22:	460a      	mov	r2, r1
 *   k [out] your private key for key agreement
 *   k  [in]  32 random bytes
 */
static inline
void clamp25519(priv25519 k) {
	k[31] &= 0x7F;
c0d02b24:	7fd1      	ldrb	r1, [r2, #31]
c0d02b26:	233f      	movs	r3, #63	; 0x3f
c0d02b28:	400b      	ands	r3, r1
	k[31] |= 0x40;
c0d02b2a:	2140      	movs	r1, #64	; 0x40
c0d02b2c:	4319      	orrs	r1, r3
c0d02b2e:	77d1      	strb	r1, [r2, #31]
	k[ 0] &= 0xF8;
c0d02b30:	7811      	ldrb	r1, [r2, #0]
c0d02b32:	23f8      	movs	r3, #248	; 0xf8
c0d02b34:	400b      	ands	r3, r1
c0d02b36:	7013      	strb	r3, [r2, #0]
c0d02b38:	2100      	movs	r1, #0
 *
 * WARNING: if s is not NULL, this function has data-dependent timing */
static inline
void keygen25519(pub25519 P, spriv25519 s, priv25519 k) {
	clamp25519(k);
	core25519(P, s, k, NULL);
c0d02b3a:	460b      	mov	r3, r1
c0d02b3c:	f7fd fac2 	bl	c0d000c4 <core25519>
}
c0d02b40:	bd80      	pop	{r7, pc}
	...

c0d02b44 <bagl_ui_idle_nanos_button>:
    },
};

static unsigned int
bagl_ui_idle_nanos_button(unsigned int button_mask,
                          unsigned int button_mask_counter) {
c0d02b44:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d02b46:	2102      	movs	r1, #2
c0d02b48:	4301      	orrs	r1, r0
c0d02b4a:	4804      	ldr	r0, [pc, #16]	; (c0d02b5c <bagl_ui_idle_nanos_button+0x18>)
c0d02b4c:	4281      	cmp	r1, r0
c0d02b4e:	d102      	bne.n	c0d02b56 <bagl_ui_idle_nanos_button+0x12>

#endif

static const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02b50:	2000      	movs	r0, #0
c0d02b52:	f000 fea7 	bl	c0d038a4 <os_sched_exit>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        io_seproxyhal_touch_exit(NULL);
        break;
    }

    return 0;
c0d02b56:	2000      	movs	r0, #0
c0d02b58:	bd80      	pop	{r7, pc}
c0d02b5a:	46c0      	nop			; (mov r8, r8)
c0d02b5c:	80000003 	.word	0x80000003

c0d02b60 <bagl_ui_text_review_nanos_button>:
    },
};

static unsigned int
bagl_ui_text_review_nanos_button(unsigned int button_mask,
                                 unsigned int button_mask_counter) {
c0d02b60:	b5b0      	push	{r4, r5, r7, lr}
    switch (button_mask) {
c0d02b62:	4926      	ldr	r1, [pc, #152]	; (c0d02bfc <bagl_ui_text_review_nanos_button+0x9c>)
c0d02b64:	4288      	cmp	r0, r1
c0d02b66:	d036      	beq.n	c0d02bd6 <bagl_ui_text_review_nanos_button+0x76>
c0d02b68:	4925      	ldr	r1, [pc, #148]	; (c0d02c00 <bagl_ui_text_review_nanos_button+0xa0>)
c0d02b6a:	4288      	cmp	r0, r1
c0d02b6c:	d144      	bne.n	c0d02bf8 <bagl_ui_text_review_nanos_button+0x98>
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        if (!display_text_part()) {
c0d02b6e:	f7ff fd4b 	bl	c0d02608 <display_text_part>
c0d02b72:	2800      	cmp	r0, #0
c0d02b74:	d03e      	beq.n	c0d02bf4 <bagl_ui_text_review_nanos_button+0x94>
            ui_approval();
        } else {
            UX_REDISPLAY();
c0d02b76:	f000 fb11 	bl	c0d0319c <io_seproxyhal_init_ux>
c0d02b7a:	f000 fb15 	bl	c0d031a8 <io_seproxyhal_init_button>
c0d02b7e:	4c23      	ldr	r4, [pc, #140]	; (c0d02c0c <bagl_ui_text_review_nanos_button+0xac>)
c0d02b80:	2000      	movs	r0, #0
c0d02b82:	60a0      	str	r0, [r4, #8]
c0d02b84:	6821      	ldr	r1, [r4, #0]
c0d02b86:	2900      	cmp	r1, #0
c0d02b88:	d036      	beq.n	c0d02bf8 <bagl_ui_text_review_nanos_button+0x98>
c0d02b8a:	69e1      	ldr	r1, [r4, #28]
c0d02b8c:	4a20      	ldr	r2, [pc, #128]	; (c0d02c10 <bagl_ui_text_review_nanos_button+0xb0>)
c0d02b8e:	4291      	cmp	r1, r2
c0d02b90:	d11e      	bne.n	c0d02bd0 <bagl_ui_text_review_nanos_button+0x70>
c0d02b92:	e031      	b.n	c0d02bf8 <bagl_ui_text_review_nanos_button+0x98>
c0d02b94:	6861      	ldr	r1, [r4, #4]
c0d02b96:	4288      	cmp	r0, r1
c0d02b98:	d22e      	bcs.n	c0d02bf8 <bagl_ui_text_review_nanos_button+0x98>
c0d02b9a:	f000 ff09 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d02b9e:	2800      	cmp	r0, #0
c0d02ba0:	d12a      	bne.n	c0d02bf8 <bagl_ui_text_review_nanos_button+0x98>
c0d02ba2:	68a0      	ldr	r0, [r4, #8]
c0d02ba4:	68e1      	ldr	r1, [r4, #12]
c0d02ba6:	2538      	movs	r5, #56	; 0x38
c0d02ba8:	4368      	muls	r0, r5
c0d02baa:	6822      	ldr	r2, [r4, #0]
c0d02bac:	1810      	adds	r0, r2, r0
c0d02bae:	2900      	cmp	r1, #0
c0d02bb0:	d002      	beq.n	c0d02bb8 <bagl_ui_text_review_nanos_button+0x58>
c0d02bb2:	4788      	blx	r1
c0d02bb4:	2800      	cmp	r0, #0
c0d02bb6:	d007      	beq.n	c0d02bc8 <bagl_ui_text_review_nanos_button+0x68>
c0d02bb8:	2801      	cmp	r0, #1
c0d02bba:	d103      	bne.n	c0d02bc4 <bagl_ui_text_review_nanos_button+0x64>
c0d02bbc:	68a0      	ldr	r0, [r4, #8]
c0d02bbe:	4345      	muls	r5, r0
c0d02bc0:	6820      	ldr	r0, [r4, #0]
c0d02bc2:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d02bc4:	f000 fc3e 	bl	c0d03444 <io_seproxyhal_display_default>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        if (!display_text_part()) {
            ui_approval();
        } else {
            UX_REDISPLAY();
c0d02bc8:	68a0      	ldr	r0, [r4, #8]
c0d02bca:	1c40      	adds	r0, r0, #1
c0d02bcc:	60a0      	str	r0, [r4, #8]
c0d02bce:	6821      	ldr	r1, [r4, #0]
c0d02bd0:	2900      	cmp	r1, #0
c0d02bd2:	d1df      	bne.n	c0d02b94 <bagl_ui_text_review_nanos_button+0x34>
c0d02bd4:	e010      	b.n	c0d02bf8 <bagl_ui_text_review_nanos_button+0x98>
c0d02bd6:	480b      	ldr	r0, [pc, #44]	; (c0d02c04 <bagl_ui_text_review_nanos_button+0xa4>)
c0d02bd8:	2101      	movs	r1, #1
c0d02bda:	7001      	strb	r1, [r0, #0]
    return 0; // do not redraw the widget
}

static const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e) {
    hashTainted = 1;
    G_io_apdu_buffer[0] = 0x69;
c0d02bdc:	480a      	ldr	r0, [pc, #40]	; (c0d02c08 <bagl_ui_text_review_nanos_button+0xa8>)
c0d02bde:	2169      	movs	r1, #105	; 0x69
c0d02be0:	7001      	strb	r1, [r0, #0]
    G_io_apdu_buffer[1] = 0x85;
c0d02be2:	2185      	movs	r1, #133	; 0x85
c0d02be4:	7041      	strb	r1, [r0, #1]
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d02be6:	2020      	movs	r0, #32
c0d02be8:	2102      	movs	r1, #2
c0d02bea:	f000 fccb 	bl	c0d03584 <io_exchange>
    // Display back the original UX
    ui_idle();
c0d02bee:	f7ff fd85 	bl	c0d026fc <ui_idle>
c0d02bf2:	e001      	b.n	c0d02bf8 <bagl_ui_text_review_nanos_button+0x98>
bagl_ui_text_review_nanos_button(unsigned int button_mask,
                                 unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        if (!display_text_part()) {
            ui_approval();
c0d02bf4:	f7ff fd30 	bl	c0d02658 <ui_approval>

    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_deny(NULL);
        break;
    }
    return 0;
c0d02bf8:	2000      	movs	r0, #0
c0d02bfa:	bdb0      	pop	{r4, r5, r7, pc}
c0d02bfc:	80000001 	.word	0x80000001
c0d02c00:	80000002 	.word	0x80000002
c0d02c04:	20001938 	.word	0x20001938
c0d02c08:	20001a44 	.word	0x20001a44
c0d02c0c:	20001880 	.word	0x20001880
c0d02c10:	b0105044 	.word	0xb0105044

c0d02c14 <os_boot>:
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
}

void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
c0d02c14:	2000      	movs	r0, #0
c0d02c16:	4681      	mov	r9, r0

void os_boot(void) {
  // TODO patch entry point when romming (f)
  // set the default try context to nothing
  try_context_set(NULL);
}
c0d02c18:	4770      	bx	lr

c0d02c1a <try_context_set>:
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
}

void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
c0d02c1a:	4681      	mov	r9, r0
}
c0d02c1c:	4770      	bx	lr
	...

c0d02c20 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_channel;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d02c20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c22:	b081      	sub	sp, #4
c0d02c24:	9200      	str	r2, [sp, #0]
c0d02c26:	460f      	mov	r7, r1
c0d02c28:	4605      	mov	r5, r0
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
c0d02c2a:	4b49      	ldr	r3, [pc, #292]	; (c0d02d50 <io_usb_hid_receive+0x130>)
c0d02c2c:	429f      	cmp	r7, r3
c0d02c2e:	d00f      	beq.n	c0d02c50 <io_usb_hid_receive+0x30>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d02c30:	4c47      	ldr	r4, [pc, #284]	; (c0d02d50 <io_usb_hid_receive+0x130>)
c0d02c32:	2640      	movs	r6, #64	; 0x40
c0d02c34:	4620      	mov	r0, r4
c0d02c36:	4631      	mov	r1, r6
c0d02c38:	f001 fe90 	bl	c0d0495c <__aeabi_memclr>
c0d02c3c:	9800      	ldr	r0, [sp, #0]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
    os_memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
c0d02c3e:	2840      	cmp	r0, #64	; 0x40
c0d02c40:	4602      	mov	r2, r0
c0d02c42:	d300      	bcc.n	c0d02c46 <io_usb_hid_receive+0x26>
c0d02c44:	4632      	mov	r2, r6
c0d02c46:	4620      	mov	r0, r4
c0d02c48:	4639      	mov	r1, r7
c0d02c4a:	f000 f89c 	bl	c0d02d86 <os_memmove>
c0d02c4e:	4b40      	ldr	r3, [pc, #256]	; (c0d02d50 <io_usb_hid_receive+0x130>)
c0d02c50:	7898      	ldrb	r0, [r3, #2]
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d02c52:	2801      	cmp	r0, #1
c0d02c54:	dc0b      	bgt.n	c0d02c6e <io_usb_hid_receive+0x4e>
c0d02c56:	2800      	cmp	r0, #0
c0d02c58:	d02a      	beq.n	c0d02cb0 <io_usb_hid_receive+0x90>
c0d02c5a:	2801      	cmp	r0, #1
c0d02c5c:	d16a      	bne.n	c0d02d34 <io_usb_hid_receive+0x114>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_usb_ep_buffer+3, 4);
c0d02c5e:	1cd8      	adds	r0, r3, #3
c0d02c60:	2104      	movs	r1, #4
c0d02c62:	461c      	mov	r4, r3
c0d02c64:	f000 fdbc 	bl	c0d037e0 <cx_rng>
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d02c68:	2140      	movs	r1, #64	; 0x40
c0d02c6a:	4620      	mov	r0, r4
c0d02c6c:	e02b      	b.n	c0d02cc6 <io_usb_hid_receive+0xa6>
c0d02c6e:	2802      	cmp	r0, #2
c0d02c70:	d027      	beq.n	c0d02cc2 <io_usb_hid_receive+0xa2>
c0d02c72:	2805      	cmp	r0, #5
c0d02c74:	d15e      	bne.n	c0d02d34 <io_usb_hid_receive+0x114>

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
c0d02c76:	7918      	ldrb	r0, [r3, #4]
c0d02c78:	78d9      	ldrb	r1, [r3, #3]
c0d02c7a:	0209      	lsls	r1, r1, #8
c0d02c7c:	4301      	orrs	r1, r0
c0d02c7e:	4a35      	ldr	r2, [pc, #212]	; (c0d02d54 <io_usb_hid_receive+0x134>)
c0d02c80:	6810      	ldr	r0, [r2, #0]
c0d02c82:	2400      	movs	r4, #0
c0d02c84:	4281      	cmp	r1, r0
c0d02c86:	d15b      	bne.n	c0d02d40 <io_usb_hid_receive+0x120>
c0d02c88:	4e33      	ldr	r6, [pc, #204]	; (c0d02d58 <io_usb_hid_receive+0x138>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d02c8a:	9800      	ldr	r0, [sp, #0]
c0d02c8c:	1980      	adds	r0, r0, r6
c0d02c8e:	1f07      	subs	r7, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d02c90:	6810      	ldr	r0, [r2, #0]
c0d02c92:	2800      	cmp	r0, #0
c0d02c94:	d01a      	beq.n	c0d02ccc <io_usb_hid_receive+0xac>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d02c96:	4639      	mov	r1, r7
c0d02c98:	4031      	ands	r1, r6
c0d02c9a:	4830      	ldr	r0, [pc, #192]	; (c0d02d5c <io_usb_hid_receive+0x13c>)
c0d02c9c:	6802      	ldr	r2, [r0, #0]
c0d02c9e:	4291      	cmp	r1, r2
c0d02ca0:	d900      	bls.n	c0d02ca4 <io_usb_hid_receive+0x84>
        l = G_io_usb_hid_remaining_length;
c0d02ca2:	6807      	ldr	r7, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
c0d02ca4:	463a      	mov	r2, r7
c0d02ca6:	4032      	ands	r2, r6
c0d02ca8:	482d      	ldr	r0, [pc, #180]	; (c0d02d60 <io_usb_hid_receive+0x140>)
c0d02caa:	6800      	ldr	r0, [r0, #0]
c0d02cac:	1d59      	adds	r1, r3, #5
c0d02cae:	e031      	b.n	c0d02d14 <io_usb_hid_receive+0xf4>
c0d02cb0:	2400      	movs	r4, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d02cb2:	719c      	strb	r4, [r3, #6]
c0d02cb4:	715c      	strb	r4, [r3, #5]
c0d02cb6:	711c      	strb	r4, [r3, #4]
c0d02cb8:	70dc      	strb	r4, [r3, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_usb_ep_buffer+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d02cba:	2140      	movs	r1, #64	; 0x40
c0d02cbc:	4618      	mov	r0, r3
c0d02cbe:	47a8      	blx	r5
c0d02cc0:	e03e      	b.n	c0d02d40 <io_usb_hid_receive+0x120>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d02cc2:	4823      	ldr	r0, [pc, #140]	; (c0d02d50 <io_usb_hid_receive+0x130>)
c0d02cc4:	2140      	movs	r1, #64	; 0x40
c0d02cc6:	47a8      	blx	r5
c0d02cc8:	2400      	movs	r4, #0
c0d02cca:	e039      	b.n	c0d02d40 <io_usb_hid_receive+0x120>
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = U2BE(G_io_usb_ep_buffer, 5); //(G_io_usb_ep_buffer[5]<<8)+(G_io_usb_ep_buffer[6]&0xFF);
c0d02ccc:	7998      	ldrb	r0, [r3, #6]
c0d02cce:	7959      	ldrb	r1, [r3, #5]
c0d02cd0:	0209      	lsls	r1, r1, #8
c0d02cd2:	4301      	orrs	r1, r0
c0d02cd4:	4823      	ldr	r0, [pc, #140]	; (c0d02d64 <io_usb_hid_receive+0x144>)
c0d02cd6:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d02cd8:	6801      	ldr	r1, [r0, #0]
c0d02cda:	2241      	movs	r2, #65	; 0x41
c0d02cdc:	0092      	lsls	r2, r2, #2
c0d02cde:	4291      	cmp	r1, r2
c0d02ce0:	d82e      	bhi.n	c0d02d40 <io_usb_hid_receive+0x120>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d02ce2:	6801      	ldr	r1, [r0, #0]
c0d02ce4:	481d      	ldr	r0, [pc, #116]	; (c0d02d5c <io_usb_hid_receive+0x13c>)
c0d02ce6:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d02ce8:	491d      	ldr	r1, [pc, #116]	; (c0d02d60 <io_usb_hid_receive+0x140>)
c0d02cea:	4a1f      	ldr	r2, [pc, #124]	; (c0d02d68 <io_usb_hid_receive+0x148>)
c0d02cec:	600a      	str	r2, [r1, #0]

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);
c0d02cee:	7859      	ldrb	r1, [r3, #1]
c0d02cf0:	781a      	ldrb	r2, [r3, #0]
c0d02cf2:	0212      	lsls	r2, r2, #8
c0d02cf4:	430a      	orrs	r2, r1
c0d02cf6:	491d      	ldr	r1, [pc, #116]	; (c0d02d6c <io_usb_hid_receive+0x14c>)
c0d02cf8:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d02cfa:	491d      	ldr	r1, [pc, #116]	; (c0d02d70 <io_usb_hid_receive+0x150>)
c0d02cfc:	9a00      	ldr	r2, [sp, #0]
c0d02cfe:	1857      	adds	r7, r2, r1
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);

      if (l > G_io_usb_hid_remaining_length) {
c0d02d00:	4639      	mov	r1, r7
c0d02d02:	4031      	ands	r1, r6
c0d02d04:	6802      	ldr	r2, [r0, #0]
c0d02d06:	4291      	cmp	r1, r2
c0d02d08:	d900      	bls.n	c0d02d0c <io_usb_hid_receive+0xec>
        l = G_io_usb_hid_remaining_length;
c0d02d0a:	6807      	ldr	r7, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
c0d02d0c:	463a      	mov	r2, r7
c0d02d0e:	4032      	ands	r2, r6
c0d02d10:	1dd9      	adds	r1, r3, #7
c0d02d12:	4815      	ldr	r0, [pc, #84]	; (c0d02d68 <io_usb_hid_receive+0x148>)
c0d02d14:	f000 f837 	bl	c0d02d86 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d02d18:	4037      	ands	r7, r6
c0d02d1a:	4811      	ldr	r0, [pc, #68]	; (c0d02d60 <io_usb_hid_receive+0x140>)
c0d02d1c:	6801      	ldr	r1, [r0, #0]
c0d02d1e:	19c9      	adds	r1, r1, r7
c0d02d20:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d02d22:	480e      	ldr	r0, [pc, #56]	; (c0d02d5c <io_usb_hid_receive+0x13c>)
c0d02d24:	6801      	ldr	r1, [r0, #0]
c0d02d26:	1bc9      	subs	r1, r1, r7
c0d02d28:	6001      	str	r1, [r0, #0]
c0d02d2a:	480a      	ldr	r0, [pc, #40]	; (c0d02d54 <io_usb_hid_receive+0x134>)
c0d02d2c:	4601      	mov	r1, r0
    G_io_usb_hid_sequence_number++;
c0d02d2e:	6808      	ldr	r0, [r1, #0]
c0d02d30:	1c40      	adds	r0, r0, #1
c0d02d32:	6008      	str	r0, [r1, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d02d34:	4809      	ldr	r0, [pc, #36]	; (c0d02d5c <io_usb_hid_receive+0x13c>)
c0d02d36:	6801      	ldr	r1, [r0, #0]
c0d02d38:	2001      	movs	r0, #1
c0d02d3a:	2402      	movs	r4, #2
c0d02d3c:	2900      	cmp	r1, #0
c0d02d3e:	d103      	bne.n	c0d02d48 <io_usb_hid_receive+0x128>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d02d40:	4804      	ldr	r0, [pc, #16]	; (c0d02d54 <io_usb_hid_receive+0x134>)
c0d02d42:	2100      	movs	r1, #0
c0d02d44:	6001      	str	r1, [r0, #0]
c0d02d46:	4620      	mov	r0, r4
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d02d48:	b2c0      	uxtb	r0, r0
c0d02d4a:	b001      	add	sp, #4
c0d02d4c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02d4e:	46c0      	nop			; (mov r8, r8)
c0d02d50:	20001b78 	.word	0x20001b78
c0d02d54:	20001a38 	.word	0x20001a38
c0d02d58:	0000ffff 	.word	0x0000ffff
c0d02d5c:	20001a40 	.word	0x20001a40
c0d02d60:	20001b48 	.word	0x20001b48
c0d02d64:	20001a3c 	.word	0x20001a3c
c0d02d68:	20001a44 	.word	0x20001a44
c0d02d6c:	20001b4c 	.word	0x20001b4c
c0d02d70:	0001fff9 	.word	0x0001fff9

c0d02d74 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d02d74:	b580      	push	{r7, lr}
c0d02d76:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d02d78:	2a00      	cmp	r2, #0
c0d02d7a:	d003      	beq.n	c0d02d84 <os_memset+0x10>
    DSTCHAR[length] = c;
c0d02d7c:	4611      	mov	r1, r2
c0d02d7e:	461a      	mov	r2, r3
c0d02d80:	f001 fdf6 	bl	c0d04970 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d02d84:	bd80      	pop	{r7, pc}

c0d02d86 <os_memmove>:
  }
}

#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d02d86:	b5b0      	push	{r4, r5, r7, lr}
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d02d88:	4288      	cmp	r0, r1
c0d02d8a:	d90d      	bls.n	c0d02da8 <os_memmove+0x22>
    while(length--) {
c0d02d8c:	2a00      	cmp	r2, #0
c0d02d8e:	d014      	beq.n	c0d02dba <os_memmove+0x34>
c0d02d90:	1e49      	subs	r1, r1, #1
c0d02d92:	4252      	negs	r2, r2
c0d02d94:	1e40      	subs	r0, r0, #1
c0d02d96:	2300      	movs	r3, #0
c0d02d98:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d02d9a:	461c      	mov	r4, r3
c0d02d9c:	4354      	muls	r4, r2
c0d02d9e:	5d0d      	ldrb	r5, [r1, r4]
c0d02da0:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d02da2:	1c52      	adds	r2, r2, #1
c0d02da4:	d1f9      	bne.n	c0d02d9a <os_memmove+0x14>
c0d02da6:	e008      	b.n	c0d02dba <os_memmove+0x34>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d02da8:	2a00      	cmp	r2, #0
c0d02daa:	d006      	beq.n	c0d02dba <os_memmove+0x34>
c0d02dac:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d02dae:	b29c      	uxth	r4, r3
c0d02db0:	5d0d      	ldrb	r5, [r1, r4]
c0d02db2:	5505      	strb	r5, [r0, r4]
      l++;
c0d02db4:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d02db6:	1e52      	subs	r2, r2, #1
c0d02db8:	d1f9      	bne.n	c0d02dae <os_memmove+0x28>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d02dba:	bdb0      	pop	{r4, r5, r7, pc}

c0d02dbc <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d02dbc:	4801      	ldr	r0, [pc, #4]	; (c0d02dc4 <io_usb_hid_init+0x8>)
c0d02dbe:	2100      	movs	r1, #0
c0d02dc0:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d02dc2:	4770      	bx	lr
c0d02dc4:	20001a38 	.word	0x20001a38

c0d02dc8 <io_usb_hid_sent>:

/**
 * sent the next io_usb_hid transport chunk (rx on the host, tx on the device)
 */
void io_usb_hid_sent(io_send_t sndfct) {
c0d02dc8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02dca:	b081      	sub	sp, #4
  unsigned int l;

  // only prepare next chunk if some data to be sent remain
  if (G_io_usb_hid_remaining_length) {
c0d02dcc:	4f29      	ldr	r7, [pc, #164]	; (c0d02e74 <io_usb_hid_sent+0xac>)
c0d02dce:	6839      	ldr	r1, [r7, #0]
c0d02dd0:	2900      	cmp	r1, #0
c0d02dd2:	d026      	beq.n	c0d02e22 <io_usb_hid_sent+0x5a>
c0d02dd4:	9000      	str	r0, [sp, #0]
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d02dd6:	4c28      	ldr	r4, [pc, #160]	; (c0d02e78 <io_usb_hid_sent+0xb0>)
c0d02dd8:	1d66      	adds	r6, r4, #5
c0d02dda:	2539      	movs	r5, #57	; 0x39
c0d02ddc:	4630      	mov	r0, r6
c0d02dde:	4629      	mov	r1, r5
c0d02de0:	f001 fdbc 	bl	c0d0495c <__aeabi_memclr>
  if (G_io_usb_hid_remaining_length) {
    // fill the chunk
    os_memset(G_io_usb_ep_buffer, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
c0d02de4:	4825      	ldr	r0, [pc, #148]	; (c0d02e7c <io_usb_hid_sent+0xb4>)
c0d02de6:	6801      	ldr	r1, [r0, #0]
c0d02de8:	0a09      	lsrs	r1, r1, #8
c0d02dea:	7021      	strb	r1, [r4, #0]
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
c0d02dec:	6800      	ldr	r0, [r0, #0]
c0d02dee:	7060      	strb	r0, [r4, #1]
c0d02df0:	2005      	movs	r0, #5
    G_io_usb_ep_buffer[2] = 0x05;
c0d02df2:	70a0      	strb	r0, [r4, #2]
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
c0d02df4:	4a22      	ldr	r2, [pc, #136]	; (c0d02e80 <io_usb_hid_sent+0xb8>)
c0d02df6:	6810      	ldr	r0, [r2, #0]
c0d02df8:	0a00      	lsrs	r0, r0, #8
c0d02dfa:	70e0      	strb	r0, [r4, #3]
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;
c0d02dfc:	6810      	ldr	r0, [r2, #0]
c0d02dfe:	7120      	strb	r0, [r4, #4]

    if (G_io_usb_hid_sequence_number == 0) {
c0d02e00:	6811      	ldr	r1, [r2, #0]
c0d02e02:	6838      	ldr	r0, [r7, #0]
c0d02e04:	2900      	cmp	r1, #0
c0d02e06:	d014      	beq.n	c0d02e32 <io_usb_hid_sent+0x6a>
c0d02e08:	4614      	mov	r4, r2
c0d02e0a:	253b      	movs	r5, #59	; 0x3b
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
      l += 7;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d02e0c:	283b      	cmp	r0, #59	; 0x3b
c0d02e0e:	d800      	bhi.n	c0d02e12 <io_usb_hid_sent+0x4a>
c0d02e10:	683d      	ldr	r5, [r7, #0]
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d02e12:	481c      	ldr	r0, [pc, #112]	; (c0d02e84 <io_usb_hid_sent+0xbc>)
c0d02e14:	6801      	ldr	r1, [r0, #0]
c0d02e16:	4630      	mov	r0, r6
c0d02e18:	462a      	mov	r2, r5
c0d02e1a:	f7ff ffb4 	bl	c0d02d86 <os_memmove>
c0d02e1e:	9a00      	ldr	r2, [sp, #0]
c0d02e20:	e018      	b.n	c0d02e54 <io_usb_hid_sent+0x8c>
    // always pad :)
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
  }
  // cleanup when everything has been sent (ack for the last sent usb in packet)
  else {
    G_io_usb_hid_sequence_number = 0; 
c0d02e22:	4817      	ldr	r0, [pc, #92]	; (c0d02e80 <io_usb_hid_sent+0xb8>)
c0d02e24:	2100      	movs	r1, #0
c0d02e26:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_current_buffer = NULL;
c0d02e28:	4816      	ldr	r0, [pc, #88]	; (c0d02e84 <io_usb_hid_sent+0xbc>)
c0d02e2a:	6001      	str	r1, [r0, #0]

    // we sent the whole response
    G_io_apdu_state = APDU_IDLE;
c0d02e2c:	4816      	ldr	r0, [pc, #88]	; (c0d02e88 <io_usb_hid_sent+0xc0>)
c0d02e2e:	7001      	strb	r1, [r0, #0]
c0d02e30:	e01d      	b.n	c0d02e6e <io_usb_hid_sent+0xa6>
c0d02e32:	4616      	mov	r6, r2
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d02e34:	2839      	cmp	r0, #57	; 0x39
c0d02e36:	d800      	bhi.n	c0d02e3a <io_usb_hid_sent+0x72>
c0d02e38:	683d      	ldr	r5, [r7, #0]
      G_io_usb_ep_buffer[5] = G_io_usb_hid_remaining_length>>8;
c0d02e3a:	6838      	ldr	r0, [r7, #0]
c0d02e3c:	0a00      	lsrs	r0, r0, #8
c0d02e3e:	7160      	strb	r0, [r4, #5]
      G_io_usb_ep_buffer[6] = G_io_usb_hid_remaining_length;
c0d02e40:	6838      	ldr	r0, [r7, #0]
c0d02e42:	71a0      	strb	r0, [r4, #6]
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d02e44:	480f      	ldr	r0, [pc, #60]	; (c0d02e84 <io_usb_hid_sent+0xbc>)
c0d02e46:	6801      	ldr	r1, [r0, #0]
c0d02e48:	1de0      	adds	r0, r4, #7
c0d02e4a:	462a      	mov	r2, r5
c0d02e4c:	f7ff ff9b 	bl	c0d02d86 <os_memmove>
c0d02e50:	9a00      	ldr	r2, [sp, #0]
c0d02e52:	4634      	mov	r4, r6
c0d02e54:	480b      	ldr	r0, [pc, #44]	; (c0d02e84 <io_usb_hid_sent+0xbc>)
c0d02e56:	6801      	ldr	r1, [r0, #0]
c0d02e58:	1949      	adds	r1, r1, r5
c0d02e5a:	6001      	str	r1, [r0, #0]
c0d02e5c:	6838      	ldr	r0, [r7, #0]
c0d02e5e:	1b40      	subs	r0, r0, r5
c0d02e60:	6038      	str	r0, [r7, #0]
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d02e62:	6820      	ldr	r0, [r4, #0]
c0d02e64:	1c40      	adds	r0, r0, #1
c0d02e66:	6020      	str	r0, [r4, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
c0d02e68:	4803      	ldr	r0, [pc, #12]	; (c0d02e78 <io_usb_hid_sent+0xb0>)
c0d02e6a:	2140      	movs	r1, #64	; 0x40
c0d02e6c:	4790      	blx	r2
    G_io_usb_hid_current_buffer = NULL;

    // we sent the whole response
    G_io_apdu_state = APDU_IDLE;
  }
}
c0d02e6e:	b001      	add	sp, #4
c0d02e70:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02e72:	46c0      	nop			; (mov r8, r8)
c0d02e74:	20001a40 	.word	0x20001a40
c0d02e78:	20001b78 	.word	0x20001b78
c0d02e7c:	20001b4c 	.word	0x20001b4c
c0d02e80:	20001a38 	.word	0x20001a38
c0d02e84:	20001b48 	.word	0x20001b48
c0d02e88:	20001b66 	.word	0x20001b66

c0d02e8c <io_usb_hid_send>:

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
c0d02e8c:	b580      	push	{r7, lr}
  // perform send
  if (sndlength) {
c0d02e8e:	2900      	cmp	r1, #0
c0d02e90:	d00b      	beq.n	c0d02eaa <io_usb_hid_send+0x1e>
    G_io_usb_hid_sequence_number = 0; 
c0d02e92:	4a06      	ldr	r2, [pc, #24]	; (c0d02eac <io_usb_hid_send+0x20>)
c0d02e94:	2300      	movs	r3, #0
c0d02e96:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d02e98:	4a05      	ldr	r2, [pc, #20]	; (c0d02eb0 <io_usb_hid_send+0x24>)
c0d02e9a:	4b06      	ldr	r3, [pc, #24]	; (c0d02eb4 <io_usb_hid_send+0x28>)
c0d02e9c:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_remaining_length = sndlength;
c0d02e9e:	4a06      	ldr	r2, [pc, #24]	; (c0d02eb8 <io_usb_hid_send+0x2c>)
c0d02ea0:	6011      	str	r1, [r2, #0]
    G_io_usb_hid_total_length = sndlength;
c0d02ea2:	4a06      	ldr	r2, [pc, #24]	; (c0d02ebc <io_usb_hid_send+0x30>)
c0d02ea4:	6011      	str	r1, [r2, #0]
    io_usb_hid_sent(sndfct);
c0d02ea6:	f7ff ff8f 	bl	c0d02dc8 <io_usb_hid_sent>
  }
}
c0d02eaa:	bd80      	pop	{r7, pc}
c0d02eac:	20001a38 	.word	0x20001a38
c0d02eb0:	20001b48 	.word	0x20001b48
c0d02eb4:	20001a44 	.word	0x20001a44
c0d02eb8:	20001a40 	.word	0x20001a40
c0d02ebc:	20001a3c 	.word	0x20001a3c

c0d02ec0 <os_memcmp>:
    DSTCHAR[length] = c;
  }
#undef DSTCHAR
}

char os_memcmp(const void WIDE * buf1, const void WIDE * buf2, unsigned int length) {
c0d02ec0:	b570      	push	{r4, r5, r6, lr}
#define BUF1 ((unsigned char const WIDE *)buf1)
#define BUF2 ((unsigned char const WIDE *)buf2)
  while(length--) {
c0d02ec2:	1e43      	subs	r3, r0, #1
c0d02ec4:	1e49      	subs	r1, r1, #1
c0d02ec6:	4252      	negs	r2, r2
c0d02ec8:	2000      	movs	r0, #0
c0d02eca:	43c4      	mvns	r4, r0
c0d02ecc:	2a00      	cmp	r2, #0
c0d02ece:	d00c      	beq.n	c0d02eea <os_memcmp+0x2a>
    if (BUF1[length] != BUF2[length]) {
c0d02ed0:	4626      	mov	r6, r4
c0d02ed2:	4356      	muls	r6, r2
c0d02ed4:	5d8d      	ldrb	r5, [r1, r6]
c0d02ed6:	5d9e      	ldrb	r6, [r3, r6]
c0d02ed8:	1c52      	adds	r2, r2, #1
c0d02eda:	42ae      	cmp	r6, r5
c0d02edc:	d0f6      	beq.n	c0d02ecc <os_memcmp+0xc>
      return (BUF1[length] > BUF2[length])? 1:-1;
c0d02ede:	2000      	movs	r0, #0
c0d02ee0:	43c1      	mvns	r1, r0
c0d02ee2:	2001      	movs	r0, #1
c0d02ee4:	42ae      	cmp	r6, r5
c0d02ee6:	d800      	bhi.n	c0d02eea <os_memcmp+0x2a>
c0d02ee8:	4608      	mov	r0, r1
  }
  return 0;
#undef BUF1
#undef BUF2

}
c0d02eea:	b2c0      	uxtb	r0, r0
c0d02eec:	bd70      	pop	{r4, r5, r6, pc}

c0d02eee <os_longjmp>:
void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d02eee:	b580      	push	{r7, lr}
c0d02ef0:	4601      	mov	r1, r0
  return xoracc;
}

try_context_t* try_context_get(void) {
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d02ef2:	4648      	mov	r0, r9
  __asm volatile ("mov r9, %0"::"r"(ctx));
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
  longjmp(try_context_get()->jmp_buf, exception);
c0d02ef4:	f001 fdd4 	bl	c0d04aa0 <longjmp>

c0d02ef8 <try_context_get>:
  return xoracc;
}

try_context_t* try_context_get(void) {
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d02ef8:	4648      	mov	r0, r9
  return current_ctx;
c0d02efa:	4770      	bx	lr

c0d02efc <try_context_get_previous>:
}

try_context_t* try_context_get_previous(void) {
c0d02efc:	2000      	movs	r0, #0
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d02efe:	4649      	mov	r1, r9

  // first context reached ?
  if (current_ctx == NULL) {
c0d02f00:	2900      	cmp	r1, #0
c0d02f02:	d000      	beq.n	c0d02f06 <try_context_get_previous+0xa>
  }

  // return r9 content saved on the current context. It links to the previous context.
  // r4 r5 r6 r7 r8 r9 r10 r11 sp lr
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
c0d02f04:	6948      	ldr	r0, [r1, #20]
}
c0d02f06:	4770      	bx	lr

c0d02f08 <io_seproxyhal_general_status>:

#ifndef IO_RAPDU_TRANSMIT_TIMEOUT_MS 
#define IO_RAPDU_TRANSMIT_TIMEOUT_MS 2000UL
#endif // IO_RAPDU_TRANSMIT_TIMEOUT_MS

void io_seproxyhal_general_status(void) {
c0d02f08:	b580      	push	{r7, lr}
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d02f0a:	f000 fd51 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d02f0e:	2800      	cmp	r0, #0
c0d02f10:	d10b      	bne.n	c0d02f2a <io_seproxyhal_general_status+0x22>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d02f12:	4806      	ldr	r0, [pc, #24]	; (c0d02f2c <io_seproxyhal_general_status+0x24>)
c0d02f14:	2160      	movs	r1, #96	; 0x60
c0d02f16:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02f18:	2100      	movs	r1, #0
c0d02f1a:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d02f1c:	2202      	movs	r2, #2
c0d02f1e:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d02f20:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d02f22:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d02f24:	2105      	movs	r1, #5
c0d02f26:	f000 fd2d 	bl	c0d03984 <io_seproxyhal_spi_send>
}
c0d02f2a:	bd80      	pop	{r7, pc}
c0d02f2c:	20001800 	.word	0x20001800

c0d02f30 <io_seproxyhal_handle_usb_event>:
} G_io_usb_ep_timeouts[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d02f30:	b510      	push	{r4, lr}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d02f32:	4819      	ldr	r0, [pc, #100]	; (c0d02f98 <io_seproxyhal_handle_usb_event+0x68>)
c0d02f34:	78c0      	ldrb	r0, [r0, #3]
c0d02f36:	2803      	cmp	r0, #3
c0d02f38:	dc07      	bgt.n	c0d02f4a <io_seproxyhal_handle_usb_event+0x1a>
c0d02f3a:	2801      	cmp	r0, #1
c0d02f3c:	d00d      	beq.n	c0d02f5a <io_seproxyhal_handle_usb_event+0x2a>
c0d02f3e:	2802      	cmp	r0, #2
c0d02f40:	d126      	bne.n	c0d02f90 <io_seproxyhal_handle_usb_event+0x60>
      }
      os_memset(G_io_usb_ep_xfer_len, 0, sizeof(G_io_usb_ep_xfer_len));
      os_memset(G_io_usb_ep_timeouts, 0, sizeof(G_io_usb_ep_timeouts));
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d02f42:	4816      	ldr	r0, [pc, #88]	; (c0d02f9c <io_seproxyhal_handle_usb_event+0x6c>)
c0d02f44:	f001 f837 	bl	c0d03fb6 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d02f48:	bd10      	pop	{r4, pc}
c0d02f4a:	2804      	cmp	r0, #4
c0d02f4c:	d01d      	beq.n	c0d02f8a <io_seproxyhal_handle_usb_event+0x5a>
c0d02f4e:	2808      	cmp	r0, #8
c0d02f50:	d11e      	bne.n	c0d02f90 <io_seproxyhal_handle_usb_event+0x60>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d02f52:	4812      	ldr	r0, [pc, #72]	; (c0d02f9c <io_seproxyhal_handle_usb_event+0x6c>)
c0d02f54:	f001 f82d 	bl	c0d03fb2 <USBD_LL_Resume>
      break;
  }
}
c0d02f58:	bd10      	pop	{r4, pc}
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
  switch(G_io_seproxyhal_spi_buffer[3]) {
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d02f5a:	4c10      	ldr	r4, [pc, #64]	; (c0d02f9c <io_seproxyhal_handle_usb_event+0x6c>)
c0d02f5c:	2101      	movs	r1, #1
c0d02f5e:	4620      	mov	r0, r4
c0d02f60:	f001 f822 	bl	c0d03fa8 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d02f64:	4620      	mov	r0, r4
c0d02f66:	f000 fffe 	bl	c0d03f66 <USBD_LL_Reset>
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d02f6a:	480d      	ldr	r0, [pc, #52]	; (c0d02fa0 <io_seproxyhal_handle_usb_event+0x70>)
c0d02f6c:	7800      	ldrb	r0, [r0, #0]
c0d02f6e:	2800      	cmp	r0, #0
c0d02f70:	d10f      	bne.n	c0d02f92 <io_seproxyhal_handle_usb_event+0x62>
        THROW(EXCEPTION_IO_RESET);
      }
      os_memset(G_io_usb_ep_xfer_len, 0, sizeof(G_io_usb_ep_xfer_len));
c0d02f72:	480c      	ldr	r0, [pc, #48]	; (c0d02fa4 <io_seproxyhal_handle_usb_event+0x74>)
c0d02f74:	2400      	movs	r4, #0
c0d02f76:	2207      	movs	r2, #7
c0d02f78:	4621      	mov	r1, r4
c0d02f7a:	f7ff fefb 	bl	c0d02d74 <os_memset>
      os_memset(G_io_usb_ep_timeouts, 0, sizeof(G_io_usb_ep_timeouts));
c0d02f7e:	480a      	ldr	r0, [pc, #40]	; (c0d02fa8 <io_seproxyhal_handle_usb_event+0x78>)
c0d02f80:	220e      	movs	r2, #14
c0d02f82:	4621      	mov	r1, r4
c0d02f84:	f7ff fef6 	bl	c0d02d74 <os_memset>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d02f88:	bd10      	pop	{r4, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d02f8a:	4804      	ldr	r0, [pc, #16]	; (c0d02f9c <io_seproxyhal_handle_usb_event+0x6c>)
c0d02f8c:	f001 f80f 	bl	c0d03fae <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d02f90:	bd10      	pop	{r4, pc}
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
      USBD_LL_Reset(&USBD_Device);
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
        THROW(EXCEPTION_IO_RESET);
c0d02f92:	2010      	movs	r0, #16
c0d02f94:	f7ff ffab 	bl	c0d02eee <os_longjmp>
c0d02f98:	20001800 	.word	0x20001800
c0d02f9c:	20001bc0 	.word	0x20001bc0
c0d02fa0:	20001b50 	.word	0x20001b50
c0d02fa4:	20001b51 	.word	0x20001b51
c0d02fa8:	20001b58 	.word	0x20001b58

c0d02fac <io_seproxyhal_get_ep_rx_size>:
      break;
  }
}

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d02fac:	217f      	movs	r1, #127	; 0x7f
c0d02fae:	4001      	ands	r1, r0
c0d02fb0:	4801      	ldr	r0, [pc, #4]	; (c0d02fb8 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d02fb2:	5c40      	ldrb	r0, [r0, r1]
c0d02fb4:	4770      	bx	lr
c0d02fb6:	46c0      	nop			; (mov r8, r8)
c0d02fb8:	20001b51 	.word	0x20001b51

c0d02fbc <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d02fbc:	b510      	push	{r4, lr}
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d02fbe:	4815      	ldr	r0, [pc, #84]	; (c0d03014 <io_seproxyhal_handle_usb_ep_xfer_event+0x58>)
c0d02fc0:	7901      	ldrb	r1, [r0, #4]
c0d02fc2:	2904      	cmp	r1, #4
c0d02fc4:	d017      	beq.n	c0d02ff6 <io_seproxyhal_handle_usb_ep_xfer_event+0x3a>
c0d02fc6:	2902      	cmp	r1, #2
c0d02fc8:	d006      	beq.n	c0d02fd8 <io_seproxyhal_handle_usb_ep_xfer_event+0x1c>
c0d02fca:	2901      	cmp	r1, #1
c0d02fcc:	d120      	bne.n	c0d03010 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
    /* This event is received when a new SETUP token had been received on a control endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d02fce:	1d81      	adds	r1, r0, #6
c0d02fd0:	4812      	ldr	r0, [pc, #72]	; (c0d0301c <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d02fd2:	f000 fec1 	bl	c0d03d58 <USBD_LL_SetupStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d02fd6:	bd10      	pop	{r4, pc}
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    /* This event is received after the prepare data packet has been flushed to the usb host */
    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d02fd8:	78c2      	ldrb	r2, [r0, #3]
c0d02fda:	217f      	movs	r1, #127	; 0x7f
c0d02fdc:	4011      	ands	r1, r2
c0d02fde:	2906      	cmp	r1, #6
c0d02fe0:	d816      	bhi.n	c0d03010 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
c0d02fe2:	b2c9      	uxtb	r1, r1
        // discard ep timeout as we received the sent packet confirmation
        G_io_usb_ep_timeouts[G_io_seproxyhal_spi_buffer[3]&0x7F].timeout = 0;
c0d02fe4:	004a      	lsls	r2, r1, #1
c0d02fe6:	4b0e      	ldr	r3, [pc, #56]	; (c0d03020 <io_seproxyhal_handle_usb_ep_xfer_event+0x64>)
c0d02fe8:	2400      	movs	r4, #0
c0d02fea:	529c      	strh	r4, [r3, r2]
        // propagate sending ack of the data
        USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d02fec:	1d82      	adds	r2, r0, #6
c0d02fee:	480b      	ldr	r0, [pc, #44]	; (c0d0301c <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d02ff0:	f000 ff40 	bl	c0d03e74 <USBD_LL_DataInStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d02ff4:	bd10      	pop	{r4, pc}
      }
      break;

    /* This event is received when a new DATA token is received on an endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d02ff6:	78c2      	ldrb	r2, [r0, #3]
c0d02ff8:	217f      	movs	r1, #127	; 0x7f
c0d02ffa:	4011      	ands	r1, r2
c0d02ffc:	2906      	cmp	r1, #6
c0d02ffe:	d807      	bhi.n	c0d03010 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        // saved just in case it is needed ...
        G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d03000:	7942      	ldrb	r2, [r0, #5]
      }
      break;

    /* This event is received when a new DATA token is received on an endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d03002:	b2c9      	uxtb	r1, r1
        // saved just in case it is needed ...
        G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d03004:	4b04      	ldr	r3, [pc, #16]	; (c0d03018 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d03006:	545a      	strb	r2, [r3, r1]
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d03008:	1d82      	adds	r2, r0, #6
c0d0300a:	4804      	ldr	r0, [pc, #16]	; (c0d0301c <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d0300c:	f000 fed3 	bl	c0d03db6 <USBD_LL_DataOutStage>
      }
      break;
  }
}
c0d03010:	bd10      	pop	{r4, pc}
c0d03012:	46c0      	nop			; (mov r8, r8)
c0d03014:	20001800 	.word	0x20001800
c0d03018:	20001b51 	.word	0x20001b51
c0d0301c:	20001bc0 	.word	0x20001bc0
c0d03020:	20001b58 	.word	0x20001b58

c0d03024 <io_usb_send_ep>:
#endif // HAVE_L4_USBLIB

// TODO, refactor this using the USB DataIn event like for the U2F tunnel
// TODO add a blocking parameter, for HID KBD sending, or use a USB busy flag per channel to know if 
// the transfer has been processed or not. and move on to the next transfer on the same endpoint
void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d03024:	b570      	push	{r4, r5, r6, lr}
c0d03026:	4615      	mov	r5, r2
c0d03028:	460e      	mov	r6, r1
c0d0302a:	4604      	mov	r4, r0
  if (timeout) {
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0302c:	2dff      	cmp	r5, #255	; 0xff
c0d0302e:	d81a      	bhi.n	c0d03066 <io_usb_send_ep+0x42>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d03030:	480d      	ldr	r0, [pc, #52]	; (c0d03068 <io_usb_send_ep+0x44>)
c0d03032:	2150      	movs	r1, #80	; 0x50
c0d03034:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d03036:	1ce9      	adds	r1, r5, #3
c0d03038:	0a0a      	lsrs	r2, r1, #8
c0d0303a:	7042      	strb	r2, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d0303c:	7081      	strb	r1, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d0303e:	2180      	movs	r1, #128	; 0x80
c0d03040:	4321      	orrs	r1, r4
c0d03042:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d03044:	2120      	movs	r1, #32
c0d03046:	7101      	strb	r1, [r0, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d03048:	7145      	strb	r5, [r0, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d0304a:	2106      	movs	r1, #6
c0d0304c:	f000 fc9a 	bl	c0d03984 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d03050:	4630      	mov	r0, r6
c0d03052:	4629      	mov	r1, r5
c0d03054:	f000 fc96 	bl	c0d03984 <io_seproxyhal_spi_send>
  // setup timeout of the endpoint
  G_io_usb_ep_timeouts[ep&0x7F].timeout = IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d03058:	207f      	movs	r0, #127	; 0x7f
c0d0305a:	4020      	ands	r0, r4
c0d0305c:	0040      	lsls	r0, r0, #1
c0d0305e:	217d      	movs	r1, #125	; 0x7d
c0d03060:	0109      	lsls	r1, r1, #4
c0d03062:	4a02      	ldr	r2, [pc, #8]	; (c0d0306c <io_usb_send_ep+0x48>)
c0d03064:	5211      	strh	r1, [r2, r0]

}
c0d03066:	bd70      	pop	{r4, r5, r6, pc}
c0d03068:	20001800 	.word	0x20001800
c0d0306c:	20001b58 	.word	0x20001b58

c0d03070 <io_usb_send_apdu_data>:

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d03070:	b580      	push	{r7, lr}
c0d03072:	460a      	mov	r2, r1
c0d03074:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d03076:	2082      	movs	r0, #130	; 0x82
c0d03078:	2314      	movs	r3, #20
c0d0307a:	f7ff ffd3 	bl	c0d03024 <io_usb_send_ep>
}
c0d0307e:	bd80      	pop	{r7, pc}

c0d03080 <io_seproxyhal_handle_capdu_event>:

}
#endif


void io_seproxyhal_handle_capdu_event(void) {
c0d03080:	b580      	push	{r7, lr}
  if(G_io_apdu_state == APDU_IDLE) 
c0d03082:	480e      	ldr	r0, [pc, #56]	; (c0d030bc <io_seproxyhal_handle_capdu_event+0x3c>)
c0d03084:	7801      	ldrb	r1, [r0, #0]
c0d03086:	2900      	cmp	r1, #0
c0d03088:	d116      	bne.n	c0d030b8 <io_seproxyhal_handle_capdu_event+0x38>
  {
    G_io_apdu_media = IO_APDU_MEDIA_RAW; // for application code
c0d0308a:	490d      	ldr	r1, [pc, #52]	; (c0d030c0 <io_seproxyhal_handle_capdu_event+0x40>)
c0d0308c:	2206      	movs	r2, #6
c0d0308e:	700a      	strb	r2, [r1, #0]
    G_io_apdu_state = APDU_RAW; // for next call to io_exchange
c0d03090:	210a      	movs	r1, #10
c0d03092:	7001      	strb	r1, [r0, #0]
    G_io_apdu_length = MIN(U2BE(G_io_seproxyhal_spi_buffer, 1), sizeof(G_io_apdu_buffer)); 
c0d03094:	480b      	ldr	r0, [pc, #44]	; (c0d030c4 <io_seproxyhal_handle_capdu_event+0x44>)
c0d03096:	7882      	ldrb	r2, [r0, #2]
c0d03098:	7841      	ldrb	r1, [r0, #1]
c0d0309a:	0209      	lsls	r1, r1, #8
c0d0309c:	4311      	orrs	r1, r2
c0d0309e:	088b      	lsrs	r3, r1, #2
c0d030a0:	2241      	movs	r2, #65	; 0x41
c0d030a2:	0092      	lsls	r2, r2, #2
c0d030a4:	2b41      	cmp	r3, #65	; 0x41
c0d030a6:	d300      	bcc.n	c0d030aa <io_seproxyhal_handle_capdu_event+0x2a>
c0d030a8:	4611      	mov	r1, r2
c0d030aa:	4a07      	ldr	r2, [pc, #28]	; (c0d030c8 <io_seproxyhal_handle_capdu_event+0x48>)
c0d030ac:	8011      	strh	r1, [r2, #0]
    // copy apdu to apdu buffer
    os_memmove(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_apdu_length);
c0d030ae:	8812      	ldrh	r2, [r2, #0]
c0d030b0:	1cc1      	adds	r1, r0, #3
c0d030b2:	4806      	ldr	r0, [pc, #24]	; (c0d030cc <io_seproxyhal_handle_capdu_event+0x4c>)
c0d030b4:	f7ff fe67 	bl	c0d02d86 <os_memmove>
  }
}
c0d030b8:	bd80      	pop	{r7, pc}
c0d030ba:	46c0      	nop			; (mov r8, r8)
c0d030bc:	20001b66 	.word	0x20001b66
c0d030c0:	20001b50 	.word	0x20001b50
c0d030c4:	20001800 	.word	0x20001800
c0d030c8:	20001b68 	.word	0x20001b68
c0d030cc:	20001a44 	.word	0x20001a44

c0d030d0 <io_seproxyhal_handle_event>:

unsigned int io_seproxyhal_handle_event(void) {
c0d030d0:	b5b0      	push	{r4, r5, r7, lr}
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d030d2:	481e      	ldr	r0, [pc, #120]	; (c0d0314c <io_seproxyhal_handle_event+0x7c>)
c0d030d4:	7882      	ldrb	r2, [r0, #2]
c0d030d6:	7841      	ldrb	r1, [r0, #1]
c0d030d8:	0209      	lsls	r1, r1, #8
c0d030da:	4311      	orrs	r1, r2
c0d030dc:	7800      	ldrb	r0, [r0, #0]

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d030de:	280f      	cmp	r0, #15
c0d030e0:	dc09      	bgt.n	c0d030f6 <io_seproxyhal_handle_event+0x26>
c0d030e2:	280e      	cmp	r0, #14
c0d030e4:	d00e      	beq.n	c0d03104 <io_seproxyhal_handle_event+0x34>
c0d030e6:	280f      	cmp	r0, #15
c0d030e8:	d11f      	bne.n	c0d0312a <io_seproxyhal_handle_event+0x5a>
c0d030ea:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 1) {
c0d030ec:	2901      	cmp	r1, #1
c0d030ee:	d126      	bne.n	c0d0313e <io_seproxyhal_handle_event+0x6e>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d030f0:	f7ff ff1e 	bl	c0d02f30 <io_seproxyhal_handle_usb_event>
c0d030f4:	e022      	b.n	c0d0313c <io_seproxyhal_handle_event+0x6c>
c0d030f6:	2810      	cmp	r0, #16
c0d030f8:	d01b      	beq.n	c0d03132 <io_seproxyhal_handle_event+0x62>
c0d030fa:	2816      	cmp	r0, #22
c0d030fc:	d115      	bne.n	c0d0312a <io_seproxyhal_handle_event+0x5a>
      }
      return 1;
  #endif // HAVE_BLE

    case SEPROXYHAL_TAG_CAPDU_EVENT:
      io_seproxyhal_handle_capdu_event();
c0d030fe:	f7ff ffbf 	bl	c0d03080 <io_seproxyhal_handle_capdu_event>
c0d03102:	e01b      	b.n	c0d0313c <io_seproxyhal_handle_event+0x6c>
c0d03104:	2000      	movs	r0, #0
c0d03106:	4912      	ldr	r1, [pc, #72]	; (c0d03150 <io_seproxyhal_handle_event+0x80>)
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
          if (G_io_usb_ep_timeouts[i].timeout) {
c0d03108:	1a0a      	subs	r2, r1, r0
c0d0310a:	8993      	ldrh	r3, [r2, #12]
c0d0310c:	2b00      	cmp	r3, #0
c0d0310e:	d009      	beq.n	c0d03124 <io_seproxyhal_handle_event+0x54>
            G_io_usb_ep_timeouts[i].timeout-=MIN(G_io_usb_ep_timeouts[i].timeout, 100);
c0d03110:	2464      	movs	r4, #100	; 0x64
c0d03112:	2b64      	cmp	r3, #100	; 0x64
c0d03114:	461d      	mov	r5, r3
c0d03116:	d300      	bcc.n	c0d0311a <io_seproxyhal_handle_event+0x4a>
c0d03118:	4625      	mov	r5, r4
c0d0311a:	1b5b      	subs	r3, r3, r5
c0d0311c:	8193      	strh	r3, [r2, #12]
c0d0311e:	4a0d      	ldr	r2, [pc, #52]	; (c0d03154 <io_seproxyhal_handle_event+0x84>)
            if (!G_io_usb_ep_timeouts[i].timeout) {
c0d03120:	4213      	tst	r3, r2
c0d03122:	d00d      	beq.n	c0d03140 <io_seproxyhal_handle_event+0x70>
    case SEPROXYHAL_TAG_TICKER_EVENT:
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
c0d03124:	1c80      	adds	r0, r0, #2
c0d03126:	280e      	cmp	r0, #14
c0d03128:	d1ee      	bne.n	c0d03108 <io_seproxyhal_handle_event+0x38>
        }
      }
#endif // HAVE_IO_USB
      // no break is intentional
    default:
      return io_event(CHANNEL_SPI);
c0d0312a:	2002      	movs	r0, #2
c0d0312c:	f7fe ff72 	bl	c0d02014 <io_event>
  }
  // defaultly return as not processed
  return 0;
}
c0d03130:	bdb0      	pop	{r4, r5, r7, pc}
c0d03132:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3) {
c0d03134:	2903      	cmp	r1, #3
c0d03136:	d302      	bcc.n	c0d0313e <io_seproxyhal_handle_event+0x6e>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d03138:	f7ff ff40 	bl	c0d02fbc <io_seproxyhal_handle_usb_ep_xfer_event>
c0d0313c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d0313e:	bdb0      	pop	{r4, r5, r7, pc}
        while(i--) {
          if (G_io_usb_ep_timeouts[i].timeout) {
            G_io_usb_ep_timeouts[i].timeout-=MIN(G_io_usb_ep_timeouts[i].timeout, 100);
            if (!G_io_usb_ep_timeouts[i].timeout) {
              // timeout !
              G_io_apdu_state = APDU_IDLE;
c0d03140:	4805      	ldr	r0, [pc, #20]	; (c0d03158 <io_seproxyhal_handle_event+0x88>)
c0d03142:	2100      	movs	r1, #0
c0d03144:	7001      	strb	r1, [r0, #0]
              THROW(EXCEPTION_IO_RESET);
c0d03146:	2010      	movs	r0, #16
c0d03148:	f7ff fed1 	bl	c0d02eee <os_longjmp>
c0d0314c:	20001800 	.word	0x20001800
c0d03150:	20001b58 	.word	0x20001b58
c0d03154:	0000ffff 	.word	0x0000ffff
c0d03158:	20001b66 	.word	0x20001b66

c0d0315c <io_seproxyhal_init>:
#ifdef HAVE_BOLOS_APP_STACK_CANARY
#define APP_STACK_CANARY_MAGIC 0xDEAD0031
extern unsigned int app_stack_canary;
#endif // HAVE_BOLOS_APP_STACK_CANARY

void io_seproxyhal_init(void) {
c0d0315c:	b510      	push	{r4, lr}
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d0315e:	2009      	movs	r0, #9
c0d03160:	f000 fafe 	bl	c0d03760 <check_api_level>

#ifdef HAVE_BOLOS_APP_STACK_CANARY
  app_stack_canary = APP_STACK_CANARY_MAGIC;
#endif // HAVE_BOLOS_APP_STACK_CANARY  

  G_io_apdu_state = APDU_IDLE;
c0d03164:	4807      	ldr	r0, [pc, #28]	; (c0d03184 <io_seproxyhal_init+0x28>)
c0d03166:	2400      	movs	r4, #0
c0d03168:	7004      	strb	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d0316a:	4807      	ldr	r0, [pc, #28]	; (c0d03188 <io_seproxyhal_init+0x2c>)
c0d0316c:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0316e:	4807      	ldr	r0, [pc, #28]	; (c0d0318c <io_seproxyhal_init+0x30>)
c0d03170:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d03172:	f7ff fe23 	bl	c0d02dbc <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d03176:	4806      	ldr	r0, [pc, #24]	; (c0d03190 <io_seproxyhal_init+0x34>)
c0d03178:	6004      	str	r4, [r0, #0]
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d0317a:	4806      	ldr	r0, [pc, #24]	; (c0d03194 <io_seproxyhal_init+0x38>)
c0d0317c:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d0317e:	4806      	ldr	r0, [pc, #24]	; (c0d03198 <io_seproxyhal_init+0x3c>)
c0d03180:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d03182:	bd10      	pop	{r4, pc}
c0d03184:	20001b66 	.word	0x20001b66
c0d03188:	20001b68 	.word	0x20001b68
c0d0318c:	20001b50 	.word	0x20001b50
c0d03190:	20001b6c 	.word	0x20001b6c
c0d03194:	20001b70 	.word	0x20001b70
c0d03198:	20001b74 	.word	0x20001b74

c0d0319c <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d0319c:	4801      	ldr	r0, [pc, #4]	; (c0d031a4 <io_seproxyhal_init_ux+0x8>)
c0d0319e:	2100      	movs	r1, #0
c0d031a0:	6001      	str	r1, [r0, #0]
}
c0d031a2:	4770      	bx	lr
c0d031a4:	20001b6c 	.word	0x20001b6c

c0d031a8 <io_seproxyhal_init_button>:

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d031a8:	4802      	ldr	r0, [pc, #8]	; (c0d031b4 <io_seproxyhal_init_button+0xc>)
c0d031aa:	2100      	movs	r1, #0
c0d031ac:	6001      	str	r1, [r0, #0]
  G_button_same_mask_counter = 0;
c0d031ae:	4802      	ldr	r0, [pc, #8]	; (c0d031b8 <io_seproxyhal_init_button+0x10>)
c0d031b0:	6001      	str	r1, [r0, #0]
}
c0d031b2:	4770      	bx	lr
c0d031b4:	20001b70 	.word	0x20001b70
c0d031b8:	20001b74 	.word	0x20001b74

c0d031bc <io_seproxyhal_touch_out>:

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d031bc:	b5b0      	push	{r4, r5, r7, lr}
c0d031be:	460d      	mov	r5, r1
c0d031c0:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d031c2:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d031c4:	2800      	cmp	r0, #0
c0d031c6:	d00c      	beq.n	c0d031e2 <io_seproxyhal_touch_out+0x26>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d031c8:	f000 fab2 	bl	c0d03730 <pic>
c0d031cc:	4601      	mov	r1, r0
c0d031ce:	4620      	mov	r0, r4
c0d031d0:	4788      	blx	r1
c0d031d2:	f000 faad 	bl	c0d03730 <pic>
c0d031d6:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d031d8:	2800      	cmp	r0, #0
c0d031da:	d010      	beq.n	c0d031fe <io_seproxyhal_touch_out+0x42>
c0d031dc:	2801      	cmp	r0, #1
c0d031de:	d000      	beq.n	c0d031e2 <io_seproxyhal_touch_out+0x26>
c0d031e0:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d031e2:	2d00      	cmp	r5, #0
c0d031e4:	d007      	beq.n	c0d031f6 <io_seproxyhal_touch_out+0x3a>
    el = before_display(element);
c0d031e6:	4620      	mov	r0, r4
c0d031e8:	47a8      	blx	r5
c0d031ea:	2100      	movs	r1, #0
    if (!el) {
c0d031ec:	2800      	cmp	r0, #0
c0d031ee:	d006      	beq.n	c0d031fe <io_seproxyhal_touch_out+0x42>
c0d031f0:	2801      	cmp	r0, #1
c0d031f2:	d000      	beq.n	c0d031f6 <io_seproxyhal_touch_out+0x3a>
c0d031f4:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d031f6:	4620      	mov	r0, r4
c0d031f8:	f7fe ff08 	bl	c0d0200c <io_seproxyhal_display>
c0d031fc:	2101      	movs	r1, #1
  return 1;
}
c0d031fe:	4608      	mov	r0, r1
c0d03200:	bdb0      	pop	{r4, r5, r7, pc}

c0d03202 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d03202:	b5b0      	push	{r4, r5, r7, lr}
c0d03204:	b08e      	sub	sp, #56	; 0x38
c0d03206:	460d      	mov	r5, r1
c0d03208:	4604      	mov	r4, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d0320a:	6b60      	ldr	r0, [r4, #52]	; 0x34
c0d0320c:	2800      	cmp	r0, #0
c0d0320e:	d00c      	beq.n	c0d0322a <io_seproxyhal_touch_over+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d03210:	f000 fa8e 	bl	c0d03730 <pic>
c0d03214:	4601      	mov	r1, r0
c0d03216:	4620      	mov	r0, r4
c0d03218:	4788      	blx	r1
c0d0321a:	f000 fa89 	bl	c0d03730 <pic>
c0d0321e:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d03220:	2800      	cmp	r0, #0
c0d03222:	d01b      	beq.n	c0d0325c <io_seproxyhal_touch_over+0x5a>
c0d03224:	2801      	cmp	r0, #1
c0d03226:	d000      	beq.n	c0d0322a <io_seproxyhal_touch_over+0x28>
c0d03228:	4604      	mov	r4, r0
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0322a:	2d00      	cmp	r5, #0
c0d0322c:	d008      	beq.n	c0d03240 <io_seproxyhal_touch_over+0x3e>
    el = before_display(element);
c0d0322e:	4620      	mov	r0, r4
c0d03230:	47a8      	blx	r5
c0d03232:	466c      	mov	r4, sp
c0d03234:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d03236:	2800      	cmp	r0, #0
c0d03238:	d010      	beq.n	c0d0325c <io_seproxyhal_touch_over+0x5a>
c0d0323a:	2801      	cmp	r0, #1
c0d0323c:	d000      	beq.n	c0d03240 <io_seproxyhal_touch_over+0x3e>
c0d0323e:	4604      	mov	r4, r0
c0d03240:	466d      	mov	r5, sp
      element = el;
    }
  }

  // swap colors
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d03242:	2238      	movs	r2, #56	; 0x38
c0d03244:	4628      	mov	r0, r5
c0d03246:	4621      	mov	r1, r4
c0d03248:	f7ff fd9d 	bl	c0d02d86 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d0324c:	6a60      	ldr	r0, [r4, #36]	; 0x24
c0d0324e:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d03250:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d03252:	9005      	str	r0, [sp, #20]

  io_seproxyhal_display(&e);
c0d03254:	4628      	mov	r0, r5
c0d03256:	f7fe fed9 	bl	c0d0200c <io_seproxyhal_display>
c0d0325a:	2101      	movs	r1, #1
  return 1;
}
c0d0325c:	4608      	mov	r0, r1
c0d0325e:	b00e      	add	sp, #56	; 0x38
c0d03260:	bdb0      	pop	{r4, r5, r7, pc}

c0d03262 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d03262:	b5b0      	push	{r4, r5, r7, lr}
c0d03264:	460d      	mov	r5, r1
c0d03266:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d03268:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0326a:	2800      	cmp	r0, #0
c0d0326c:	d00c      	beq.n	c0d03288 <io_seproxyhal_touch_tap+0x26>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0326e:	f000 fa5f 	bl	c0d03730 <pic>
c0d03272:	4601      	mov	r1, r0
c0d03274:	4620      	mov	r0, r4
c0d03276:	4788      	blx	r1
c0d03278:	f000 fa5a 	bl	c0d03730 <pic>
c0d0327c:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0327e:	2800      	cmp	r0, #0
c0d03280:	d010      	beq.n	c0d032a4 <io_seproxyhal_touch_tap+0x42>
c0d03282:	2801      	cmp	r0, #1
c0d03284:	d000      	beq.n	c0d03288 <io_seproxyhal_touch_tap+0x26>
c0d03286:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d03288:	2d00      	cmp	r5, #0
c0d0328a:	d007      	beq.n	c0d0329c <io_seproxyhal_touch_tap+0x3a>
    el = before_display(element);
c0d0328c:	4620      	mov	r0, r4
c0d0328e:	47a8      	blx	r5
c0d03290:	2100      	movs	r1, #0
    if (!el) {
c0d03292:	2800      	cmp	r0, #0
c0d03294:	d006      	beq.n	c0d032a4 <io_seproxyhal_touch_tap+0x42>
c0d03296:	2801      	cmp	r0, #1
c0d03298:	d000      	beq.n	c0d0329c <io_seproxyhal_touch_tap+0x3a>
c0d0329a:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d0329c:	4620      	mov	r0, r4
c0d0329e:	f7fe feb5 	bl	c0d0200c <io_seproxyhal_display>
c0d032a2:	2101      	movs	r1, #1
  return 1;
}
c0d032a4:	4608      	mov	r0, r1
c0d032a6:	bdb0      	pop	{r4, r5, r7, pc}

c0d032a8 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d032a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d032aa:	b087      	sub	sp, #28
c0d032ac:	9302      	str	r3, [sp, #8]
c0d032ae:	9203      	str	r2, [sp, #12]
c0d032b0:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d032b2:	2900      	cmp	r1, #0
c0d032b4:	d077      	beq.n	c0d033a6 <io_seproxyhal_touch_element_callback+0xfe>
c0d032b6:	9004      	str	r0, [sp, #16]
c0d032b8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d032ba:	9001      	str	r0, [sp, #4]
c0d032bc:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d032be:	9000      	str	r0, [sp, #0]
c0d032c0:	2500      	movs	r5, #0
c0d032c2:	4b3c      	ldr	r3, [pc, #240]	; (c0d033b4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d032c4:	9506      	str	r5, [sp, #24]
c0d032c6:	462f      	mov	r7, r5
c0d032c8:	461e      	mov	r6, r3
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d032ca:	f000 fb71 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d032ce:	2800      	cmp	r0, #0
c0d032d0:	d155      	bne.n	c0d0337e <io_seproxyhal_touch_element_callback+0xd6>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d032d2:	2038      	movs	r0, #56	; 0x38
c0d032d4:	4368      	muls	r0, r5
c0d032d6:	9c04      	ldr	r4, [sp, #16]
c0d032d8:	1825      	adds	r5, r4, r0
c0d032da:	4633      	mov	r3, r6
c0d032dc:	681a      	ldr	r2, [r3, #0]
c0d032de:	2101      	movs	r1, #1
c0d032e0:	4295      	cmp	r5, r2
c0d032e2:	d000      	beq.n	c0d032e6 <io_seproxyhal_touch_element_callback+0x3e>
c0d032e4:	9906      	ldr	r1, [sp, #24]
c0d032e6:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d032e8:	5620      	ldrsb	r0, [r4, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d032ea:	2800      	cmp	r0, #0
c0d032ec:	da41      	bge.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
c0d032ee:	2020      	movs	r0, #32
c0d032f0:	5c28      	ldrb	r0, [r5, r0]
c0d032f2:	2102      	movs	r1, #2
c0d032f4:	5e69      	ldrsh	r1, [r5, r1]
c0d032f6:	1a0a      	subs	r2, r1, r0
c0d032f8:	9c03      	ldr	r4, [sp, #12]
c0d032fa:	42a2      	cmp	r2, r4
c0d032fc:	dc39      	bgt.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
c0d032fe:	1841      	adds	r1, r0, r1
c0d03300:	88ea      	ldrh	r2, [r5, #6]
c0d03302:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d03304:	9a03      	ldr	r2, [sp, #12]
c0d03306:	428a      	cmp	r2, r1
c0d03308:	da33      	bge.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
c0d0330a:	2104      	movs	r1, #4
c0d0330c:	5e6c      	ldrsh	r4, [r5, r1]
c0d0330e:	1a22      	subs	r2, r4, r0
c0d03310:	9902      	ldr	r1, [sp, #8]
c0d03312:	428a      	cmp	r2, r1
c0d03314:	dc2d      	bgt.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
c0d03316:	1820      	adds	r0, r4, r0
c0d03318:	8929      	ldrh	r1, [r5, #8]
c0d0331a:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0331c:	9902      	ldr	r1, [sp, #8]
c0d0331e:	4281      	cmp	r1, r0
c0d03320:	da27      	bge.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d03322:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d03324:	4285      	cmp	r5, r0
c0d03326:	d010      	beq.n	c0d0334a <io_seproxyhal_touch_element_callback+0xa2>
c0d03328:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d0332a:	2800      	cmp	r0, #0
c0d0332c:	d00d      	beq.n	c0d0334a <io_seproxyhal_touch_element_callback+0xa2>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d0332e:	9801      	ldr	r0, [sp, #4]
c0d03330:	2800      	cmp	r0, #0
c0d03332:	d005      	beq.n	c0d03340 <io_seproxyhal_touch_element_callback+0x98>
c0d03334:	4628      	mov	r0, r5
c0d03336:	9901      	ldr	r1, [sp, #4]
c0d03338:	4788      	blx	r1
c0d0333a:	4633      	mov	r3, r6
c0d0333c:	2800      	cmp	r0, #0
c0d0333e:	d018      	beq.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d03340:	6818      	ldr	r0, [r3, #0]
c0d03342:	9901      	ldr	r1, [sp, #4]
c0d03344:	f7ff ff3a 	bl	c0d031bc <io_seproxyhal_touch_out>
c0d03348:	e008      	b.n	c0d0335c <io_seproxyhal_touch_element_callback+0xb4>
c0d0334a:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0334c:	2801      	cmp	r0, #1
c0d0334e:	d009      	beq.n	c0d03364 <io_seproxyhal_touch_element_callback+0xbc>
c0d03350:	2802      	cmp	r0, #2
c0d03352:	d10e      	bne.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d03354:	4628      	mov	r0, r5
c0d03356:	9901      	ldr	r1, [sp, #4]
c0d03358:	f7ff ff83 	bl	c0d03262 <io_seproxyhal_touch_tap>
c0d0335c:	4633      	mov	r3, r6
c0d0335e:	2800      	cmp	r0, #0
c0d03360:	d007      	beq.n	c0d03372 <io_seproxyhal_touch_element_callback+0xca>
c0d03362:	e022      	b.n	c0d033aa <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d03364:	4628      	mov	r0, r5
c0d03366:	9901      	ldr	r1, [sp, #4]
c0d03368:	f7ff ff4b 	bl	c0d03202 <io_seproxyhal_touch_over>
c0d0336c:	4633      	mov	r3, r6
c0d0336e:	2800      	cmp	r0, #0
c0d03370:	d11e      	bne.n	c0d033b0 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d03372:	1c7f      	adds	r7, r7, #1
c0d03374:	b2fd      	uxtb	r5, r7
c0d03376:	9805      	ldr	r0, [sp, #20]
c0d03378:	4285      	cmp	r5, r0
c0d0337a:	d3a5      	bcc.n	c0d032c8 <io_seproxyhal_touch_element_callback+0x20>
c0d0337c:	e000      	b.n	c0d03380 <io_seproxyhal_touch_element_callback+0xd8>
c0d0337e:	4633      	mov	r3, r6
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d03380:	9806      	ldr	r0, [sp, #24]
c0d03382:	0600      	lsls	r0, r0, #24
c0d03384:	d00f      	beq.n	c0d033a6 <io_seproxyhal_touch_element_callback+0xfe>
c0d03386:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d03388:	2800      	cmp	r0, #0
c0d0338a:	d00c      	beq.n	c0d033a6 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0338c:	f000 fb10 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d03390:	4631      	mov	r1, r6
c0d03392:	2800      	cmp	r0, #0
c0d03394:	d107      	bne.n	c0d033a6 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d03396:	6808      	ldr	r0, [r1, #0]
c0d03398:	9901      	ldr	r1, [sp, #4]
c0d0339a:	f7ff ff0f 	bl	c0d031bc <io_seproxyhal_touch_out>
c0d0339e:	2800      	cmp	r0, #0
c0d033a0:	d001      	beq.n	c0d033a6 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d033a2:	2000      	movs	r0, #0
c0d033a4:	6030      	str	r0, [r6, #0]
    }
  }

  // not processed
}
c0d033a6:	b007      	add	sp, #28
c0d033a8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d033aa:	2000      	movs	r0, #0
c0d033ac:	6018      	str	r0, [r3, #0]
c0d033ae:	e7fa      	b.n	c0d033a6 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d033b0:	601d      	str	r5, [r3, #0]
c0d033b2:	e7f8      	b.n	c0d033a6 <io_seproxyhal_touch_element_callback+0xfe>
c0d033b4:	20001b6c 	.word	0x20001b6c

c0d033b8 <io_seproxyhal_display_icon>:
  // remaining length of bitmap bits to be displayed
  return len;
}
#endif // SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d033b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d033ba:	b089      	sub	sp, #36	; 0x24
c0d033bc:	460c      	mov	r4, r1
c0d033be:	4601      	mov	r1, r0
c0d033c0:	ad02      	add	r5, sp, #8
c0d033c2:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d033c4:	4628      	mov	r0, r5
c0d033c6:	9201      	str	r2, [sp, #4]
c0d033c8:	f7ff fcdd 	bl	c0d02d86 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d033cc:	6821      	ldr	r1, [r4, #0]
c0d033ce:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d033d0:	6862      	ldr	r2, [r4, #4]
c0d033d2:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d033d4:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d033d6:	4f1a      	ldr	r7, [pc, #104]	; (c0d03440 <io_seproxyhal_display_icon+0x88>)
c0d033d8:	2365      	movs	r3, #101	; 0x65
c0d033da:	703b      	strb	r3, [r7, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d033dc:	b292      	uxth	r2, r2
c0d033de:	4342      	muls	r2, r0
c0d033e0:	b28b      	uxth	r3, r1
c0d033e2:	4353      	muls	r3, r2
c0d033e4:	08d9      	lsrs	r1, r3, #3
c0d033e6:	1c4e      	adds	r6, r1, #1
c0d033e8:	2207      	movs	r2, #7
c0d033ea:	4213      	tst	r3, r2
c0d033ec:	d100      	bne.n	c0d033f0 <io_seproxyhal_display_icon+0x38>
c0d033ee:	460e      	mov	r6, r1
c0d033f0:	4631      	mov	r1, r6
c0d033f2:	9100      	str	r1, [sp, #0]
c0d033f4:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d033f6:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d033f8:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d033fa:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d033fc:	0a01      	lsrs	r1, r0, #8
c0d033fe:	7079      	strb	r1, [r7, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d03400:	70b8      	strb	r0, [r7, #2]
c0d03402:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d03404:	4638      	mov	r0, r7
c0d03406:	f000 fabd 	bl	c0d03984 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d0340a:	4628      	mov	r0, r5
c0d0340c:	9901      	ldr	r1, [sp, #4]
c0d0340e:	f000 fab9 	bl	c0d03984 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d03412:	68a0      	ldr	r0, [r4, #8]
c0d03414:	7038      	strb	r0, [r7, #0]
c0d03416:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d03418:	4638      	mov	r0, r7
c0d0341a:	f000 fab3 	bl	c0d03984 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d0341e:	68e0      	ldr	r0, [r4, #12]
c0d03420:	f000 f986 	bl	c0d03730 <pic>
c0d03424:	b2b1      	uxth	r1, r6
c0d03426:	f000 faad 	bl	c0d03984 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d0342a:	9800      	ldr	r0, [sp, #0]
c0d0342c:	b285      	uxth	r5, r0
c0d0342e:	6920      	ldr	r0, [r4, #16]
c0d03430:	f000 f97e 	bl	c0d03730 <pic>
c0d03434:	4629      	mov	r1, r5
c0d03436:	f000 faa5 	bl	c0d03984 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d0343a:	b009      	add	sp, #36	; 0x24
c0d0343c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0343e:	46c0      	nop			; (mov r8, r8)
c0d03440:	20001800 	.word	0x20001800

c0d03444 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(const bagl_element_t * element) {
c0d03444:	b570      	push	{r4, r5, r6, lr}
c0d03446:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d03448:	7820      	ldrb	r0, [r4, #0]
c0d0344a:	267f      	movs	r6, #127	; 0x7f
c0d0344c:	4006      	ands	r6, r0

  // avoid sending another status :), fixes a lot of bugs in the end
  if (io_seproxyhal_spi_is_status_sent()) {
c0d0344e:	f000 faaf 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d03452:	2800      	cmp	r0, #0
c0d03454:	d130      	bne.n	c0d034b8 <io_seproxyhal_display_default+0x74>
c0d03456:	2e00      	cmp	r6, #0
c0d03458:	d02e      	beq.n	c0d034b8 <io_seproxyhal_display_default+0x74>
    return;
  }

  if (type != BAGL_NONE) {
    if (element->text != NULL) {
c0d0345a:	69e0      	ldr	r0, [r4, #28]
c0d0345c:	2800      	cmp	r0, #0
c0d0345e:	d01d      	beq.n	c0d0349c <io_seproxyhal_display_default+0x58>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d03460:	f000 f966 	bl	c0d03730 <pic>
c0d03464:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d03466:	2e05      	cmp	r6, #5
c0d03468:	d102      	bne.n	c0d03470 <io_seproxyhal_display_default+0x2c>
c0d0346a:	7ea0      	ldrb	r0, [r4, #26]
c0d0346c:	2800      	cmp	r0, #0
c0d0346e:	d024      	beq.n	c0d034ba <io_seproxyhal_display_default+0x76>
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d03470:	4628      	mov	r0, r5
c0d03472:	f001 fb23 	bl	c0d04abc <strlen>
c0d03476:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d03478:	4812      	ldr	r0, [pc, #72]	; (c0d034c4 <io_seproxyhal_display_default+0x80>)
c0d0347a:	2165      	movs	r1, #101	; 0x65
c0d0347c:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0347e:	4631      	mov	r1, r6
c0d03480:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d03482:	0a0a      	lsrs	r2, r1, #8
c0d03484:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d03486:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d03488:	2103      	movs	r1, #3
c0d0348a:	f000 fa7b 	bl	c0d03984 <io_seproxyhal_spi_send>
c0d0348e:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d03490:	4620      	mov	r0, r4
c0d03492:	f000 fa77 	bl	c0d03984 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
c0d03496:	b2b1      	uxth	r1, r6
c0d03498:	4628      	mov	r0, r5
c0d0349a:	e00b      	b.n	c0d034b4 <io_seproxyhal_display_default+0x70>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0349c:	4809      	ldr	r0, [pc, #36]	; (c0d034c4 <io_seproxyhal_display_default+0x80>)
c0d0349e:	2165      	movs	r1, #101	; 0x65
c0d034a0:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d034a2:	2100      	movs	r1, #0
c0d034a4:	7041      	strb	r1, [r0, #1]
c0d034a6:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d034a8:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d034aa:	2103      	movs	r1, #3
c0d034ac:	f000 fa6a 	bl	c0d03984 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d034b0:	4620      	mov	r0, r4
c0d034b2:	4629      	mov	r1, r5
c0d034b4:	f000 fa66 	bl	c0d03984 <io_seproxyhal_spi_send>
    }
  }
}
c0d034b8:	bd70      	pop	{r4, r5, r6, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
c0d034ba:	4620      	mov	r0, r4
c0d034bc:	4629      	mov	r1, r5
c0d034be:	f7ff ff7b 	bl	c0d033b8 <io_seproxyhal_display_icon>
      G_io_seproxyhal_spi_buffer[2] = length;
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
    }
  }
}
c0d034c2:	bd70      	pop	{r4, r5, r6, pc}
c0d034c4:	20001800 	.word	0x20001800

c0d034c8 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d034c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d034ca:	b081      	sub	sp, #4
c0d034cc:	4604      	mov	r4, r0
  if (button_callback) {
c0d034ce:	2c00      	cmp	r4, #0
c0d034d0:	d02b      	beq.n	c0d0352a <io_seproxyhal_button_push+0x62>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d034d2:	4817      	ldr	r0, [pc, #92]	; (c0d03530 <io_seproxyhal_button_push+0x68>)
c0d034d4:	6802      	ldr	r2, [r0, #0]
c0d034d6:	428a      	cmp	r2, r1
c0d034d8:	d103      	bne.n	c0d034e2 <io_seproxyhal_button_push+0x1a>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d034da:	4a16      	ldr	r2, [pc, #88]	; (c0d03534 <io_seproxyhal_button_push+0x6c>)
c0d034dc:	6813      	ldr	r3, [r2, #0]
c0d034de:	1c5b      	adds	r3, r3, #1
c0d034e0:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d034e2:	6806      	ldr	r6, [r0, #0]
c0d034e4:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d034e6:	4a13      	ldr	r2, [pc, #76]	; (c0d03534 <io_seproxyhal_button_push+0x6c>)
c0d034e8:	6815      	ldr	r5, [r2, #0]
c0d034ea:	4f13      	ldr	r7, [pc, #76]	; (c0d03538 <io_seproxyhal_button_push+0x70>)

    // reset button mask
    if (new_button_mask == 0) {
c0d034ec:	2900      	cmp	r1, #0
c0d034ee:	d001      	beq.n	c0d034f4 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d034f0:	6006      	str	r6, [r0, #0]
c0d034f2:	e004      	b.n	c0d034fe <io_seproxyhal_button_push+0x36>
c0d034f4:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d034f6:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d034f8:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d034fa:	1c7b      	adds	r3, r7, #1
c0d034fc:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d034fe:	6800      	ldr	r0, [r0, #0]
c0d03500:	4288      	cmp	r0, r1
c0d03502:	d001      	beq.n	c0d03508 <io_seproxyhal_button_push+0x40>
      G_button_same_mask_counter=0;
c0d03504:	2000      	movs	r0, #0
c0d03506:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d03508:	2d08      	cmp	r5, #8
c0d0350a:	d30b      	bcc.n	c0d03524 <io_seproxyhal_button_push+0x5c>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0350c:	2103      	movs	r1, #3
c0d0350e:	4628      	mov	r0, r5
c0d03510:	f001 f9f2 	bl	c0d048f8 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d03514:	2001      	movs	r0, #1
c0d03516:	0780      	lsls	r0, r0, #30
c0d03518:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0351a:	2900      	cmp	r1, #0
c0d0351c:	d000      	beq.n	c0d03520 <io_seproxyhal_button_push+0x58>
c0d0351e:	4630      	mov	r0, r6
      }
      */

      // discard the release event after a fastskip has been detected, to avoid strange at release behavior
      // and also to enable user to cancel an operation by starting triggering the fast skip
      button_mask &= ~BUTTON_EVT_RELEASED;
c0d03520:	4038      	ands	r0, r7
c0d03522:	e000      	b.n	c0d03526 <io_seproxyhal_button_push+0x5e>
c0d03524:	4630      	mov	r0, r6
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d03526:	4629      	mov	r1, r5
c0d03528:	47a0      	blx	r4
  }
}
c0d0352a:	b001      	add	sp, #4
c0d0352c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0352e:	46c0      	nop			; (mov r8, r8)
c0d03530:	20001b70 	.word	0x20001b70
c0d03534:	20001b74 	.word	0x20001b74
c0d03538:	7fffffff 	.word	0x7fffffff

c0d0353c <os_io_seproxyhal_get_app_name_and_version>:
#ifdef HAVE_IO_U2F
u2f_service_t G_io_u2f;
#endif // HAVE_IO_U2F

unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
c0d0353c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0353e:	b081      	sub	sp, #4
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d03540:	4e0f      	ldr	r6, [pc, #60]	; (c0d03580 <os_io_seproxyhal_get_app_name_and_version+0x44>)
c0d03542:	2401      	movs	r4, #1
c0d03544:	7034      	strb	r4, [r6, #0]

  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d03546:	1cb1      	adds	r1, r6, #2
c0d03548:	2081      	movs	r0, #129	; 0x81
c0d0354a:	0047      	lsls	r7, r0, #1
c0d0354c:	1c7a      	adds	r2, r7, #1
c0d0354e:	4620      	mov	r0, r4
c0d03550:	f000 fa00 	bl	c0d03954 <os_registry_get_current_app_tag>
c0d03554:	4605      	mov	r5, r0
  G_io_apdu_buffer[tx_len++] = len;
c0d03556:	7075      	strb	r5, [r6, #1]
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d03558:	1b7a      	subs	r2, r7, r5
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d0355a:	1977      	adds	r7, r6, r5
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
  G_io_apdu_buffer[tx_len++] = len;
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d0355c:	1cf9      	adds	r1, r7, #3
c0d0355e:	2002      	movs	r0, #2
c0d03560:	f000 f9f8 	bl	c0d03954 <os_registry_get_current_app_tag>
  G_io_apdu_buffer[tx_len++] = len;
c0d03564:	70b8      	strb	r0, [r7, #2]
c0d03566:	182d      	adds	r5, r5, r0
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d03568:	1976      	adds	r6, r6, r5
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
  G_io_apdu_buffer[tx_len++] = len;
  tx_len += len;
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
c0d0356a:	70f4      	strb	r4, [r6, #3]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d0356c:	f000 f9c6 	bl	c0d038fc <os_flags>
c0d03570:	7130      	strb	r0, [r6, #4]

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
c0d03572:	2090      	movs	r0, #144	; 0x90
c0d03574:	7170      	strb	r0, [r6, #5]
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d03576:	2000      	movs	r0, #0
c0d03578:	71b0      	strb	r0, [r6, #6]
c0d0357a:	1de8      	adds	r0, r5, #7
  return tx_len;
c0d0357c:	b001      	add	sp, #4
c0d0357e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03580:	20001a44 	.word	0x20001a44

c0d03584 <io_exchange>:
}


unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d03584:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03586:	b083      	sub	sp, #12
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d03588:	2207      	movs	r2, #7
c0d0358a:	4210      	tst	r0, r2
c0d0358c:	d006      	beq.n	c0d0359c <io_exchange+0x18>
c0d0358e:	4607      	mov	r7, r0
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d03590:	b2f8      	uxtb	r0, r7
c0d03592:	f7fe fd19 	bl	c0d01fc8 <io_exchange_al>
  }
}
c0d03596:	b280      	uxth	r0, r0
c0d03598:	b003      	add	sp, #12
c0d0359a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0359c:	9201      	str	r2, [sp, #4]
c0d0359e:	4c58      	ldr	r4, [pc, #352]	; (c0d03700 <io_exchange+0x17c>)
c0d035a0:	4d58      	ldr	r5, [pc, #352]	; (c0d03704 <io_exchange+0x180>)
c0d035a2:	4607      	mov	r7, r0
c0d035a4:	e010      	b.n	c0d035c8 <io_exchange+0x44>
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
          tx_len = 0;
          G_io_apdu_buffer[tx_len++] = 0x90;
c0d035a6:	2090      	movs	r0, #144	; 0x90
c0d035a8:	4957      	ldr	r1, [pc, #348]	; (c0d03708 <io_exchange+0x184>)
c0d035aa:	7008      	strb	r0, [r1, #0]
          G_io_apdu_buffer[tx_len++] = 0x00;
c0d035ac:	704e      	strb	r6, [r1, #1]
c0d035ae:	9a02      	ldr	r2, [sp, #8]
          // exit app after replied
          channel |= IO_RESET_AFTER_REPLIED;
c0d035b0:	4317      	orrs	r7, r2
c0d035b2:	2102      	movs	r1, #2
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d035b4:	9801      	ldr	r0, [sp, #4]
c0d035b6:	4202      	tst	r2, r0
c0d035b8:	4638      	mov	r0, r7
c0d035ba:	d005      	beq.n	c0d035c8 <io_exchange+0x44>
c0d035bc:	e7e8      	b.n	c0d03590 <io_exchange+0xc>
      // an apdu has been received asynchroneously, return it
      if (G_io_apdu_state != APDU_IDLE && G_io_apdu_length > 0) {
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
          tx_len = os_io_seproxyhal_get_app_name_and_version();
c0d035be:	f7ff ffbd 	bl	c0d0353c <os_io_seproxyhal_get_app_name_and_version>
c0d035c2:	4601      	mov	r1, r0
c0d035c4:	4630      	mov	r0, r6
c0d035c6:	4637      	mov	r7, r6
reply_apdu:
  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d035c8:	2610      	movs	r6, #16
c0d035ca:	4006      	ands	r6, r0
c0d035cc:	040a      	lsls	r2, r1, #16
c0d035ce:	9002      	str	r0, [sp, #8]
c0d035d0:	d049      	beq.n	c0d03666 <io_exchange+0xe2>
c0d035d2:	2e00      	cmp	r6, #0
c0d035d4:	d147      	bne.n	c0d03666 <io_exchange+0xe2>
      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d035d6:	7820      	ldrb	r0, [r4, #0]
c0d035d8:	2807      	cmp	r0, #7
c0d035da:	d00b      	beq.n	c0d035f4 <io_exchange+0x70>
c0d035dc:	280a      	cmp	r0, #10
c0d035de:	d00f      	beq.n	c0d03600 <io_exchange+0x7c>
c0d035e0:	2800      	cmp	r0, #0
c0d035e2:	d100      	bne.n	c0d035e6 <io_exchange+0x62>
c0d035e4:	e085      	b.n	c0d036f2 <io_exchange+0x16e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d035e6:	b2f8      	uxtb	r0, r7
c0d035e8:	b289      	uxth	r1, r1
c0d035ea:	f7fe fced 	bl	c0d01fc8 <io_exchange_al>
c0d035ee:	2800      	cmp	r0, #0
c0d035f0:	d024      	beq.n	c0d0363c <io_exchange+0xb8>
c0d035f2:	e07e      	b.n	c0d036f2 <io_exchange+0x16e>
            goto break_send;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_send(io_usb_send_apdu_data, tx_len);
c0d035f4:	b289      	uxth	r1, r1
c0d035f6:	484c      	ldr	r0, [pc, #304]	; (c0d03728 <io_exchange+0x1a4>)
c0d035f8:	4478      	add	r0, pc
c0d035fa:	f7ff fc47 	bl	c0d02e8c <io_usb_hid_send>
c0d035fe:	e01d      	b.n	c0d0363c <io_exchange+0xb8>
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
            break;

          case APDU_RAW:
            if (tx_len > sizeof(G_io_apdu_buffer)) {
c0d03600:	20ff      	movs	r0, #255	; 0xff
c0d03602:	3006      	adds	r0, #6
c0d03604:	b28f      	uxth	r7, r1
c0d03606:	4287      	cmp	r7, r0
c0d03608:	d276      	bcs.n	c0d036f8 <io_exchange+0x174>
              THROW(INVALID_PARAMETER);
            }
            // reply the RAW APDU over SEPROXYHAL protocol
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
c0d0360a:	2053      	movs	r0, #83	; 0x53
c0d0360c:	7028      	strb	r0, [r5, #0]
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
c0d0360e:	0a38      	lsrs	r0, r7, #8
c0d03610:	7068      	strb	r0, [r5, #1]
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
c0d03612:	70a9      	strb	r1, [r5, #2]
            io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d03614:	2103      	movs	r1, #3
c0d03616:	4628      	mov	r0, r5
c0d03618:	f000 f9b4 	bl	c0d03984 <io_seproxyhal_spi_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d0361c:	483a      	ldr	r0, [pc, #232]	; (c0d03708 <io_exchange+0x184>)
c0d0361e:	4639      	mov	r1, r7
c0d03620:	f000 f9b0 	bl	c0d03984 <io_seproxyhal_spi_send>

            // isngle packet reply, mark immediate idle
            G_io_apdu_state = APDU_IDLE;
c0d03624:	2000      	movs	r0, #0
c0d03626:	7020      	strb	r0, [r4, #0]
c0d03628:	e008      	b.n	c0d0363c <io_exchange+0xb8>
        // wait end of reply transmission
        while (G_io_apdu_state != APDU_IDLE) {
#ifdef HAVE_TINY_COROUTINE
          tcr_yield();
#else // HAVE_TINY_COROUTINE
          io_seproxyhal_general_status();
c0d0362a:	f7ff fc6d 	bl	c0d02f08 <io_seproxyhal_general_status>
          io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0362e:	2180      	movs	r1, #128	; 0x80
c0d03630:	2200      	movs	r2, #0
c0d03632:	4628      	mov	r0, r5
c0d03634:	f000 f9d2 	bl	c0d039dc <io_seproxyhal_spi_recv>
          // if packet is not well formed, then too bad ...
          io_seproxyhal_handle_event();
c0d03638:	f7ff fd4a 	bl	c0d030d0 <io_seproxyhal_handle_event>
c0d0363c:	7820      	ldrb	r0, [r4, #0]
c0d0363e:	2800      	cmp	r0, #0
c0d03640:	d1f3      	bne.n	c0d0362a <io_exchange+0xa6>
c0d03642:	2000      	movs	r0, #0
#endif // HAVE_TINY_COROUTINE
        }

        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d03644:	7020      	strb	r0, [r4, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d03646:	4931      	ldr	r1, [pc, #196]	; (c0d0370c <io_exchange+0x188>)
c0d03648:	7008      	strb	r0, [r1, #0]

        G_io_apdu_length = 0;
c0d0364a:	4931      	ldr	r1, [pc, #196]	; (c0d03710 <io_exchange+0x18c>)
c0d0364c:	8008      	strh	r0, [r1, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0364e:	9902      	ldr	r1, [sp, #8]
c0d03650:	0689      	lsls	r1, r1, #26
c0d03652:	d4a0      	bmi.n	c0d03596 <io_exchange+0x12>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d03654:	f7ff fc58 	bl	c0d02f08 <io_seproxyhal_general_status>
c0d03658:	9802      	ldr	r0, [sp, #8]
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d0365a:	0601      	lsls	r1, r0, #24
c0d0365c:	d503      	bpl.n	c0d03666 <io_exchange+0xe2>
        os_sched_exit(1);
c0d0365e:	2001      	movs	r0, #1
c0d03660:	f000 f920 	bl	c0d038a4 <os_sched_exit>
c0d03664:	9802      	ldr	r0, [sp, #8]
        //reset();
      }
    }

#ifndef HAVE_TINY_COROUTINE
    if (!(channel&IO_ASYNCH_REPLY)) {
c0d03666:	2e00      	cmp	r6, #0
c0d03668:	d105      	bne.n	c0d03676 <io_exchange+0xf2>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d0366a:	0640      	lsls	r0, r0, #25
c0d0366c:	d43c      	bmi.n	c0d036e8 <io_exchange+0x164>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d0366e:	2000      	movs	r0, #0
c0d03670:	7020      	strb	r0, [r4, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d03672:	4926      	ldr	r1, [pc, #152]	; (c0d0370c <io_exchange+0x188>)
c0d03674:	7008      	strb	r0, [r1, #0]
    }
#endif // HAVE_TINY_COROUTINE

    // reset the received apdu length
    G_io_apdu_length = 0;
c0d03676:	2000      	movs	r0, #0
c0d03678:	4925      	ldr	r1, [pc, #148]	; (c0d03710 <io_exchange+0x18c>)
c0d0367a:	8008      	strh	r0, [r1, #0]
#ifdef HAVE_TINY_COROUTINE
      // give back hand to the seph task which interprets all incoming events first
      tcr_yield();
#else // HAVE_TINY_COROUTINE

      if (!io_seproxyhal_spi_is_status_sent()) {
c0d0367c:	f000 f998 	bl	c0d039b0 <io_seproxyhal_spi_is_status_sent>
c0d03680:	2800      	cmp	r0, #0
c0d03682:	d101      	bne.n	c0d03688 <io_exchange+0x104>
        io_seproxyhal_general_status();
c0d03684:	f7ff fc40 	bl	c0d02f08 <io_seproxyhal_general_status>
      }
      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d03688:	2780      	movs	r7, #128	; 0x80
c0d0368a:	2600      	movs	r6, #0
c0d0368c:	4628      	mov	r0, r5
c0d0368e:	4639      	mov	r1, r7
c0d03690:	4632      	mov	r2, r6
c0d03692:	f000 f9a3 	bl	c0d039dc <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d03696:	2802      	cmp	r0, #2
c0d03698:	d806      	bhi.n	c0d036a8 <io_exchange+0x124>
c0d0369a:	78a9      	ldrb	r1, [r5, #2]
c0d0369c:	786a      	ldrb	r2, [r5, #1]
c0d0369e:	0212      	lsls	r2, r2, #8
c0d036a0:	430a      	orrs	r2, r1
c0d036a2:	1ec0      	subs	r0, r0, #3
c0d036a4:	4290      	cmp	r0, r2
c0d036a6:	d109      	bne.n	c0d036bc <io_exchange+0x138>
        G_io_apdu_state = APDU_IDLE;
        G_io_apdu_length = 0;
        continue;
      }

        io_seproxyhal_handle_event();
c0d036a8:	f7ff fd12 	bl	c0d030d0 <io_seproxyhal_handle_event>
#endif // HAVE_TINY_COROUTINE

      // an apdu has been received asynchroneously, return it
      if (G_io_apdu_state != APDU_IDLE && G_io_apdu_length > 0) {
c0d036ac:	7820      	ldrb	r0, [r4, #0]
c0d036ae:	2800      	cmp	r0, #0
c0d036b0:	d0e4      	beq.n	c0d0367c <io_exchange+0xf8>
c0d036b2:	4817      	ldr	r0, [pc, #92]	; (c0d03710 <io_exchange+0x18c>)
c0d036b4:	8800      	ldrh	r0, [r0, #0]
c0d036b6:	2800      	cmp	r0, #0
c0d036b8:	d0e0      	beq.n	c0d0367c <io_exchange+0xf8>
c0d036ba:	e002      	b.n	c0d036c2 <io_exchange+0x13e>
c0d036bc:	2000      	movs	r0, #0
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
        G_io_apdu_state = APDU_IDLE;
c0d036be:	7020      	strb	r0, [r4, #0]
c0d036c0:	e7da      	b.n	c0d03678 <io_exchange+0xf4>

      // an apdu has been received asynchroneously, return it
      if (G_io_apdu_state != APDU_IDLE && G_io_apdu_length > 0) {
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
c0d036c2:	2204      	movs	r2, #4
c0d036c4:	4810      	ldr	r0, [pc, #64]	; (c0d03708 <io_exchange+0x184>)
c0d036c6:	a114      	add	r1, pc, #80	; (adr r1, c0d03718 <io_exchange+0x194>)
c0d036c8:	f7ff fbfa 	bl	c0d02ec0 <os_memcmp>
c0d036cc:	2800      	cmp	r0, #0
c0d036ce:	d100      	bne.n	c0d036d2 <io_exchange+0x14e>
c0d036d0:	e775      	b.n	c0d035be <io_exchange+0x3a>
          // disable 'return after tx' and 'asynch reply' flags
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
c0d036d2:	2204      	movs	r2, #4
c0d036d4:	480c      	ldr	r0, [pc, #48]	; (c0d03708 <io_exchange+0x184>)
c0d036d6:	a112      	add	r1, pc, #72	; (adr r1, c0d03720 <io_exchange+0x19c>)
c0d036d8:	f7ff fbf2 	bl	c0d02ec0 <os_memcmp>
c0d036dc:	2800      	cmp	r0, #0
c0d036de:	d100      	bne.n	c0d036e2 <io_exchange+0x15e>
c0d036e0:	e761      	b.n	c0d035a6 <io_exchange+0x22>
          // disable 'return after tx' and 'asynch reply' flags
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
#endif // HAVE_BOLOS_WITH_VIRGIN_ATTESTATION
        return G_io_apdu_length;
c0d036e2:	480b      	ldr	r0, [pc, #44]	; (c0d03710 <io_exchange+0x18c>)
c0d036e4:	8800      	ldrh	r0, [r0, #0]
c0d036e6:	e756      	b.n	c0d03596 <io_exchange+0x12>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d036e8:	4809      	ldr	r0, [pc, #36]	; (c0d03710 <io_exchange+0x18c>)
c0d036ea:	8800      	ldrh	r0, [r0, #0]
c0d036ec:	4909      	ldr	r1, [pc, #36]	; (c0d03714 <io_exchange+0x190>)
c0d036ee:	1840      	adds	r0, r0, r1
c0d036f0:	e751      	b.n	c0d03596 <io_exchange+0x12>
            if (io_exchange_al(channel, tx_len) == 0) {
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d036f2:	2009      	movs	r0, #9
c0d036f4:	f7ff fbfb 	bl	c0d02eee <os_longjmp>
            break;

          case APDU_RAW:
            if (tx_len > sizeof(G_io_apdu_buffer)) {
              THROW(INVALID_PARAMETER);
c0d036f8:	2002      	movs	r0, #2
c0d036fa:	f7ff fbf8 	bl	c0d02eee <os_longjmp>
c0d036fe:	46c0      	nop			; (mov r8, r8)
c0d03700:	20001b66 	.word	0x20001b66
c0d03704:	20001800 	.word	0x20001800
c0d03708:	20001a44 	.word	0x20001a44
c0d0370c:	20001b50 	.word	0x20001b50
c0d03710:	20001b68 	.word	0x20001b68
c0d03714:	0000fffb 	.word	0x0000fffb
c0d03718:	000001b0 	.word	0x000001b0
c0d0371c:	00000000 	.word	0x00000000
c0d03720:	0000a7b0 	.word	0x0000a7b0
c0d03724:	00000000 	.word	0x00000000
c0d03728:	fffffa75 	.word	0xfffffa75

c0d0372c <ux_check_status_default>:
}

void ux_check_status_default(unsigned int status) {
  // nothing to be done here by default.
  UNUSED(status);
}
c0d0372c:	4770      	bx	lr
	...

c0d03730 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d03730:	b580      	push	{r7, lr}
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d03732:	4904      	ldr	r1, [pc, #16]	; (c0d03744 <pic+0x14>)
c0d03734:	4288      	cmp	r0, r1
c0d03736:	d304      	bcc.n	c0d03742 <pic+0x12>
c0d03738:	4903      	ldr	r1, [pc, #12]	; (c0d03748 <pic+0x18>)
c0d0373a:	4288      	cmp	r0, r1
c0d0373c:	d201      	bcs.n	c0d03742 <pic+0x12>
		link_address = pic_internal(link_address);
c0d0373e:	f000 f805 	bl	c0d0374c <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d03742:	bd80      	pop	{r7, pc}
c0d03744:	c0d00000 	.word	0xc0d00000
c0d03748:	c0d04fc0 	.word	0xc0d04fc0

c0d0374c <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d0374c:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d0374e:	4902      	ldr	r1, [pc, #8]	; (c0d03758 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d03750:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d03752:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d03754:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d03756:	4770      	bx	lr
c0d03758:	c0d0374d 	.word	0xc0d0374d

c0d0375c <SVC_Call>:
  // avoid a separate asm file, but avoid any intrusion from the compiler
  unsigned int SVC_Call(unsigned int syscall_id, unsigned int * parameters) __attribute__ ((naked));
  //                    r0                       r1
  unsigned int SVC_Call(unsigned int syscall_id, unsigned int * parameters) {
    // delegate svc
    asm volatile("svc #1":::"r0","r1");
c0d0375c:	df01      	svc	1
    // directly return R0 value
    asm volatile("bx  lr");
c0d0375e:	4770      	bx	lr

c0d03760 <check_api_level>:
  }
  void check_api_level ( unsigned int apiLevel ) 
{
c0d03760:	b580      	push	{r7, lr}
c0d03762:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)apiLevel;
c0d03764:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
c0d03766:	4807      	ldr	r0, [pc, #28]	; (c0d03784 <check_api_level+0x24>)
c0d03768:	4669      	mov	r1, sp
c0d0376a:	f7ff fff7 	bl	c0d0375c <SVC_Call>
c0d0376e:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03770:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_check_api_level_ID_OUT) {
c0d03772:	4905      	ldr	r1, [pc, #20]	; (c0d03788 <check_api_level+0x28>)
c0d03774:	4288      	cmp	r0, r1
c0d03776:	d101      	bne.n	c0d0377c <check_api_level+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d03778:	b002      	add	sp, #8
c0d0377a:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)apiLevel;
  retid = SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_check_api_level_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d0377c:	2004      	movs	r0, #4
c0d0377e:	f7ff fbb6 	bl	c0d02eee <os_longjmp>
c0d03782:	46c0      	nop			; (mov r8, r8)
c0d03784:	60000137 	.word	0x60000137
c0d03788:	900001c6 	.word	0x900001c6

c0d0378c <reset>:
  }
}

void reset ( void ) 
{
c0d0378c:	b580      	push	{r7, lr}
c0d0378e:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_reset_ID_IN, parameters);
c0d03790:	4806      	ldr	r0, [pc, #24]	; (c0d037ac <reset+0x20>)
c0d03792:	a901      	add	r1, sp, #4
c0d03794:	f7ff ffe2 	bl	c0d0375c <SVC_Call>
c0d03798:	466a      	mov	r2, sp
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d0379a:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_reset_ID_OUT) {
c0d0379c:	4904      	ldr	r1, [pc, #16]	; (c0d037b0 <reset+0x24>)
c0d0379e:	4288      	cmp	r0, r1
c0d037a0:	d101      	bne.n	c0d037a6 <reset+0x1a>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d037a2:	b002      	add	sp, #8
c0d037a4:	bd80      	pop	{r7, pc}
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_reset_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_reset_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d037a6:	2004      	movs	r0, #4
c0d037a8:	f7ff fba1 	bl	c0d02eee <os_longjmp>
c0d037ac:	60000200 	.word	0x60000200
c0d037b0:	900002f1 	.word	0x900002f1

c0d037b4 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d037b4:	b580      	push	{r7, lr}
c0d037b6:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+3];
  parameters[0] = (unsigned int)dst_adr;
c0d037b8:	ab00      	add	r3, sp, #0
c0d037ba:	c307      	stmia	r3!, {r0, r1, r2}
  parameters[1] = (unsigned int)src_adr;
  parameters[2] = (unsigned int)src_len;
  retid = SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
c0d037bc:	4806      	ldr	r0, [pc, #24]	; (c0d037d8 <nvm_write+0x24>)
c0d037be:	4669      	mov	r1, sp
c0d037c0:	f7ff ffcc 	bl	c0d0375c <SVC_Call>
c0d037c4:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d037c6:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_nvm_write_ID_OUT) {
c0d037c8:	4904      	ldr	r1, [pc, #16]	; (c0d037dc <nvm_write+0x28>)
c0d037ca:	4288      	cmp	r0, r1
c0d037cc:	d101      	bne.n	c0d037d2 <nvm_write+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d037ce:	b004      	add	sp, #16
c0d037d0:	bd80      	pop	{r7, pc}
  parameters[1] = (unsigned int)src_adr;
  parameters[2] = (unsigned int)src_len;
  retid = SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_nvm_write_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d037d2:	2004      	movs	r0, #4
c0d037d4:	f7ff fb8b 	bl	c0d02eee <os_longjmp>
c0d037d8:	6000037f 	.word	0x6000037f
c0d037dc:	900003bc 	.word	0x900003bc

c0d037e0 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d037e0:	b580      	push	{r7, lr}
c0d037e2:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+2];
  parameters[0] = (unsigned int)buffer;
c0d037e4:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)len;
c0d037e6:	9102      	str	r1, [sp, #8]
  retid = SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
c0d037e8:	4807      	ldr	r0, [pc, #28]	; (c0d03808 <cx_rng+0x28>)
c0d037ea:	a901      	add	r1, sp, #4
c0d037ec:	f7ff ffb6 	bl	c0d0375c <SVC_Call>
c0d037f0:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d037f2:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_rng_ID_OUT) {
c0d037f4:	4905      	ldr	r1, [pc, #20]	; (c0d0380c <cx_rng+0x2c>)
c0d037f6:	4288      	cmp	r0, r1
c0d037f8:	d102      	bne.n	c0d03800 <cx_rng+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d037fa:	9803      	ldr	r0, [sp, #12]
c0d037fc:	b004      	add	sp, #16
c0d037fe:	bd80      	pop	{r7, pc}
  parameters[0] = (unsigned int)buffer;
  parameters[1] = (unsigned int)len;
  retid = SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_rng_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03800:	2004      	movs	r0, #4
c0d03802:	f7ff fb74 	bl	c0d02eee <os_longjmp>
c0d03806:	46c0      	nop			; (mov r8, r8)
c0d03808:	6000052c 	.word	0x6000052c
c0d0380c:	90000567 	.word	0x90000567

c0d03810 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len ) 
{
c0d03810:	b580      	push	{r7, lr}
c0d03812:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+6];
  parameters[0] = (unsigned int)hash;
c0d03814:	af01      	add	r7, sp, #4
c0d03816:	c70f      	stmia	r7!, {r0, r1, r2, r3}
c0d03818:	980a      	ldr	r0, [sp, #40]	; 0x28
  parameters[1] = (unsigned int)mode;
  parameters[2] = (unsigned int)in;
  parameters[3] = (unsigned int)len;
  parameters[4] = (unsigned int)out;
c0d0381a:	9005      	str	r0, [sp, #20]
c0d0381c:	980b      	ldr	r0, [sp, #44]	; 0x2c
  parameters[5] = (unsigned int)out_len;
c0d0381e:	9006      	str	r0, [sp, #24]
  retid = SVC_Call(SYSCALL_cx_hash_ID_IN, parameters);
c0d03820:	4807      	ldr	r0, [pc, #28]	; (c0d03840 <cx_hash+0x30>)
c0d03822:	a901      	add	r1, sp, #4
c0d03824:	f7ff ff9a 	bl	c0d0375c <SVC_Call>
c0d03828:	aa07      	add	r2, sp, #28
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d0382a:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_hash_ID_OUT) {
c0d0382c:	4905      	ldr	r1, [pc, #20]	; (c0d03844 <cx_hash+0x34>)
c0d0382e:	4288      	cmp	r0, r1
c0d03830:	d102      	bne.n	c0d03838 <cx_hash+0x28>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d03832:	9807      	ldr	r0, [sp, #28]
c0d03834:	b008      	add	sp, #32
c0d03836:	bd80      	pop	{r7, pc}
  parameters[4] = (unsigned int)out;
  parameters[5] = (unsigned int)out_len;
  retid = SVC_Call(SYSCALL_cx_hash_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_hash_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03838:	2004      	movs	r0, #4
c0d0383a:	f7ff fb58 	bl	c0d02eee <os_longjmp>
c0d0383e:	46c0      	nop			; (mov r8, r8)
c0d03840:	6000073b 	.word	0x6000073b
c0d03844:	900007ad 	.word	0x900007ad

c0d03848 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d03848:	b580      	push	{r7, lr}
c0d0384a:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)hash;
c0d0384c:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_cx_sha256_init_ID_IN, parameters);
c0d0384e:	4807      	ldr	r0, [pc, #28]	; (c0d0386c <cx_sha256_init+0x24>)
c0d03850:	4669      	mov	r1, sp
c0d03852:	f7ff ff83 	bl	c0d0375c <SVC_Call>
c0d03856:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03858:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_sha256_init_ID_OUT) {
c0d0385a:	4905      	ldr	r1, [pc, #20]	; (c0d03870 <cx_sha256_init+0x28>)
c0d0385c:	4288      	cmp	r0, r1
c0d0385e:	d102      	bne.n	c0d03866 <cx_sha256_init+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d03860:	9801      	ldr	r0, [sp, #4]
c0d03862:	b002      	add	sp, #8
c0d03864:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)hash;
  retid = SVC_Call(SYSCALL_cx_sha256_init_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_sha256_init_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03866:	2004      	movs	r0, #4
c0d03868:	f7ff fb41 	bl	c0d02eee <os_longjmp>
c0d0386c:	60000adb 	.word	0x60000adb
c0d03870:	90000a64 	.word	0x90000a64

c0d03874 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d03874:	b580      	push	{r7, lr}
c0d03876:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+4];
  parameters[0] = (unsigned int)curve;
c0d03878:	af01      	add	r7, sp, #4
c0d0387a:	c70f      	stmia	r7!, {r0, r1, r2, r3}
  parameters[1] = (unsigned int)pubkey;
  parameters[2] = (unsigned int)privkey;
  parameters[3] = (unsigned int)keepprivate;
  retid = SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
c0d0387c:	4807      	ldr	r0, [pc, #28]	; (c0d0389c <cx_ecfp_generate_pair+0x28>)
c0d0387e:	a901      	add	r1, sp, #4
c0d03880:	f7ff ff6c 	bl	c0d0375c <SVC_Call>
c0d03884:	aa05      	add	r2, sp, #20
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03886:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_ecfp_generate_pair_ID_OUT) {
c0d03888:	4905      	ldr	r1, [pc, #20]	; (c0d038a0 <cx_ecfp_generate_pair+0x2c>)
c0d0388a:	4288      	cmp	r0, r1
c0d0388c:	d102      	bne.n	c0d03894 <cx_ecfp_generate_pair+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0388e:	9805      	ldr	r0, [sp, #20]
c0d03890:	b006      	add	sp, #24
c0d03892:	bd80      	pop	{r7, pc}
  parameters[2] = (unsigned int)privkey;
  parameters[3] = (unsigned int)keepprivate;
  retid = SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_ecfp_generate_pair_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03894:	2004      	movs	r0, #4
c0d03896:	f7ff fb2a 	bl	c0d02eee <os_longjmp>
c0d0389a:	46c0      	nop			; (mov r8, r8)
c0d0389c:	60002f2e 	.word	0x60002f2e
c0d038a0:	90002f74 	.word	0x90002f74

c0d038a4 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d038a4:	b580      	push	{r7, lr}
c0d038a6:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)exit_code;
c0d038a8:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d038aa:	4807      	ldr	r0, [pc, #28]	; (c0d038c8 <os_sched_exit+0x24>)
c0d038ac:	4669      	mov	r1, sp
c0d038ae:	f7ff ff55 	bl	c0d0375c <SVC_Call>
c0d038b2:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d038b4:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_sched_exit_ID_OUT) {
c0d038b6:	4905      	ldr	r1, [pc, #20]	; (c0d038cc <os_sched_exit+0x28>)
c0d038b8:	4288      	cmp	r0, r1
c0d038ba:	d101      	bne.n	c0d038c0 <os_sched_exit+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d038bc:	b002      	add	sp, #8
c0d038be:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)exit_code;
  retid = SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_sched_exit_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d038c0:	2004      	movs	r0, #4
c0d038c2:	f7ff fb14 	bl	c0d02eee <os_longjmp>
c0d038c6:	46c0      	nop			; (mov r8, r8)
c0d038c8:	600062e1 	.word	0x600062e1
c0d038cc:	9000626f 	.word	0x9000626f

c0d038d0 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d038d0:	b580      	push	{r7, lr}
c0d038d2:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)params;
c0d038d4:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d038d6:	4807      	ldr	r0, [pc, #28]	; (c0d038f4 <os_ux+0x24>)
c0d038d8:	4669      	mov	r1, sp
c0d038da:	f7ff ff3f 	bl	c0d0375c <SVC_Call>
c0d038de:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d038e0:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_ux_ID_OUT) {
c0d038e2:	4905      	ldr	r1, [pc, #20]	; (c0d038f8 <os_ux+0x28>)
c0d038e4:	4288      	cmp	r0, r1
c0d038e6:	d102      	bne.n	c0d038ee <os_ux+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d038e8:	9801      	ldr	r0, [sp, #4]
c0d038ea:	b002      	add	sp, #8
c0d038ec:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)params;
  retid = SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_ux_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d038ee:	2004      	movs	r0, #4
c0d038f0:	f7ff fafd 	bl	c0d02eee <os_longjmp>
c0d038f4:	60006458 	.word	0x60006458
c0d038f8:	9000641f 	.word	0x9000641f

c0d038fc <os_flags>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_flags ( void ) 
{
c0d038fc:	b580      	push	{r7, lr}
c0d038fe:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d03900:	4807      	ldr	r0, [pc, #28]	; (c0d03920 <os_flags+0x24>)
c0d03902:	a901      	add	r1, sp, #4
c0d03904:	f7ff ff2a 	bl	c0d0375c <SVC_Call>
c0d03908:	466a      	mov	r2, sp
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d0390a:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_flags_ID_OUT) {
c0d0390c:	4905      	ldr	r1, [pc, #20]	; (c0d03924 <os_flags+0x28>)
c0d0390e:	4288      	cmp	r0, r1
c0d03910:	d102      	bne.n	c0d03918 <os_flags+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d03912:	9800      	ldr	r0, [sp, #0]
c0d03914:	b002      	add	sp, #8
c0d03916:	bd80      	pop	{r7, pc}
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_flags_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03918:	2004      	movs	r0, #4
c0d0391a:	f7ff fae8 	bl	c0d02eee <os_longjmp>
c0d0391e:	46c0      	nop			; (mov r8, r8)
c0d03920:	6000686e 	.word	0x6000686e
c0d03924:	9000687f 	.word	0x9000687f

c0d03928 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d03928:	b580      	push	{r7, lr}
c0d0392a:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_os_seph_features_ID_IN, parameters);
c0d0392c:	4807      	ldr	r0, [pc, #28]	; (c0d0394c <os_seph_features+0x24>)
c0d0392e:	a901      	add	r1, sp, #4
c0d03930:	f7ff ff14 	bl	c0d0375c <SVC_Call>
c0d03934:	466a      	mov	r2, sp
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03936:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_seph_features_ID_OUT) {
c0d03938:	4905      	ldr	r1, [pc, #20]	; (c0d03950 <os_seph_features+0x28>)
c0d0393a:	4288      	cmp	r0, r1
c0d0393c:	d102      	bne.n	c0d03944 <os_seph_features+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0393e:	9800      	ldr	r0, [sp, #0]
c0d03940:	b002      	add	sp, #8
c0d03942:	bd80      	pop	{r7, pc}
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_os_seph_features_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_seph_features_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03944:	2004      	movs	r0, #4
c0d03946:	f7ff fad2 	bl	c0d02eee <os_longjmp>
c0d0394a:	46c0      	nop			; (mov r8, r8)
c0d0394c:	60006ad6 	.word	0x60006ad6
c0d03950:	90006a44 	.word	0x90006a44

c0d03954 <os_registry_get_current_app_tag>:
  }
  return (unsigned int)ret;
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) 
{
c0d03954:	b580      	push	{r7, lr}
c0d03956:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+3];
  parameters[0] = (unsigned int)tag;
c0d03958:	ab00      	add	r3, sp, #0
c0d0395a:	c307      	stmia	r3!, {r0, r1, r2}
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)maxlen;
  retid = SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d0395c:	4807      	ldr	r0, [pc, #28]	; (c0d0397c <os_registry_get_current_app_tag+0x28>)
c0d0395e:	4669      	mov	r1, sp
c0d03960:	f7ff fefc 	bl	c0d0375c <SVC_Call>
c0d03964:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03966:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_registry_get_current_app_tag_ID_OUT) {
c0d03968:	4905      	ldr	r1, [pc, #20]	; (c0d03980 <os_registry_get_current_app_tag+0x2c>)
c0d0396a:	4288      	cmp	r0, r1
c0d0396c:	d102      	bne.n	c0d03974 <os_registry_get_current_app_tag+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0396e:	9803      	ldr	r0, [sp, #12]
c0d03970:	b004      	add	sp, #16
c0d03972:	bd80      	pop	{r7, pc}
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)maxlen;
  retid = SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_registry_get_current_app_tag_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03974:	2004      	movs	r0, #4
c0d03976:	f7ff faba 	bl	c0d02eee <os_longjmp>
c0d0397a:	46c0      	nop			; (mov r8, r8)
c0d0397c:	600070d4 	.word	0x600070d4
c0d03980:	90007087 	.word	0x90007087

c0d03984 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d03984:	b580      	push	{r7, lr}
c0d03986:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+2];
  parameters[0] = (unsigned int)buffer;
c0d03988:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)length;
c0d0398a:	9102      	str	r1, [sp, #8]
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_send_ID_IN, parameters);
c0d0398c:	4806      	ldr	r0, [pc, #24]	; (c0d039a8 <io_seproxyhal_spi_send+0x24>)
c0d0398e:	a901      	add	r1, sp, #4
c0d03990:	f7ff fee4 	bl	c0d0375c <SVC_Call>
c0d03994:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03996:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_io_seproxyhal_spi_send_ID_OUT) {
c0d03998:	4904      	ldr	r1, [pc, #16]	; (c0d039ac <io_seproxyhal_spi_send+0x28>)
c0d0399a:	4288      	cmp	r0, r1
c0d0399c:	d101      	bne.n	c0d039a2 <io_seproxyhal_spi_send+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0399e:	b004      	add	sp, #16
c0d039a0:	bd80      	pop	{r7, pc}
  parameters[0] = (unsigned int)buffer;
  parameters[1] = (unsigned int)length;
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_send_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_io_seproxyhal_spi_send_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d039a2:	2004      	movs	r0, #4
c0d039a4:	f7ff faa3 	bl	c0d02eee <os_longjmp>
c0d039a8:	6000721c 	.word	0x6000721c
c0d039ac:	900072f3 	.word	0x900072f3

c0d039b0 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d039b0:	b580      	push	{r7, lr}
c0d039b2:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN, parameters);
c0d039b4:	4807      	ldr	r0, [pc, #28]	; (c0d039d4 <io_seproxyhal_spi_is_status_sent+0x24>)
c0d039b6:	a901      	add	r1, sp, #4
c0d039b8:	f7ff fed0 	bl	c0d0375c <SVC_Call>
c0d039bc:	466a      	mov	r2, sp
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d039be:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT) {
c0d039c0:	4905      	ldr	r1, [pc, #20]	; (c0d039d8 <io_seproxyhal_spi_is_status_sent+0x28>)
c0d039c2:	4288      	cmp	r0, r1
c0d039c4:	d102      	bne.n	c0d039cc <io_seproxyhal_spi_is_status_sent+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d039c6:	9800      	ldr	r0, [sp, #0]
c0d039c8:	b002      	add	sp, #8
c0d039ca:	bd80      	pop	{r7, pc}
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d039cc:	2004      	movs	r0, #4
c0d039ce:	f7ff fa8e 	bl	c0d02eee <os_longjmp>
c0d039d2:	46c0      	nop			; (mov r8, r8)
c0d039d4:	600073cf 	.word	0x600073cf
c0d039d8:	9000737f 	.word	0x9000737f

c0d039dc <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d039dc:	b580      	push	{r7, lr}
c0d039de:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+3];
  parameters[0] = (unsigned int)buffer;
c0d039e0:	ab00      	add	r3, sp, #0
c0d039e2:	c307      	stmia	r3!, {r0, r1, r2}
  parameters[1] = (unsigned int)maxlength;
  parameters[2] = (unsigned int)flags;
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_recv_ID_IN, parameters);
c0d039e4:	4807      	ldr	r0, [pc, #28]	; (c0d03a04 <io_seproxyhal_spi_recv+0x28>)
c0d039e6:	4669      	mov	r1, sp
c0d039e8:	f7ff feb8 	bl	c0d0375c <SVC_Call>
c0d039ec:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d039ee:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_io_seproxyhal_spi_recv_ID_OUT) {
c0d039f0:	4905      	ldr	r1, [pc, #20]	; (c0d03a08 <io_seproxyhal_spi_recv+0x2c>)
c0d039f2:	4288      	cmp	r0, r1
c0d039f4:	d103      	bne.n	c0d039fe <io_seproxyhal_spi_recv+0x22>
c0d039f6:	a803      	add	r0, sp, #12
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d039f8:	8800      	ldrh	r0, [r0, #0]
c0d039fa:	b004      	add	sp, #16
c0d039fc:	bd80      	pop	{r7, pc}
  parameters[1] = (unsigned int)maxlength;
  parameters[2] = (unsigned int)flags;
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_recv_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_io_seproxyhal_spi_recv_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d039fe:	2004      	movs	r0, #4
c0d03a00:	f7ff fa75 	bl	c0d02eee <os_longjmp>
c0d03a04:	600074d1 	.word	0x600074d1
c0d03a08:	9000742b 	.word	0x9000742b

c0d03a0c <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d03a0c:	4902      	ldr	r1, [pc, #8]	; (c0d03a18 <USBD_LL_Init+0xc>)
c0d03a0e:	2000      	movs	r0, #0
c0d03a10:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d03a12:	4902      	ldr	r1, [pc, #8]	; (c0d03a1c <USBD_LL_Init+0x10>)
c0d03a14:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d03a16:	4770      	bx	lr
c0d03a18:	20001bb8 	.word	0x20001bb8
c0d03a1c:	20001bbc 	.word	0x20001bbc

c0d03a20 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d03a20:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d03a22:	4807      	ldr	r0, [pc, #28]	; (c0d03a40 <USBD_LL_DeInit+0x20>)
c0d03a24:	214f      	movs	r1, #79	; 0x4f
c0d03a26:	7001      	strb	r1, [r0, #0]
c0d03a28:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d03a2a:	7044      	strb	r4, [r0, #1]
c0d03a2c:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d03a2e:	7081      	strb	r1, [r0, #2]
c0d03a30:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d03a32:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d03a34:	2104      	movs	r1, #4
c0d03a36:	f7ff ffa5 	bl	c0d03984 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d03a3a:	4620      	mov	r0, r4
c0d03a3c:	bd10      	pop	{r4, pc}
c0d03a3e:	46c0      	nop			; (mov r8, r8)
c0d03a40:	20001800 	.word	0x20001800

c0d03a44 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d03a44:	b570      	push	{r4, r5, r6, lr}
c0d03a46:	b082      	sub	sp, #8
c0d03a48:	466d      	mov	r5, sp
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d03a4a:	264f      	movs	r6, #79	; 0x4f
c0d03a4c:	702e      	strb	r6, [r5, #0]
c0d03a4e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d03a50:	706c      	strb	r4, [r5, #1]
c0d03a52:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d03a54:	70a8      	strb	r0, [r5, #2]
c0d03a56:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d03a58:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d03a5a:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d03a5c:	2105      	movs	r1, #5
c0d03a5e:	4628      	mov	r0, r5
c0d03a60:	f7ff ff90 	bl	c0d03984 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d03a64:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d03a66:	706c      	strb	r4, [r5, #1]
c0d03a68:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d03a6a:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d03a6c:	70e8      	strb	r0, [r5, #3]
c0d03a6e:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d03a70:	4628      	mov	r0, r5
c0d03a72:	f7ff ff87 	bl	c0d03984 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d03a76:	4620      	mov	r0, r4
c0d03a78:	b002      	add	sp, #8
c0d03a7a:	bd70      	pop	{r4, r5, r6, pc}

c0d03a7c <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d03a7c:	b510      	push	{r4, lr}
c0d03a7e:	b082      	sub	sp, #8
c0d03a80:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d03a82:	214f      	movs	r1, #79	; 0x4f
c0d03a84:	7001      	strb	r1, [r0, #0]
c0d03a86:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d03a88:	7044      	strb	r4, [r0, #1]
c0d03a8a:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d03a8c:	7081      	strb	r1, [r0, #2]
c0d03a8e:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d03a90:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d03a92:	2104      	movs	r1, #4
c0d03a94:	f7ff ff76 	bl	c0d03984 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d03a98:	4620      	mov	r0, r4
c0d03a9a:	b002      	add	sp, #8
c0d03a9c:	bd10      	pop	{r4, pc}
	...

c0d03aa0 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d03aa0:	b5b0      	push	{r4, r5, r7, lr}
c0d03aa2:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d03aa4:	480e      	ldr	r0, [pc, #56]	; (c0d03ae0 <USBD_LL_OpenEP+0x40>)
c0d03aa6:	2400      	movs	r4, #0
c0d03aa8:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d03aaa:	480e      	ldr	r0, [pc, #56]	; (c0d03ae4 <USBD_LL_OpenEP+0x44>)
c0d03aac:	6004      	str	r4, [r0, #0]
c0d03aae:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d03ab0:	254f      	movs	r5, #79	; 0x4f
c0d03ab2:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d03ab4:	7044      	strb	r4, [r0, #1]
c0d03ab6:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d03ab8:	7085      	strb	r5, [r0, #2]
c0d03aba:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d03abc:	70c5      	strb	r5, [r0, #3]
c0d03abe:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d03ac0:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d03ac2:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d03ac4:	2a03      	cmp	r2, #3
c0d03ac6:	d802      	bhi.n	c0d03ace <USBD_LL_OpenEP+0x2e>
c0d03ac8:	00d0      	lsls	r0, r2, #3
c0d03aca:	4c07      	ldr	r4, [pc, #28]	; (c0d03ae8 <USBD_LL_OpenEP+0x48>)
c0d03acc:	40c4      	lsrs	r4, r0
c0d03ace:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d03ad0:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d03ad2:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d03ad4:	2108      	movs	r1, #8
c0d03ad6:	f7ff ff55 	bl	c0d03984 <io_seproxyhal_spi_send>
c0d03ada:	2000      	movs	r0, #0
  return USBD_OK; 
c0d03adc:	b002      	add	sp, #8
c0d03ade:	bdb0      	pop	{r4, r5, r7, pc}
c0d03ae0:	20001bb8 	.word	0x20001bb8
c0d03ae4:	20001bbc 	.word	0x20001bbc
c0d03ae8:	02030401 	.word	0x02030401

c0d03aec <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d03aec:	b510      	push	{r4, lr}
c0d03aee:	b082      	sub	sp, #8
c0d03af0:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d03af2:	224f      	movs	r2, #79	; 0x4f
c0d03af4:	7002      	strb	r2, [r0, #0]
c0d03af6:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d03af8:	7044      	strb	r4, [r0, #1]
c0d03afa:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d03afc:	7082      	strb	r2, [r0, #2]
c0d03afe:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d03b00:	70c2      	strb	r2, [r0, #3]
c0d03b02:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d03b04:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d03b06:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d03b08:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d03b0a:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d03b0c:	2108      	movs	r1, #8
c0d03b0e:	f7ff ff39 	bl	c0d03984 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d03b12:	4620      	mov	r0, r4
c0d03b14:	b002      	add	sp, #8
c0d03b16:	bd10      	pop	{r4, pc}

c0d03b18 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d03b18:	b5b0      	push	{r4, r5, r7, lr}
c0d03b1a:	b082      	sub	sp, #8
c0d03b1c:	460d      	mov	r5, r1
c0d03b1e:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d03b20:	2150      	movs	r1, #80	; 0x50
c0d03b22:	7001      	strb	r1, [r0, #0]
c0d03b24:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d03b26:	7044      	strb	r4, [r0, #1]
c0d03b28:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d03b2a:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d03b2c:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d03b2e:	2140      	movs	r1, #64	; 0x40
c0d03b30:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d03b32:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d03b34:	2106      	movs	r1, #6
c0d03b36:	f7ff ff25 	bl	c0d03984 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d03b3a:	2080      	movs	r0, #128	; 0x80
c0d03b3c:	4205      	tst	r5, r0
c0d03b3e:	d101      	bne.n	c0d03b44 <USBD_LL_StallEP+0x2c>
c0d03b40:	4807      	ldr	r0, [pc, #28]	; (c0d03b60 <USBD_LL_StallEP+0x48>)
c0d03b42:	e000      	b.n	c0d03b46 <USBD_LL_StallEP+0x2e>
c0d03b44:	4805      	ldr	r0, [pc, #20]	; (c0d03b5c <USBD_LL_StallEP+0x44>)
c0d03b46:	6801      	ldr	r1, [r0, #0]
c0d03b48:	227f      	movs	r2, #127	; 0x7f
c0d03b4a:	4015      	ands	r5, r2
c0d03b4c:	2201      	movs	r2, #1
c0d03b4e:	40aa      	lsls	r2, r5
c0d03b50:	430a      	orrs	r2, r1
c0d03b52:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d03b54:	4620      	mov	r0, r4
c0d03b56:	b002      	add	sp, #8
c0d03b58:	bdb0      	pop	{r4, r5, r7, pc}
c0d03b5a:	46c0      	nop			; (mov r8, r8)
c0d03b5c:	20001bb8 	.word	0x20001bb8
c0d03b60:	20001bbc 	.word	0x20001bbc

c0d03b64 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d03b64:	b570      	push	{r4, r5, r6, lr}
c0d03b66:	b082      	sub	sp, #8
c0d03b68:	460d      	mov	r5, r1
c0d03b6a:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d03b6c:	2150      	movs	r1, #80	; 0x50
c0d03b6e:	7001      	strb	r1, [r0, #0]
c0d03b70:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d03b72:	7044      	strb	r4, [r0, #1]
c0d03b74:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d03b76:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d03b78:	70c5      	strb	r5, [r0, #3]
c0d03b7a:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d03b7c:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d03b7e:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d03b80:	2106      	movs	r1, #6
c0d03b82:	f7ff feff 	bl	c0d03984 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d03b86:	4235      	tst	r5, r6
c0d03b88:	d101      	bne.n	c0d03b8e <USBD_LL_ClearStallEP+0x2a>
c0d03b8a:	4807      	ldr	r0, [pc, #28]	; (c0d03ba8 <USBD_LL_ClearStallEP+0x44>)
c0d03b8c:	e000      	b.n	c0d03b90 <USBD_LL_ClearStallEP+0x2c>
c0d03b8e:	4805      	ldr	r0, [pc, #20]	; (c0d03ba4 <USBD_LL_ClearStallEP+0x40>)
c0d03b90:	6801      	ldr	r1, [r0, #0]
c0d03b92:	227f      	movs	r2, #127	; 0x7f
c0d03b94:	4015      	ands	r5, r2
c0d03b96:	2201      	movs	r2, #1
c0d03b98:	40aa      	lsls	r2, r5
c0d03b9a:	4391      	bics	r1, r2
c0d03b9c:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d03b9e:	4620      	mov	r0, r4
c0d03ba0:	b002      	add	sp, #8
c0d03ba2:	bd70      	pop	{r4, r5, r6, pc}
c0d03ba4:	20001bb8 	.word	0x20001bb8
c0d03ba8:	20001bbc 	.word	0x20001bbc

c0d03bac <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d03bac:	2080      	movs	r0, #128	; 0x80
c0d03bae:	4201      	tst	r1, r0
c0d03bb0:	d001      	beq.n	c0d03bb6 <USBD_LL_IsStallEP+0xa>
c0d03bb2:	4806      	ldr	r0, [pc, #24]	; (c0d03bcc <USBD_LL_IsStallEP+0x20>)
c0d03bb4:	e000      	b.n	c0d03bb8 <USBD_LL_IsStallEP+0xc>
c0d03bb6:	4804      	ldr	r0, [pc, #16]	; (c0d03bc8 <USBD_LL_IsStallEP+0x1c>)
c0d03bb8:	6800      	ldr	r0, [r0, #0]
c0d03bba:	227f      	movs	r2, #127	; 0x7f
c0d03bbc:	4011      	ands	r1, r2
c0d03bbe:	2201      	movs	r2, #1
c0d03bc0:	408a      	lsls	r2, r1
c0d03bc2:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d03bc4:	b2d0      	uxtb	r0, r2
c0d03bc6:	4770      	bx	lr
c0d03bc8:	20001bbc 	.word	0x20001bbc
c0d03bcc:	20001bb8 	.word	0x20001bb8

c0d03bd0 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d03bd0:	b510      	push	{r4, lr}
c0d03bd2:	b082      	sub	sp, #8
c0d03bd4:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d03bd6:	224f      	movs	r2, #79	; 0x4f
c0d03bd8:	7002      	strb	r2, [r0, #0]
c0d03bda:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d03bdc:	7044      	strb	r4, [r0, #1]
c0d03bde:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d03be0:	7082      	strb	r2, [r0, #2]
c0d03be2:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d03be4:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d03be6:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d03be8:	2105      	movs	r1, #5
c0d03bea:	f7ff fecb 	bl	c0d03984 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d03bee:	4620      	mov	r0, r4
c0d03bf0:	b002      	add	sp, #8
c0d03bf2:	bd10      	pop	{r4, pc}

c0d03bf4 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d03bf4:	b5b0      	push	{r4, r5, r7, lr}
c0d03bf6:	b082      	sub	sp, #8
c0d03bf8:	461c      	mov	r4, r3
c0d03bfa:	4615      	mov	r5, r2
c0d03bfc:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d03bfe:	2250      	movs	r2, #80	; 0x50
c0d03c00:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d03c02:	1ce2      	adds	r2, r4, #3
c0d03c04:	0a13      	lsrs	r3, r2, #8
c0d03c06:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d03c08:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d03c0a:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d03c0c:	2120      	movs	r1, #32
c0d03c0e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d03c10:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d03c12:	2106      	movs	r1, #6
c0d03c14:	f7ff feb6 	bl	c0d03984 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d03c18:	4628      	mov	r0, r5
c0d03c1a:	4621      	mov	r1, r4
c0d03c1c:	f7ff feb2 	bl	c0d03984 <io_seproxyhal_spi_send>
c0d03c20:	2000      	movs	r0, #0
  return USBD_OK;   
c0d03c22:	b002      	add	sp, #8
c0d03c24:	bdb0      	pop	{r4, r5, r7, pc}

c0d03c26 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d03c26:	b510      	push	{r4, lr}
c0d03c28:	b082      	sub	sp, #8
c0d03c2a:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d03c2c:	2350      	movs	r3, #80	; 0x50
c0d03c2e:	7003      	strb	r3, [r0, #0]
c0d03c30:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d03c32:	7044      	strb	r4, [r0, #1]
c0d03c34:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d03c36:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d03c38:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d03c3a:	2130      	movs	r1, #48	; 0x30
c0d03c3c:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d03c3e:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d03c40:	2106      	movs	r1, #6
c0d03c42:	f7ff fe9f 	bl	c0d03984 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d03c46:	4620      	mov	r0, r4
c0d03c48:	b002      	add	sp, #8
c0d03c4a:	bd10      	pop	{r4, pc}

c0d03c4c <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d03c4c:	b570      	push	{r4, r5, r6, lr}
c0d03c4e:	4615      	mov	r5, r2
c0d03c50:	460e      	mov	r6, r1
c0d03c52:	4604      	mov	r4, r0
c0d03c54:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d03c56:	2c00      	cmp	r4, #0
c0d03c58:	d011      	beq.n	c0d03c7e <USBD_Init+0x32>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d03c5a:	204d      	movs	r0, #77	; 0x4d
c0d03c5c:	0081      	lsls	r1, r0, #2
c0d03c5e:	4620      	mov	r0, r4
c0d03c60:	f000 fe7c 	bl	c0d0495c <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d03c64:	2e00      	cmp	r6, #0
c0d03c66:	d002      	beq.n	c0d03c6e <USBD_Init+0x22>
  {
    pdev->pDesc = pdesc;
c0d03c68:	2011      	movs	r0, #17
c0d03c6a:	0100      	lsls	r0, r0, #4
c0d03c6c:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d03c6e:	20fc      	movs	r0, #252	; 0xfc
c0d03c70:	2101      	movs	r1, #1
c0d03c72:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d03c74:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d03c76:	4620      	mov	r0, r4
c0d03c78:	f7ff fec8 	bl	c0d03a0c <USBD_LL_Init>
c0d03c7c:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d03c7e:	b2c0      	uxtb	r0, r0
c0d03c80:	bd70      	pop	{r4, r5, r6, pc}

c0d03c82 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d03c82:	b570      	push	{r4, r5, r6, lr}
c0d03c84:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d03c86:	20fc      	movs	r0, #252	; 0xfc
c0d03c88:	2101      	movs	r1, #1
c0d03c8a:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03c8c:	2045      	movs	r0, #69	; 0x45
c0d03c8e:	0080      	lsls	r0, r0, #2
c0d03c90:	1825      	adds	r5, r4, r0
c0d03c92:	2600      	movs	r6, #0
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d03c94:	00f0      	lsls	r0, r6, #3
c0d03c96:	5828      	ldr	r0, [r5, r0]
c0d03c98:	2800      	cmp	r0, #0
c0d03c9a:	d006      	beq.n	c0d03caa <USBD_DeInit+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d03c9c:	6840      	ldr	r0, [r0, #4]
c0d03c9e:	f7ff fd47 	bl	c0d03730 <pic>
c0d03ca2:	4602      	mov	r2, r0
c0d03ca4:	7921      	ldrb	r1, [r4, #4]
c0d03ca6:	4620      	mov	r0, r4
c0d03ca8:	4790      	blx	r2
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03caa:	1c76      	adds	r6, r6, #1
c0d03cac:	2e03      	cmp	r6, #3
c0d03cae:	d1f1      	bne.n	c0d03c94 <USBD_DeInit+0x12>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d03cb0:	4620      	mov	r0, r4
c0d03cb2:	f7ff fee3 	bl	c0d03a7c <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d03cb6:	4620      	mov	r0, r4
c0d03cb8:	f7ff feb2 	bl	c0d03a20 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d03cbc:	2000      	movs	r0, #0
c0d03cbe:	bd70      	pop	{r4, r5, r6, pc}

c0d03cc0 <USBD_RegisterClassForInterface>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d03cc0:	2302      	movs	r3, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d03cc2:	2a00      	cmp	r2, #0
c0d03cc4:	d007      	beq.n	c0d03cd6 <USBD_RegisterClassForInterface+0x16>
c0d03cc6:	2300      	movs	r3, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d03cc8:	2802      	cmp	r0, #2
c0d03cca:	d804      	bhi.n	c0d03cd6 <USBD_RegisterClassForInterface+0x16>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d03ccc:	00c0      	lsls	r0, r0, #3
c0d03cce:	1808      	adds	r0, r1, r0
c0d03cd0:	2145      	movs	r1, #69	; 0x45
c0d03cd2:	0089      	lsls	r1, r1, #2
c0d03cd4:	5042      	str	r2, [r0, r1]
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d03cd6:	b2d8      	uxtb	r0, r3
c0d03cd8:	4770      	bx	lr

c0d03cda <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d03cda:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d03cdc:	f7ff feb2 	bl	c0d03a44 <USBD_LL_Start>
  
  return USBD_OK;  
c0d03ce0:	2000      	movs	r0, #0
c0d03ce2:	bd80      	pop	{r7, pc}

c0d03ce4 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d03ce4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03ce6:	b081      	sub	sp, #4
c0d03ce8:	460c      	mov	r4, r1
c0d03cea:	4605      	mov	r5, r0
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03cec:	2045      	movs	r0, #69	; 0x45
c0d03cee:	0080      	lsls	r0, r0, #2
c0d03cf0:	182f      	adds	r7, r5, r0
c0d03cf2:	2600      	movs	r6, #0
    if(usbd_is_valid_intf(pdev, intf)) {
c0d03cf4:	4628      	mov	r0, r5
c0d03cf6:	4631      	mov	r1, r6
c0d03cf8:	f000 f97c 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03cfc:	2800      	cmp	r0, #0
c0d03cfe:	d008      	beq.n	c0d03d12 <USBD_SetClassConfig+0x2e>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d03d00:	00f0      	lsls	r0, r6, #3
c0d03d02:	5838      	ldr	r0, [r7, r0]
c0d03d04:	6800      	ldr	r0, [r0, #0]
c0d03d06:	f7ff fd13 	bl	c0d03730 <pic>
c0d03d0a:	4602      	mov	r2, r0
c0d03d0c:	4628      	mov	r0, r5
c0d03d0e:	4621      	mov	r1, r4
c0d03d10:	4790      	blx	r2

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03d12:	1c76      	adds	r6, r6, #1
c0d03d14:	2e03      	cmp	r6, #3
c0d03d16:	d1ed      	bne.n	c0d03cf4 <USBD_SetClassConfig+0x10>
    if(usbd_is_valid_intf(pdev, intf)) {
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
    }
  }

  return USBD_OK; 
c0d03d18:	2000      	movs	r0, #0
c0d03d1a:	b001      	add	sp, #4
c0d03d1c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03d1e <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d03d1e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03d20:	b081      	sub	sp, #4
c0d03d22:	460c      	mov	r4, r1
c0d03d24:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03d26:	2045      	movs	r0, #69	; 0x45
c0d03d28:	0080      	lsls	r0, r0, #2
c0d03d2a:	182f      	adds	r7, r5, r0
c0d03d2c:	2600      	movs	r6, #0
    if(usbd_is_valid_intf(pdev, intf)) {
c0d03d2e:	4628      	mov	r0, r5
c0d03d30:	4631      	mov	r1, r6
c0d03d32:	f000 f95f 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03d36:	2800      	cmp	r0, #0
c0d03d38:	d008      	beq.n	c0d03d4c <USBD_ClrClassConfig+0x2e>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d03d3a:	00f0      	lsls	r0, r6, #3
c0d03d3c:	5838      	ldr	r0, [r7, r0]
c0d03d3e:	6840      	ldr	r0, [r0, #4]
c0d03d40:	f7ff fcf6 	bl	c0d03730 <pic>
c0d03d44:	4602      	mov	r2, r0
c0d03d46:	4628      	mov	r0, r5
c0d03d48:	4621      	mov	r1, r4
c0d03d4a:	4790      	blx	r2
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03d4c:	1c76      	adds	r6, r6, #1
c0d03d4e:	2e03      	cmp	r6, #3
c0d03d50:	d1ed      	bne.n	c0d03d2e <USBD_ClrClassConfig+0x10>
    if(usbd_is_valid_intf(pdev, intf)) {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
    }
  }
  return USBD_OK;
c0d03d52:	2000      	movs	r0, #0
c0d03d54:	b001      	add	sp, #4
c0d03d56:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03d58 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d03d58:	b570      	push	{r4, r5, r6, lr}
c0d03d5a:	4604      	mov	r4, r0
c0d03d5c:	2021      	movs	r0, #33	; 0x21
c0d03d5e:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d03d60:	19a5      	adds	r5, r4, r6
c0d03d62:	4628      	mov	r0, r5
c0d03d64:	f000 fba7 	bl	c0d044b6 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d03d68:	20f4      	movs	r0, #244	; 0xf4
c0d03d6a:	2101      	movs	r1, #1
c0d03d6c:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d03d6e:	2087      	movs	r0, #135	; 0x87
c0d03d70:	0040      	lsls	r0, r0, #1
c0d03d72:	5a20      	ldrh	r0, [r4, r0]
c0d03d74:	21f8      	movs	r1, #248	; 0xf8
c0d03d76:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d03d78:	5da1      	ldrb	r1, [r4, r6]
c0d03d7a:	201f      	movs	r0, #31
c0d03d7c:	4008      	ands	r0, r1
c0d03d7e:	2802      	cmp	r0, #2
c0d03d80:	d008      	beq.n	c0d03d94 <USBD_LL_SetupStage+0x3c>
c0d03d82:	2801      	cmp	r0, #1
c0d03d84:	d00b      	beq.n	c0d03d9e <USBD_LL_SetupStage+0x46>
c0d03d86:	2800      	cmp	r0, #0
c0d03d88:	d10e      	bne.n	c0d03da8 <USBD_LL_SetupStage+0x50>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d03d8a:	4620      	mov	r0, r4
c0d03d8c:	4629      	mov	r1, r5
c0d03d8e:	f000 f93f 	bl	c0d04010 <USBD_StdDevReq>
c0d03d92:	e00e      	b.n	c0d03db2 <USBD_LL_SetupStage+0x5a>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d03d94:	4620      	mov	r0, r4
c0d03d96:	4629      	mov	r1, r5
c0d03d98:	f000 fb02 	bl	c0d043a0 <USBD_StdEPReq>
c0d03d9c:	e009      	b.n	c0d03db2 <USBD_LL_SetupStage+0x5a>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d03d9e:	4620      	mov	r0, r4
c0d03da0:	4629      	mov	r1, r5
c0d03da2:	f000 fad8 	bl	c0d04356 <USBD_StdItfReq>
c0d03da6:	e004      	b.n	c0d03db2 <USBD_LL_SetupStage+0x5a>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d03da8:	2080      	movs	r0, #128	; 0x80
c0d03daa:	4001      	ands	r1, r0
c0d03dac:	4620      	mov	r0, r4
c0d03dae:	f7ff feb3 	bl	c0d03b18 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d03db2:	2000      	movs	r0, #0
c0d03db4:	bd70      	pop	{r4, r5, r6, pc}

c0d03db6 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d03db6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03db8:	b083      	sub	sp, #12
c0d03dba:	9202      	str	r2, [sp, #8]
c0d03dbc:	4604      	mov	r4, r0
c0d03dbe:	9101      	str	r1, [sp, #4]
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d03dc0:	2900      	cmp	r1, #0
c0d03dc2:	d01e      	beq.n	c0d03e02 <USBD_LL_DataOutStage+0x4c>
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03dc4:	2045      	movs	r0, #69	; 0x45
c0d03dc6:	0080      	lsls	r0, r0, #2
c0d03dc8:	1825      	adds	r5, r4, r0
c0d03dca:	4626      	mov	r6, r4
c0d03dcc:	36fc      	adds	r6, #252	; 0xfc
c0d03dce:	2700      	movs	r7, #0
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d03dd0:	4620      	mov	r0, r4
c0d03dd2:	4639      	mov	r1, r7
c0d03dd4:	f000 f90e 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03dd8:	2800      	cmp	r0, #0
c0d03dda:	d00e      	beq.n	c0d03dfa <USBD_LL_DataOutStage+0x44>
c0d03ddc:	00f8      	lsls	r0, r7, #3
c0d03dde:	5828      	ldr	r0, [r5, r0]
c0d03de0:	6980      	ldr	r0, [r0, #24]
c0d03de2:	2800      	cmp	r0, #0
c0d03de4:	d009      	beq.n	c0d03dfa <USBD_LL_DataOutStage+0x44>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d03de6:	7831      	ldrb	r1, [r6, #0]
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d03de8:	2903      	cmp	r1, #3
c0d03dea:	d106      	bne.n	c0d03dfa <USBD_LL_DataOutStage+0x44>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d03dec:	f7ff fca0 	bl	c0d03730 <pic>
c0d03df0:	4603      	mov	r3, r0
c0d03df2:	4620      	mov	r0, r4
c0d03df4:	9901      	ldr	r1, [sp, #4]
c0d03df6:	9a02      	ldr	r2, [sp, #8]
c0d03df8:	4798      	blx	r3
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03dfa:	1c7f      	adds	r7, r7, #1
c0d03dfc:	2f03      	cmp	r7, #3
c0d03dfe:	d1e7      	bne.n	c0d03dd0 <USBD_LL_DataOutStage+0x1a>
c0d03e00:	e035      	b.n	c0d03e6e <USBD_LL_DataOutStage+0xb8>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d03e02:	20f4      	movs	r0, #244	; 0xf4
c0d03e04:	5820      	ldr	r0, [r4, r0]
c0d03e06:	2803      	cmp	r0, #3
c0d03e08:	d131      	bne.n	c0d03e6e <USBD_LL_DataOutStage+0xb8>
    {
      if(pep->rem_length > pep->maxpacket)
c0d03e0a:	2090      	movs	r0, #144	; 0x90
c0d03e0c:	5820      	ldr	r0, [r4, r0]
c0d03e0e:	218c      	movs	r1, #140	; 0x8c
c0d03e10:	5861      	ldr	r1, [r4, r1]
c0d03e12:	4622      	mov	r2, r4
c0d03e14:	328c      	adds	r2, #140	; 0x8c
c0d03e16:	4281      	cmp	r1, r0
c0d03e18:	d90a      	bls.n	c0d03e30 <USBD_LL_DataOutStage+0x7a>
      {
        pep->rem_length -=  pep->maxpacket;
c0d03e1a:	1a09      	subs	r1, r1, r0
c0d03e1c:	6011      	str	r1, [r2, #0]
c0d03e1e:	4281      	cmp	r1, r0
c0d03e20:	d300      	bcc.n	c0d03e24 <USBD_LL_DataOutStage+0x6e>
c0d03e22:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d03e24:	b28a      	uxth	r2, r1
c0d03e26:	4620      	mov	r0, r4
c0d03e28:	9902      	ldr	r1, [sp, #8]
c0d03e2a:	f000 fcc1 	bl	c0d047b0 <USBD_CtlContinueRx>
c0d03e2e:	e01e      	b.n	c0d03e6e <USBD_LL_DataOutStage+0xb8>
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03e30:	2045      	movs	r0, #69	; 0x45
c0d03e32:	0080      	lsls	r0, r0, #2
c0d03e34:	1826      	adds	r6, r4, r0
c0d03e36:	4627      	mov	r7, r4
c0d03e38:	37fc      	adds	r7, #252	; 0xfc
c0d03e3a:	2500      	movs	r5, #0
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d03e3c:	4620      	mov	r0, r4
c0d03e3e:	4629      	mov	r1, r5
c0d03e40:	f000 f8d8 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03e44:	2800      	cmp	r0, #0
c0d03e46:	d00c      	beq.n	c0d03e62 <USBD_LL_DataOutStage+0xac>
c0d03e48:	00e8      	lsls	r0, r5, #3
c0d03e4a:	5830      	ldr	r0, [r6, r0]
c0d03e4c:	6900      	ldr	r0, [r0, #16]
c0d03e4e:	2800      	cmp	r0, #0
c0d03e50:	d007      	beq.n	c0d03e62 <USBD_LL_DataOutStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d03e52:	7839      	ldrb	r1, [r7, #0]
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d03e54:	2903      	cmp	r1, #3
c0d03e56:	d104      	bne.n	c0d03e62 <USBD_LL_DataOutStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d03e58:	f7ff fc6a 	bl	c0d03730 <pic>
c0d03e5c:	4601      	mov	r1, r0
c0d03e5e:	4620      	mov	r0, r4
c0d03e60:	4788      	blx	r1
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03e62:	1c6d      	adds	r5, r5, #1
c0d03e64:	2d03      	cmp	r5, #3
c0d03e66:	d1e9      	bne.n	c0d03e3c <USBD_LL_DataOutStage+0x86>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
          }
        }
        USBD_CtlSendStatus(pdev);
c0d03e68:	4620      	mov	r0, r4
c0d03e6a:	f000 fca8 	bl	c0d047be <USBD_CtlSendStatus>
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
      }
    }
  }  
  return USBD_OK;
c0d03e6e:	2000      	movs	r0, #0
c0d03e70:	b003      	add	sp, #12
c0d03e72:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03e74 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d03e74:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03e76:	b081      	sub	sp, #4
c0d03e78:	4604      	mov	r4, r0
c0d03e7a:	9100      	str	r1, [sp, #0]
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d03e7c:	2900      	cmp	r1, #0
c0d03e7e:	d01d      	beq.n	c0d03ebc <USBD_LL_DataInStage+0x48>
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03e80:	2045      	movs	r0, #69	; 0x45
c0d03e82:	0080      	lsls	r0, r0, #2
c0d03e84:	1827      	adds	r7, r4, r0
c0d03e86:	4625      	mov	r5, r4
c0d03e88:	35fc      	adds	r5, #252	; 0xfc
c0d03e8a:	2600      	movs	r6, #0
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d03e8c:	4620      	mov	r0, r4
c0d03e8e:	4631      	mov	r1, r6
c0d03e90:	f000 f8b0 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03e94:	2800      	cmp	r0, #0
c0d03e96:	d00d      	beq.n	c0d03eb4 <USBD_LL_DataInStage+0x40>
c0d03e98:	00f0      	lsls	r0, r6, #3
c0d03e9a:	5838      	ldr	r0, [r7, r0]
c0d03e9c:	6940      	ldr	r0, [r0, #20]
c0d03e9e:	2800      	cmp	r0, #0
c0d03ea0:	d008      	beq.n	c0d03eb4 <USBD_LL_DataInStage+0x40>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d03ea2:	7829      	ldrb	r1, [r5, #0]
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d03ea4:	2903      	cmp	r1, #3
c0d03ea6:	d105      	bne.n	c0d03eb4 <USBD_LL_DataInStage+0x40>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d03ea8:	f7ff fc42 	bl	c0d03730 <pic>
c0d03eac:	4602      	mov	r2, r0
c0d03eae:	4620      	mov	r0, r4
c0d03eb0:	9900      	ldr	r1, [sp, #0]
c0d03eb2:	4790      	blx	r2
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03eb4:	1c76      	adds	r6, r6, #1
c0d03eb6:	2e03      	cmp	r6, #3
c0d03eb8:	d1e8      	bne.n	c0d03e8c <USBD_LL_DataInStage+0x18>
c0d03eba:	e051      	b.n	c0d03f60 <USBD_LL_DataInStage+0xec>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d03ebc:	20f4      	movs	r0, #244	; 0xf4
c0d03ebe:	5820      	ldr	r0, [r4, r0]
c0d03ec0:	2802      	cmp	r0, #2
c0d03ec2:	d145      	bne.n	c0d03f50 <USBD_LL_DataInStage+0xdc>
    {
      if(pep->rem_length > pep->maxpacket)
c0d03ec4:	69e0      	ldr	r0, [r4, #28]
c0d03ec6:	6a25      	ldr	r5, [r4, #32]
c0d03ec8:	42a8      	cmp	r0, r5
c0d03eca:	d90b      	bls.n	c0d03ee4 <USBD_LL_DataInStage+0x70>
      {
        pep->rem_length -=  pep->maxpacket;
c0d03ecc:	1b40      	subs	r0, r0, r5
c0d03ece:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d03ed0:	2113      	movs	r1, #19
c0d03ed2:	010a      	lsls	r2, r1, #4
c0d03ed4:	58a1      	ldr	r1, [r4, r2]
c0d03ed6:	1949      	adds	r1, r1, r5
c0d03ed8:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d03eda:	b282      	uxth	r2, r0
c0d03edc:	4620      	mov	r0, r4
c0d03ede:	f000 fc59 	bl	c0d04794 <USBD_CtlContinueSendData>
c0d03ee2:	e035      	b.n	c0d03f50 <USBD_LL_DataInStage+0xdc>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d03ee4:	69a6      	ldr	r6, [r4, #24]
c0d03ee6:	4630      	mov	r0, r6
c0d03ee8:	4629      	mov	r1, r5
c0d03eea:	f000 fd05 	bl	c0d048f8 <__aeabi_uidivmod>
c0d03eee:	42ae      	cmp	r6, r5
c0d03ef0:	d30f      	bcc.n	c0d03f12 <USBD_LL_DataInStage+0x9e>
c0d03ef2:	2900      	cmp	r1, #0
c0d03ef4:	d10d      	bne.n	c0d03f12 <USBD_LL_DataInStage+0x9e>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d03ef6:	20f8      	movs	r0, #248	; 0xf8
c0d03ef8:	5820      	ldr	r0, [r4, r0]
c0d03efa:	4627      	mov	r7, r4
c0d03efc:	37f8      	adds	r7, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d03efe:	4286      	cmp	r6, r0
c0d03f00:	d207      	bcs.n	c0d03f12 <USBD_LL_DataInStage+0x9e>
c0d03f02:	2500      	movs	r5, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d03f04:	4620      	mov	r0, r4
c0d03f06:	4629      	mov	r1, r5
c0d03f08:	462a      	mov	r2, r5
c0d03f0a:	f000 fc43 	bl	c0d04794 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d03f0e:	603d      	str	r5, [r7, #0]
c0d03f10:	e01e      	b.n	c0d03f50 <USBD_LL_DataInStage+0xdc>
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03f12:	2045      	movs	r0, #69	; 0x45
c0d03f14:	0080      	lsls	r0, r0, #2
c0d03f16:	1826      	adds	r6, r4, r0
c0d03f18:	4627      	mov	r7, r4
c0d03f1a:	37fc      	adds	r7, #252	; 0xfc
c0d03f1c:	2500      	movs	r5, #0
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d03f1e:	4620      	mov	r0, r4
c0d03f20:	4629      	mov	r1, r5
c0d03f22:	f000 f867 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03f26:	2800      	cmp	r0, #0
c0d03f28:	d00c      	beq.n	c0d03f44 <USBD_LL_DataInStage+0xd0>
c0d03f2a:	00e8      	lsls	r0, r5, #3
c0d03f2c:	5830      	ldr	r0, [r6, r0]
c0d03f2e:	68c0      	ldr	r0, [r0, #12]
c0d03f30:	2800      	cmp	r0, #0
c0d03f32:	d007      	beq.n	c0d03f44 <USBD_LL_DataInStage+0xd0>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d03f34:	7839      	ldrb	r1, [r7, #0]
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d03f36:	2903      	cmp	r1, #3
c0d03f38:	d104      	bne.n	c0d03f44 <USBD_LL_DataInStage+0xd0>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d03f3a:	f7ff fbf9 	bl	c0d03730 <pic>
c0d03f3e:	4601      	mov	r1, r0
c0d03f40:	4620      	mov	r0, r4
c0d03f42:	4788      	blx	r1
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03f44:	1c6d      	adds	r5, r5, #1
c0d03f46:	2d03      	cmp	r5, #3
c0d03f48:	d1e9      	bne.n	c0d03f1e <USBD_LL_DataInStage+0xaa>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
            }
          }
          USBD_CtlReceiveStatus(pdev);
c0d03f4a:	4620      	mov	r0, r4
c0d03f4c:	f000 fc43 	bl	c0d047d6 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d03f50:	2001      	movs	r0, #1
c0d03f52:	0201      	lsls	r1, r0, #8
c0d03f54:	1860      	adds	r0, r4, r1
c0d03f56:	5c61      	ldrb	r1, [r4, r1]
c0d03f58:	2901      	cmp	r1, #1
c0d03f5a:	d101      	bne.n	c0d03f60 <USBD_LL_DataInStage+0xec>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d03f5c:	2100      	movs	r1, #0
c0d03f5e:	7001      	strb	r1, [r0, #0]
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
      }
    }
  }
  return USBD_OK;
c0d03f60:	2000      	movs	r0, #0
c0d03f62:	b001      	add	sp, #4
c0d03f64:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03f66 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d03f66:	b570      	push	{r4, r5, r6, lr}
c0d03f68:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d03f6a:	2090      	movs	r0, #144	; 0x90
c0d03f6c:	2140      	movs	r1, #64	; 0x40
c0d03f6e:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d03f70:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d03f72:	20fc      	movs	r0, #252	; 0xfc
c0d03f74:	2101      	movs	r1, #1
c0d03f76:	5421      	strb	r1, [r4, r0]
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03f78:	2045      	movs	r0, #69	; 0x45
c0d03f7a:	0080      	lsls	r0, r0, #2
c0d03f7c:	1826      	adds	r6, r4, r0
c0d03f7e:	2500      	movs	r5, #0
    if( usbd_is_valid_intf(pdev, intf))
c0d03f80:	4620      	mov	r0, r4
c0d03f82:	4629      	mov	r1, r5
c0d03f84:	f000 f836 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03f88:	2800      	cmp	r0, #0
c0d03f8a:	d008      	beq.n	c0d03f9e <USBD_LL_Reset+0x38>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d03f8c:	00e8      	lsls	r0, r5, #3
c0d03f8e:	5830      	ldr	r0, [r6, r0]
c0d03f90:	6840      	ldr	r0, [r0, #4]
c0d03f92:	f7ff fbcd 	bl	c0d03730 <pic>
c0d03f96:	4602      	mov	r2, r0
c0d03f98:	7921      	ldrb	r1, [r4, #4]
c0d03f9a:	4620      	mov	r0, r4
c0d03f9c:	4790      	blx	r2
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03f9e:	1c6d      	adds	r5, r5, #1
c0d03fa0:	2d03      	cmp	r5, #3
c0d03fa2:	d1ed      	bne.n	c0d03f80 <USBD_LL_Reset+0x1a>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
    }
  }
  
  return USBD_OK;
c0d03fa4:	2000      	movs	r0, #0
c0d03fa6:	bd70      	pop	{r4, r5, r6, pc}

c0d03fa8 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d03fa8:	7401      	strb	r1, [r0, #16]
c0d03faa:	2000      	movs	r0, #0
  return USBD_OK;
c0d03fac:	4770      	bx	lr

c0d03fae <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d03fae:	2000      	movs	r0, #0
c0d03fb0:	4770      	bx	lr

c0d03fb2 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d03fb2:	2000      	movs	r0, #0
c0d03fb4:	4770      	bx	lr

c0d03fb6 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d03fb6:	b570      	push	{r4, r5, r6, lr}
c0d03fb8:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d03fba:	20fc      	movs	r0, #252	; 0xfc
c0d03fbc:	5c20      	ldrb	r0, [r4, r0]
c0d03fbe:	2803      	cmp	r0, #3
c0d03fc0:	d116      	bne.n	c0d03ff0 <USBD_LL_SOF+0x3a>
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d03fc2:	2045      	movs	r0, #69	; 0x45
c0d03fc4:	0080      	lsls	r0, r0, #2
c0d03fc6:	1826      	adds	r6, r4, r0
c0d03fc8:	2500      	movs	r5, #0
c0d03fca:	4620      	mov	r0, r4
c0d03fcc:	4629      	mov	r1, r5
c0d03fce:	f000 f811 	bl	c0d03ff4 <usbd_is_valid_intf>
c0d03fd2:	2800      	cmp	r0, #0
c0d03fd4:	d009      	beq.n	c0d03fea <USBD_LL_SOF+0x34>
c0d03fd6:	00e8      	lsls	r0, r5, #3
c0d03fd8:	5830      	ldr	r0, [r6, r0]
c0d03fda:	69c0      	ldr	r0, [r0, #28]
c0d03fdc:	2800      	cmp	r0, #0
c0d03fde:	d004      	beq.n	c0d03fea <USBD_LL_SOF+0x34>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d03fe0:	f7ff fba6 	bl	c0d03730 <pic>
c0d03fe4:	4601      	mov	r1, r0
c0d03fe6:	4620      	mov	r0, r4
c0d03fe8:	4788      	blx	r1
USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03fea:	1c6d      	adds	r5, r5, #1
c0d03fec:	2d03      	cmp	r5, #3
c0d03fee:	d1ec      	bne.n	c0d03fca <USBD_LL_SOF+0x14>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
      }
    }
  }
  return USBD_OK;
c0d03ff0:	2000      	movs	r0, #0
c0d03ff2:	bd70      	pop	{r4, r5, r6, pc}

c0d03ff4 <usbd_is_valid_intf>:

/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
c0d03ff4:	4602      	mov	r2, r0
c0d03ff6:	2000      	movs	r0, #0
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d03ff8:	2902      	cmp	r1, #2
c0d03ffa:	d808      	bhi.n	c0d0400e <usbd_is_valid_intf+0x1a>
c0d03ffc:	00c8      	lsls	r0, r1, #3
c0d03ffe:	1810      	adds	r0, r2, r0
c0d04000:	2145      	movs	r1, #69	; 0x45
c0d04002:	0089      	lsls	r1, r1, #2
c0d04004:	5841      	ldr	r1, [r0, r1]
c0d04006:	2001      	movs	r0, #1
c0d04008:	2900      	cmp	r1, #0
c0d0400a:	d100      	bne.n	c0d0400e <usbd_is_valid_intf+0x1a>
c0d0400c:	4608      	mov	r0, r1
c0d0400e:	4770      	bx	lr

c0d04010 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d04010:	b580      	push	{r7, lr}
c0d04012:	784a      	ldrb	r2, [r1, #1]
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d04014:	2a04      	cmp	r2, #4
c0d04016:	dd08      	ble.n	c0d0402a <USBD_StdDevReq+0x1a>
c0d04018:	2a07      	cmp	r2, #7
c0d0401a:	dc0f      	bgt.n	c0d0403c <USBD_StdDevReq+0x2c>
c0d0401c:	2a05      	cmp	r2, #5
c0d0401e:	d014      	beq.n	c0d0404a <USBD_StdDevReq+0x3a>
c0d04020:	2a06      	cmp	r2, #6
c0d04022:	d11b      	bne.n	c0d0405c <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d04024:	f000 f821 	bl	c0d0406a <USBD_GetDescriptor>
c0d04028:	e01d      	b.n	c0d04066 <USBD_StdDevReq+0x56>
c0d0402a:	2a00      	cmp	r2, #0
c0d0402c:	d010      	beq.n	c0d04050 <USBD_StdDevReq+0x40>
c0d0402e:	2a01      	cmp	r2, #1
c0d04030:	d017      	beq.n	c0d04062 <USBD_StdDevReq+0x52>
c0d04032:	2a03      	cmp	r2, #3
c0d04034:	d112      	bne.n	c0d0405c <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d04036:	f000 f93b 	bl	c0d042b0 <USBD_SetFeature>
c0d0403a:	e014      	b.n	c0d04066 <USBD_StdDevReq+0x56>
c0d0403c:	2a08      	cmp	r2, #8
c0d0403e:	d00a      	beq.n	c0d04056 <USBD_StdDevReq+0x46>
c0d04040:	2a09      	cmp	r2, #9
c0d04042:	d10b      	bne.n	c0d0405c <USBD_StdDevReq+0x4c>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d04044:	f000 f8c3 	bl	c0d041ce <USBD_SetConfig>
c0d04048:	e00d      	b.n	c0d04066 <USBD_StdDevReq+0x56>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d0404a:	f000 f89b 	bl	c0d04184 <USBD_SetAddress>
c0d0404e:	e00a      	b.n	c0d04066 <USBD_StdDevReq+0x56>
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d04050:	f000 f90b 	bl	c0d0426a <USBD_GetStatus>
c0d04054:	e007      	b.n	c0d04066 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d04056:	f000 f8f1 	bl	c0d0423c <USBD_GetConfig>
c0d0405a:	e004      	b.n	c0d04066 <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d0405c:	f000 f971 	bl	c0d04342 <USBD_CtlError>
c0d04060:	e001      	b.n	c0d04066 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d04062:	f000 f944 	bl	c0d042ee <USBD_ClrFeature>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d04066:	2000      	movs	r0, #0
c0d04068:	bd80      	pop	{r7, pc}

c0d0406a <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d0406a:	b5b0      	push	{r4, r5, r7, lr}
c0d0406c:	b082      	sub	sp, #8
c0d0406e:	460d      	mov	r5, r1
c0d04070:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d04072:	8869      	ldrh	r1, [r5, #2]
c0d04074:	0a08      	lsrs	r0, r1, #8
c0d04076:	2805      	cmp	r0, #5
c0d04078:	dc13      	bgt.n	c0d040a2 <USBD_GetDescriptor+0x38>
c0d0407a:	2801      	cmp	r0, #1
c0d0407c:	d01c      	beq.n	c0d040b8 <USBD_GetDescriptor+0x4e>
c0d0407e:	2802      	cmp	r0, #2
c0d04080:	d025      	beq.n	c0d040ce <USBD_GetDescriptor+0x64>
c0d04082:	2803      	cmp	r0, #3
c0d04084:	d13b      	bne.n	c0d040fe <USBD_GetDescriptor+0x94>
c0d04086:	b2c8      	uxtb	r0, r1
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d04088:	2802      	cmp	r0, #2
c0d0408a:	dc3d      	bgt.n	c0d04108 <USBD_GetDescriptor+0x9e>
c0d0408c:	2800      	cmp	r0, #0
c0d0408e:	d065      	beq.n	c0d0415c <USBD_GetDescriptor+0xf2>
c0d04090:	2801      	cmp	r0, #1
c0d04092:	d06d      	beq.n	c0d04170 <USBD_GetDescriptor+0x106>
c0d04094:	2802      	cmp	r0, #2
c0d04096:	d132      	bne.n	c0d040fe <USBD_GetDescriptor+0x94>
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d04098:	2011      	movs	r0, #17
c0d0409a:	0100      	lsls	r0, r0, #4
c0d0409c:	5820      	ldr	r0, [r4, r0]
c0d0409e:	68c0      	ldr	r0, [r0, #12]
c0d040a0:	e00e      	b.n	c0d040c0 <USBD_GetDescriptor+0x56>
c0d040a2:	2806      	cmp	r0, #6
c0d040a4:	d01e      	beq.n	c0d040e4 <USBD_GetDescriptor+0x7a>
c0d040a6:	2807      	cmp	r0, #7
c0d040a8:	d026      	beq.n	c0d040f8 <USBD_GetDescriptor+0x8e>
c0d040aa:	280f      	cmp	r0, #15
c0d040ac:	d127      	bne.n	c0d040fe <USBD_GetDescriptor+0x94>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d040ae:	2011      	movs	r0, #17
c0d040b0:	0100      	lsls	r0, r0, #4
c0d040b2:	5820      	ldr	r0, [r4, r0]
c0d040b4:	69c0      	ldr	r0, [r0, #28]
c0d040b6:	e003      	b.n	c0d040c0 <USBD_GetDescriptor+0x56>
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d040b8:	2011      	movs	r0, #17
c0d040ba:	0100      	lsls	r0, r0, #4
c0d040bc:	5820      	ldr	r0, [r4, r0]
c0d040be:	6800      	ldr	r0, [r0, #0]
c0d040c0:	f7ff fb36 	bl	c0d03730 <pic>
c0d040c4:	4602      	mov	r2, r0
c0d040c6:	7c20      	ldrb	r0, [r4, #16]
c0d040c8:	a901      	add	r1, sp, #4
c0d040ca:	4790      	blx	r2
c0d040cc:	e034      	b.n	c0d04138 <USBD_GetDescriptor+0xce>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d040ce:	2045      	movs	r0, #69	; 0x45
c0d040d0:	0080      	lsls	r0, r0, #2
c0d040d2:	5820      	ldr	r0, [r4, r0]
c0d040d4:	2100      	movs	r1, #0
c0d040d6:	2800      	cmp	r0, #0
c0d040d8:	d02f      	beq.n	c0d0413a <USBD_GetDescriptor+0xd0>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d040da:	7c21      	ldrb	r1, [r4, #16]
c0d040dc:	2900      	cmp	r1, #0
c0d040de:	d025      	beq.n	c0d0412c <USBD_GetDescriptor+0xc2>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
        //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
      }
      else
      {
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d040e0:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d040e2:	e024      	b.n	c0d0412e <USBD_GetDescriptor+0xc4>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d040e4:	7c20      	ldrb	r0, [r4, #16]
c0d040e6:	2800      	cmp	r0, #0
c0d040e8:	d109      	bne.n	c0d040fe <USBD_GetDescriptor+0x94>
c0d040ea:	2045      	movs	r0, #69	; 0x45
c0d040ec:	0080      	lsls	r0, r0, #2
c0d040ee:	5820      	ldr	r0, [r4, r0]
c0d040f0:	2800      	cmp	r0, #0
c0d040f2:	d004      	beq.n	c0d040fe <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d040f4:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d040f6:	e01a      	b.n	c0d0412e <USBD_GetDescriptor+0xc4>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d040f8:	7c20      	ldrb	r0, [r4, #16]
c0d040fa:	2800      	cmp	r0, #0
c0d040fc:	d00f      	beq.n	c0d0411e <USBD_GetDescriptor+0xb4>
c0d040fe:	4620      	mov	r0, r4
c0d04100:	4629      	mov	r1, r5
c0d04102:	f000 f91e 	bl	c0d04342 <USBD_CtlError>
c0d04106:	e027      	b.n	c0d04158 <USBD_GetDescriptor+0xee>
c0d04108:	2803      	cmp	r0, #3
c0d0410a:	d02c      	beq.n	c0d04166 <USBD_GetDescriptor+0xfc>
c0d0410c:	2804      	cmp	r0, #4
c0d0410e:	d034      	beq.n	c0d0417a <USBD_GetDescriptor+0x110>
c0d04110:	2805      	cmp	r0, #5
c0d04112:	d1f4      	bne.n	c0d040fe <USBD_GetDescriptor+0x94>
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d04114:	2011      	movs	r0, #17
c0d04116:	0100      	lsls	r0, r0, #4
c0d04118:	5820      	ldr	r0, [r4, r0]
c0d0411a:	6980      	ldr	r0, [r0, #24]
c0d0411c:	e7d0      	b.n	c0d040c0 <USBD_GetDescriptor+0x56>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d0411e:	2045      	movs	r0, #69	; 0x45
c0d04120:	0080      	lsls	r0, r0, #2
c0d04122:	5820      	ldr	r0, [r4, r0]
c0d04124:	2800      	cmp	r0, #0
c0d04126:	d0ea      	beq.n	c0d040fe <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d04128:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d0412a:	e000      	b.n	c0d0412e <USBD_GetDescriptor+0xc4>
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
      {
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d0412c:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d0412e:	f7ff faff 	bl	c0d03730 <pic>
c0d04132:	4601      	mov	r1, r0
c0d04134:	a801      	add	r0, sp, #4
c0d04136:	4788      	blx	r1
c0d04138:	4601      	mov	r1, r0
c0d0413a:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d0413c:	8802      	ldrh	r2, [r0, #0]
c0d0413e:	2a00      	cmp	r2, #0
c0d04140:	d00a      	beq.n	c0d04158 <USBD_GetDescriptor+0xee>
c0d04142:	88e8      	ldrh	r0, [r5, #6]
c0d04144:	2800      	cmp	r0, #0
c0d04146:	d007      	beq.n	c0d04158 <USBD_GetDescriptor+0xee>
  {
    
    len = MIN(len , req->wLength);
c0d04148:	4282      	cmp	r2, r0
c0d0414a:	d300      	bcc.n	c0d0414e <USBD_GetDescriptor+0xe4>
c0d0414c:	4602      	mov	r2, r0
c0d0414e:	a801      	add	r0, sp, #4
c0d04150:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d04152:	4620      	mov	r0, r4
c0d04154:	f000 fb08 	bl	c0d04768 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d04158:	b002      	add	sp, #8
c0d0415a:	bdb0      	pop	{r4, r5, r7, pc}
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d0415c:	2011      	movs	r0, #17
c0d0415e:	0100      	lsls	r0, r0, #4
c0d04160:	5820      	ldr	r0, [r4, r0]
c0d04162:	6840      	ldr	r0, [r0, #4]
c0d04164:	e7ac      	b.n	c0d040c0 <USBD_GetDescriptor+0x56>
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d04166:	2011      	movs	r0, #17
c0d04168:	0100      	lsls	r0, r0, #4
c0d0416a:	5820      	ldr	r0, [r4, r0]
c0d0416c:	6900      	ldr	r0, [r0, #16]
c0d0416e:	e7a7      	b.n	c0d040c0 <USBD_GetDescriptor+0x56>
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d04170:	2011      	movs	r0, #17
c0d04172:	0100      	lsls	r0, r0, #4
c0d04174:	5820      	ldr	r0, [r4, r0]
c0d04176:	6880      	ldr	r0, [r0, #8]
c0d04178:	e7a2      	b.n	c0d040c0 <USBD_GetDescriptor+0x56>
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d0417a:	2011      	movs	r0, #17
c0d0417c:	0100      	lsls	r0, r0, #4
c0d0417e:	5820      	ldr	r0, [r4, r0]
c0d04180:	6940      	ldr	r0, [r0, #20]
c0d04182:	e79d      	b.n	c0d040c0 <USBD_GetDescriptor+0x56>

c0d04184 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d04184:	b570      	push	{r4, r5, r6, lr}
c0d04186:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d04188:	8888      	ldrh	r0, [r1, #4]
c0d0418a:	2800      	cmp	r0, #0
c0d0418c:	d10b      	bne.n	c0d041a6 <USBD_SetAddress+0x22>
c0d0418e:	88c8      	ldrh	r0, [r1, #6]
c0d04190:	2800      	cmp	r0, #0
c0d04192:	d108      	bne.n	c0d041a6 <USBD_SetAddress+0x22>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d04194:	8848      	ldrh	r0, [r1, #2]
c0d04196:	267f      	movs	r6, #127	; 0x7f
c0d04198:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d0419a:	20fc      	movs	r0, #252	; 0xfc
c0d0419c:	5c20      	ldrb	r0, [r4, r0]
c0d0419e:	4625      	mov	r5, r4
c0d041a0:	35fc      	adds	r5, #252	; 0xfc
c0d041a2:	2803      	cmp	r0, #3
c0d041a4:	d103      	bne.n	c0d041ae <USBD_SetAddress+0x2a>
c0d041a6:	4620      	mov	r0, r4
c0d041a8:	f000 f8cb 	bl	c0d04342 <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d041ac:	bd70      	pop	{r4, r5, r6, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d041ae:	20fe      	movs	r0, #254	; 0xfe
c0d041b0:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d041b2:	b2f1      	uxtb	r1, r6
c0d041b4:	4620      	mov	r0, r4
c0d041b6:	f7ff fd0b 	bl	c0d03bd0 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d041ba:	4620      	mov	r0, r4
c0d041bc:	f000 faff 	bl	c0d047be <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d041c0:	2002      	movs	r0, #2
c0d041c2:	2101      	movs	r1, #1
c0d041c4:	2e00      	cmp	r6, #0
c0d041c6:	d100      	bne.n	c0d041ca <USBD_SetAddress+0x46>
c0d041c8:	4608      	mov	r0, r1
c0d041ca:	7028      	strb	r0, [r5, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d041cc:	bd70      	pop	{r4, r5, r6, pc}

c0d041ce <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d041ce:	b570      	push	{r4, r5, r6, lr}
c0d041d0:	460d      	mov	r5, r1
c0d041d2:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d041d4:	78ae      	ldrb	r6, [r5, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d041d6:	2e02      	cmp	r6, #2
c0d041d8:	d21d      	bcs.n	c0d04216 <USBD_SetConfig+0x48>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d041da:	20fc      	movs	r0, #252	; 0xfc
c0d041dc:	5c21      	ldrb	r1, [r4, r0]
c0d041de:	4620      	mov	r0, r4
c0d041e0:	30fc      	adds	r0, #252	; 0xfc
c0d041e2:	2903      	cmp	r1, #3
c0d041e4:	d007      	beq.n	c0d041f6 <USBD_SetConfig+0x28>
c0d041e6:	2902      	cmp	r1, #2
c0d041e8:	d115      	bne.n	c0d04216 <USBD_SetConfig+0x48>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d041ea:	2e00      	cmp	r6, #0
c0d041ec:	d022      	beq.n	c0d04234 <USBD_SetConfig+0x66>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d041ee:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d041f0:	2103      	movs	r1, #3
c0d041f2:	7001      	strb	r1, [r0, #0]
c0d041f4:	e009      	b.n	c0d0420a <USBD_SetConfig+0x3c>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d041f6:	2e00      	cmp	r6, #0
c0d041f8:	d012      	beq.n	c0d04220 <USBD_SetConfig+0x52>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d041fa:	6860      	ldr	r0, [r4, #4]
c0d041fc:	4286      	cmp	r6, r0
c0d041fe:	d019      	beq.n	c0d04234 <USBD_SetConfig+0x66>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d04200:	b2c1      	uxtb	r1, r0
c0d04202:	4620      	mov	r0, r4
c0d04204:	f7ff fd8b 	bl	c0d03d1e <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d04208:	6066      	str	r6, [r4, #4]
c0d0420a:	4620      	mov	r0, r4
c0d0420c:	4631      	mov	r1, r6
c0d0420e:	f7ff fd69 	bl	c0d03ce4 <USBD_SetClassConfig>
c0d04212:	2802      	cmp	r0, #2
c0d04214:	d10e      	bne.n	c0d04234 <USBD_SetConfig+0x66>
c0d04216:	4620      	mov	r0, r4
c0d04218:	4629      	mov	r1, r5
c0d0421a:	f000 f892 	bl	c0d04342 <USBD_CtlError>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d0421e:	bd70      	pop	{r4, r5, r6, pc}
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d04220:	2102      	movs	r1, #2
c0d04222:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d04224:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d04226:	4620      	mov	r0, r4
c0d04228:	4631      	mov	r1, r6
c0d0422a:	f7ff fd78 	bl	c0d03d1e <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d0422e:	4620      	mov	r0, r4
c0d04230:	f000 fac5 	bl	c0d047be <USBD_CtlSendStatus>
c0d04234:	4620      	mov	r0, r4
c0d04236:	f000 fac2 	bl	c0d047be <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d0423a:	bd70      	pop	{r4, r5, r6, pc}

c0d0423c <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0423c:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d0423e:	88ca      	ldrh	r2, [r1, #6]
c0d04240:	2a01      	cmp	r2, #1
c0d04242:	d10a      	bne.n	c0d0425a <USBD_GetConfig+0x1e>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d04244:	22fc      	movs	r2, #252	; 0xfc
c0d04246:	5c82      	ldrb	r2, [r0, r2]
c0d04248:	2a03      	cmp	r2, #3
c0d0424a:	d009      	beq.n	c0d04260 <USBD_GetConfig+0x24>
c0d0424c:	2a02      	cmp	r2, #2
c0d0424e:	d104      	bne.n	c0d0425a <USBD_GetConfig+0x1e>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d04250:	2100      	movs	r1, #0
c0d04252:	6081      	str	r1, [r0, #8]
c0d04254:	4601      	mov	r1, r0
c0d04256:	3108      	adds	r1, #8
c0d04258:	e003      	b.n	c0d04262 <USBD_GetConfig+0x26>
c0d0425a:	f000 f872 	bl	c0d04342 <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d0425e:	bd80      	pop	{r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d04260:	1d01      	adds	r1, r0, #4
c0d04262:	2201      	movs	r2, #1
c0d04264:	f000 fa80 	bl	c0d04768 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d04268:	bd80      	pop	{r7, pc}

c0d0426a <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0426a:	b5b0      	push	{r4, r5, r7, lr}
c0d0426c:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d0426e:	20fc      	movs	r0, #252	; 0xfc
c0d04270:	5c20      	ldrb	r0, [r4, r0]
c0d04272:	22fe      	movs	r2, #254	; 0xfe
c0d04274:	4002      	ands	r2, r0
c0d04276:	2a02      	cmp	r2, #2
c0d04278:	d116      	bne.n	c0d042a8 <USBD_GetStatus+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0427a:	2001      	movs	r0, #1
c0d0427c:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0427e:	2041      	movs	r0, #65	; 0x41
c0d04280:	0080      	lsls	r0, r0, #2
c0d04282:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d04284:	4625      	mov	r5, r4
c0d04286:	350c      	adds	r5, #12
c0d04288:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0428a:	2900      	cmp	r1, #0
c0d0428c:	d005      	beq.n	c0d0429a <USBD_GetStatus+0x30>
c0d0428e:	4620      	mov	r0, r4
c0d04290:	f000 faa1 	bl	c0d047d6 <USBD_CtlReceiveStatus>
c0d04294:	68e1      	ldr	r1, [r4, #12]
c0d04296:	2002      	movs	r0, #2
c0d04298:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0429a:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d0429c:	2202      	movs	r2, #2
c0d0429e:	4620      	mov	r0, r4
c0d042a0:	4629      	mov	r1, r5
c0d042a2:	f000 fa61 	bl	c0d04768 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d042a6:	bdb0      	pop	{r4, r5, r7, pc}
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d042a8:	4620      	mov	r0, r4
c0d042aa:	f000 f84a 	bl	c0d04342 <USBD_CtlError>
    break;
  }
}
c0d042ae:	bdb0      	pop	{r4, r5, r7, pc}

c0d042b0 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d042b0:	b5b0      	push	{r4, r5, r7, lr}
c0d042b2:	460d      	mov	r5, r1
c0d042b4:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d042b6:	8868      	ldrh	r0, [r5, #2]
c0d042b8:	2801      	cmp	r0, #1
c0d042ba:	d117      	bne.n	c0d042ec <USBD_SetFeature+0x3c>
  {
    pdev->dev_remote_wakeup = 1;  
c0d042bc:	2041      	movs	r0, #65	; 0x41
c0d042be:	0080      	lsls	r0, r0, #2
c0d042c0:	2101      	movs	r1, #1
c0d042c2:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d042c4:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d042c6:	2802      	cmp	r0, #2
c0d042c8:	d80d      	bhi.n	c0d042e6 <USBD_SetFeature+0x36>
c0d042ca:	00c0      	lsls	r0, r0, #3
c0d042cc:	1820      	adds	r0, r4, r0
c0d042ce:	2145      	movs	r1, #69	; 0x45
c0d042d0:	0089      	lsls	r1, r1, #2
c0d042d2:	5840      	ldr	r0, [r0, r1]
{

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
  {
    pdev->dev_remote_wakeup = 1;  
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d042d4:	2800      	cmp	r0, #0
c0d042d6:	d006      	beq.n	c0d042e6 <USBD_SetFeature+0x36>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d042d8:	6880      	ldr	r0, [r0, #8]
c0d042da:	f7ff fa29 	bl	c0d03730 <pic>
c0d042de:	4602      	mov	r2, r0
c0d042e0:	4620      	mov	r0, r4
c0d042e2:	4629      	mov	r1, r5
c0d042e4:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d042e6:	4620      	mov	r0, r4
c0d042e8:	f000 fa69 	bl	c0d047be <USBD_CtlSendStatus>
  }

}
c0d042ec:	bdb0      	pop	{r4, r5, r7, pc}

c0d042ee <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d042ee:	b5b0      	push	{r4, r5, r7, lr}
c0d042f0:	460d      	mov	r5, r1
c0d042f2:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d042f4:	20fc      	movs	r0, #252	; 0xfc
c0d042f6:	5c20      	ldrb	r0, [r4, r0]
c0d042f8:	21fe      	movs	r1, #254	; 0xfe
c0d042fa:	4001      	ands	r1, r0
c0d042fc:	2902      	cmp	r1, #2
c0d042fe:	d11b      	bne.n	c0d04338 <USBD_ClrFeature+0x4a>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d04300:	8868      	ldrh	r0, [r5, #2]
c0d04302:	2801      	cmp	r0, #1
c0d04304:	d11c      	bne.n	c0d04340 <USBD_ClrFeature+0x52>
    {
      pdev->dev_remote_wakeup = 0; 
c0d04306:	2041      	movs	r0, #65	; 0x41
c0d04308:	0080      	lsls	r0, r0, #2
c0d0430a:	2100      	movs	r1, #0
c0d0430c:	5021      	str	r1, [r4, r0]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0430e:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04310:	2802      	cmp	r0, #2
c0d04312:	d80d      	bhi.n	c0d04330 <USBD_ClrFeature+0x42>
c0d04314:	00c0      	lsls	r0, r0, #3
c0d04316:	1820      	adds	r0, r4, r0
c0d04318:	2145      	movs	r1, #69	; 0x45
c0d0431a:	0089      	lsls	r1, r1, #2
c0d0431c:	5840      	ldr	r0, [r0, r1]
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
    {
      pdev->dev_remote_wakeup = 0; 
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0431e:	2800      	cmp	r0, #0
c0d04320:	d006      	beq.n	c0d04330 <USBD_ClrFeature+0x42>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d04322:	6880      	ldr	r0, [r0, #8]
c0d04324:	f7ff fa04 	bl	c0d03730 <pic>
c0d04328:	4602      	mov	r2, r0
c0d0432a:	4620      	mov	r0, r4
c0d0432c:	4629      	mov	r1, r5
c0d0432e:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d04330:	4620      	mov	r0, r4
c0d04332:	f000 fa44 	bl	c0d047be <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d04336:	bdb0      	pop	{r4, r5, r7, pc}
      USBD_CtlSendStatus(pdev);
    }
    break;
    
  default :
     USBD_CtlError(pdev , req);
c0d04338:	4620      	mov	r0, r4
c0d0433a:	4629      	mov	r1, r5
c0d0433c:	f000 f801 	bl	c0d04342 <USBD_CtlError>
    break;
  }
}
c0d04340:	bdb0      	pop	{r4, r5, r7, pc}

c0d04342 <USBD_CtlError>:
  USBD_LL_StallEP(pdev , 0);
}

__weak void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d04342:	b510      	push	{r4, lr}
c0d04344:	4604      	mov	r4, r0
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
  USBD_LL_StallEP(pdev , 0x80);
c0d04346:	2180      	movs	r1, #128	; 0x80
c0d04348:	f7ff fbe6 	bl	c0d03b18 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0434c:	2100      	movs	r1, #0
c0d0434e:	4620      	mov	r0, r4
c0d04350:	f7ff fbe2 	bl	c0d03b18 <USBD_LL_StallEP>
__weak void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_CtlStall(pdev);
}
c0d04354:	bd10      	pop	{r4, pc}

c0d04356 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d04356:	b5b0      	push	{r4, r5, r7, lr}
c0d04358:	460d      	mov	r5, r1
c0d0435a:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d0435c:	20fc      	movs	r0, #252	; 0xfc
c0d0435e:	5c20      	ldrb	r0, [r4, r0]
c0d04360:	2803      	cmp	r0, #3
c0d04362:	d117      	bne.n	c0d04394 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d04364:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04366:	2802      	cmp	r0, #2
c0d04368:	d814      	bhi.n	c0d04394 <USBD_StdItfReq+0x3e>
c0d0436a:	00c0      	lsls	r0, r0, #3
c0d0436c:	1820      	adds	r0, r4, r0
c0d0436e:	2145      	movs	r1, #69	; 0x45
c0d04370:	0089      	lsls	r1, r1, #2
c0d04372:	5840      	ldr	r0, [r0, r1]
  
  switch (pdev->dev_state) 
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d04374:	2800      	cmp	r0, #0
c0d04376:	d00d      	beq.n	c0d04394 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d04378:	6880      	ldr	r0, [r0, #8]
c0d0437a:	f7ff f9d9 	bl	c0d03730 <pic>
c0d0437e:	4602      	mov	r2, r0
c0d04380:	4620      	mov	r0, r4
c0d04382:	4629      	mov	r1, r5
c0d04384:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d04386:	88e8      	ldrh	r0, [r5, #6]
c0d04388:	2800      	cmp	r0, #0
c0d0438a:	d107      	bne.n	c0d0439c <USBD_StdItfReq+0x46>
      {
         USBD_CtlSendStatus(pdev);
c0d0438c:	4620      	mov	r0, r4
c0d0438e:	f000 fa16 	bl	c0d047be <USBD_CtlSendStatus>
c0d04392:	e003      	b.n	c0d0439c <USBD_StdItfReq+0x46>
c0d04394:	4620      	mov	r0, r4
c0d04396:	4629      	mov	r1, r5
c0d04398:	f7ff ffd3 	bl	c0d04342 <USBD_CtlError>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d0439c:	2000      	movs	r0, #0
c0d0439e:	bdb0      	pop	{r4, r5, r7, pc}

c0d043a0 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d043a0:	b570      	push	{r4, r5, r6, lr}
c0d043a2:	460d      	mov	r5, r1
c0d043a4:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d043a6:	7828      	ldrb	r0, [r5, #0]
c0d043a8:	2160      	movs	r1, #96	; 0x60
c0d043aa:	4001      	ands	r1, r0
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d043ac:	792e      	ldrb	r6, [r5, #4]
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d043ae:	2920      	cmp	r1, #32
c0d043b0:	d110      	bne.n	c0d043d4 <USBD_StdEPReq+0x34>
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d043b2:	2e02      	cmp	r6, #2
c0d043b4:	d80e      	bhi.n	c0d043d4 <USBD_StdEPReq+0x34>
c0d043b6:	00f0      	lsls	r0, r6, #3
c0d043b8:	1820      	adds	r0, r4, r0
c0d043ba:	2145      	movs	r1, #69	; 0x45
c0d043bc:	0089      	lsls	r1, r1, #2
c0d043be:	5840      	ldr	r0, [r0, r1]
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d043c0:	2800      	cmp	r0, #0
c0d043c2:	d007      	beq.n	c0d043d4 <USBD_StdEPReq+0x34>
  {
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d043c4:	6880      	ldr	r0, [r0, #8]
c0d043c6:	f7ff f9b3 	bl	c0d03730 <pic>
c0d043ca:	4602      	mov	r2, r0
c0d043cc:	4620      	mov	r0, r4
c0d043ce:	4629      	mov	r1, r5
c0d043d0:	4790      	blx	r2
c0d043d2:	e06e      	b.n	c0d044b2 <USBD_StdEPReq+0x112>
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d043d4:	7868      	ldrb	r0, [r5, #1]
c0d043d6:	2800      	cmp	r0, #0
c0d043d8:	d017      	beq.n	c0d0440a <USBD_StdEPReq+0x6a>
c0d043da:	2801      	cmp	r0, #1
c0d043dc:	d01e      	beq.n	c0d0441c <USBD_StdEPReq+0x7c>
c0d043de:	2803      	cmp	r0, #3
c0d043e0:	d167      	bne.n	c0d044b2 <USBD_StdEPReq+0x112>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d043e2:	20fc      	movs	r0, #252	; 0xfc
c0d043e4:	5c20      	ldrb	r0, [r4, r0]
c0d043e6:	2803      	cmp	r0, #3
c0d043e8:	d11c      	bne.n	c0d04424 <USBD_StdEPReq+0x84>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d043ea:	8868      	ldrh	r0, [r5, #2]
c0d043ec:	2800      	cmp	r0, #0
c0d043ee:	d108      	bne.n	c0d04402 <USBD_StdEPReq+0x62>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d043f0:	2080      	movs	r0, #128	; 0x80
c0d043f2:	4330      	orrs	r0, r6
c0d043f4:	2880      	cmp	r0, #128	; 0x80
c0d043f6:	d004      	beq.n	c0d04402 <USBD_StdEPReq+0x62>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d043f8:	4620      	mov	r0, r4
c0d043fa:	4631      	mov	r1, r6
c0d043fc:	f7ff fb8c 	bl	c0d03b18 <USBD_LL_StallEP>
          
        }
c0d04400:	792e      	ldrb	r6, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04402:	2e02      	cmp	r6, #2
c0d04404:	d852      	bhi.n	c0d044ac <USBD_StdEPReq+0x10c>
c0d04406:	00f0      	lsls	r0, r6, #3
c0d04408:	e043      	b.n	c0d04492 <USBD_StdEPReq+0xf2>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d0440a:	20fc      	movs	r0, #252	; 0xfc
c0d0440c:	5c20      	ldrb	r0, [r4, r0]
c0d0440e:	2803      	cmp	r0, #3
c0d04410:	d018      	beq.n	c0d04444 <USBD_StdEPReq+0xa4>
c0d04412:	2802      	cmp	r0, #2
c0d04414:	d111      	bne.n	c0d0443a <USBD_StdEPReq+0x9a>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d04416:	0670      	lsls	r0, r6, #25
c0d04418:	d10a      	bne.n	c0d04430 <USBD_StdEPReq+0x90>
c0d0441a:	e04a      	b.n	c0d044b2 <USBD_StdEPReq+0x112>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d0441c:	20fc      	movs	r0, #252	; 0xfc
c0d0441e:	5c20      	ldrb	r0, [r4, r0]
c0d04420:	2803      	cmp	r0, #3
c0d04422:	d029      	beq.n	c0d04478 <USBD_StdEPReq+0xd8>
c0d04424:	2802      	cmp	r0, #2
c0d04426:	d108      	bne.n	c0d0443a <USBD_StdEPReq+0x9a>
c0d04428:	2080      	movs	r0, #128	; 0x80
c0d0442a:	4330      	orrs	r0, r6
c0d0442c:	2880      	cmp	r0, #128	; 0x80
c0d0442e:	d040      	beq.n	c0d044b2 <USBD_StdEPReq+0x112>
c0d04430:	4620      	mov	r0, r4
c0d04432:	4631      	mov	r1, r6
c0d04434:	f7ff fb70 	bl	c0d03b18 <USBD_LL_StallEP>
c0d04438:	e03b      	b.n	c0d044b2 <USBD_StdEPReq+0x112>
c0d0443a:	4620      	mov	r0, r4
c0d0443c:	4629      	mov	r1, r5
c0d0443e:	f7ff ff80 	bl	c0d04342 <USBD_CtlError>
c0d04442:	e036      	b.n	c0d044b2 <USBD_StdEPReq+0x112>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d04444:	4625      	mov	r5, r4
c0d04446:	3514      	adds	r5, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d04448:	4620      	mov	r0, r4
c0d0444a:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d0444c:	2180      	movs	r1, #128	; 0x80
c0d0444e:	420e      	tst	r6, r1
c0d04450:	d100      	bne.n	c0d04454 <USBD_StdEPReq+0xb4>
c0d04452:	4605      	mov	r5, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d04454:	4620      	mov	r0, r4
c0d04456:	4631      	mov	r1, r6
c0d04458:	f7ff fba8 	bl	c0d03bac <USBD_LL_IsStallEP>
c0d0445c:	2101      	movs	r1, #1
c0d0445e:	2800      	cmp	r0, #0
c0d04460:	d100      	bne.n	c0d04464 <USBD_StdEPReq+0xc4>
c0d04462:	4601      	mov	r1, r0
c0d04464:	207f      	movs	r0, #127	; 0x7f
c0d04466:	4006      	ands	r6, r0
c0d04468:	0130      	lsls	r0, r6, #4
c0d0446a:	5029      	str	r1, [r5, r0]
c0d0446c:	1829      	adds	r1, r5, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d0446e:	2202      	movs	r2, #2
c0d04470:	4620      	mov	r0, r4
c0d04472:	f000 f979 	bl	c0d04768 <USBD_CtlSendData>
c0d04476:	e01c      	b.n	c0d044b2 <USBD_StdEPReq+0x112>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d04478:	8868      	ldrh	r0, [r5, #2]
c0d0447a:	2800      	cmp	r0, #0
c0d0447c:	d119      	bne.n	c0d044b2 <USBD_StdEPReq+0x112>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d0447e:	0670      	lsls	r0, r6, #25
c0d04480:	d014      	beq.n	c0d044ac <USBD_StdEPReq+0x10c>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d04482:	4620      	mov	r0, r4
c0d04484:	4631      	mov	r1, r6
c0d04486:	f7ff fb6d 	bl	c0d03b64 <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0448a:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0448c:	2802      	cmp	r0, #2
c0d0448e:	d80d      	bhi.n	c0d044ac <USBD_StdEPReq+0x10c>
c0d04490:	00c0      	lsls	r0, r0, #3
c0d04492:	1820      	adds	r0, r4, r0
c0d04494:	2145      	movs	r1, #69	; 0x45
c0d04496:	0089      	lsls	r1, r1, #2
c0d04498:	5840      	ldr	r0, [r0, r1]
c0d0449a:	2800      	cmp	r0, #0
c0d0449c:	d006      	beq.n	c0d044ac <USBD_StdEPReq+0x10c>
c0d0449e:	6880      	ldr	r0, [r0, #8]
c0d044a0:	f7ff f946 	bl	c0d03730 <pic>
c0d044a4:	4602      	mov	r2, r0
c0d044a6:	4620      	mov	r0, r4
c0d044a8:	4629      	mov	r1, r5
c0d044aa:	4790      	blx	r2
c0d044ac:	4620      	mov	r0, r4
c0d044ae:	f000 f986 	bl	c0d047be <USBD_CtlSendStatus>
    
  default:
    break;
  }
  return ret;
}
c0d044b2:	2000      	movs	r0, #0
c0d044b4:	bd70      	pop	{r4, r5, r6, pc}

c0d044b6 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d044b6:	780a      	ldrb	r2, [r1, #0]
c0d044b8:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d044ba:	784a      	ldrb	r2, [r1, #1]
c0d044bc:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d044be:	788a      	ldrb	r2, [r1, #2]
c0d044c0:	78cb      	ldrb	r3, [r1, #3]
c0d044c2:	021b      	lsls	r3, r3, #8
c0d044c4:	4313      	orrs	r3, r2
c0d044c6:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d044c8:	790a      	ldrb	r2, [r1, #4]
c0d044ca:	794b      	ldrb	r3, [r1, #5]
c0d044cc:	021b      	lsls	r3, r3, #8
c0d044ce:	4313      	orrs	r3, r2
c0d044d0:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d044d2:	798a      	ldrb	r2, [r1, #6]
c0d044d4:	79c9      	ldrb	r1, [r1, #7]
c0d044d6:	0209      	lsls	r1, r1, #8
c0d044d8:	4311      	orrs	r1, r2
c0d044da:	80c1      	strh	r1, [r0, #6]

}
c0d044dc:	4770      	bx	lr

c0d044de <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d044de:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d044e0:	b083      	sub	sp, #12
c0d044e2:	460d      	mov	r5, r1
c0d044e4:	4604      	mov	r4, r0
c0d044e6:	a802      	add	r0, sp, #8
c0d044e8:	2700      	movs	r7, #0
  uint16_t len = 0;
c0d044ea:	8007      	strh	r7, [r0, #0]
c0d044ec:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d044ee:	7007      	strb	r7, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d044f0:	7829      	ldrb	r1, [r5, #0]
c0d044f2:	2060      	movs	r0, #96	; 0x60
c0d044f4:	4008      	ands	r0, r1
c0d044f6:	2800      	cmp	r0, #0
c0d044f8:	d010      	beq.n	c0d0451c <USBD_HID_Setup+0x3e>
c0d044fa:	2820      	cmp	r0, #32
c0d044fc:	d138      	bne.n	c0d04570 <USBD_HID_Setup+0x92>
c0d044fe:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d04500:	4601      	mov	r1, r0
c0d04502:	390a      	subs	r1, #10
c0d04504:	2902      	cmp	r1, #2
c0d04506:	d333      	bcc.n	c0d04570 <USBD_HID_Setup+0x92>
c0d04508:	2802      	cmp	r0, #2
c0d0450a:	d01c      	beq.n	c0d04546 <USBD_HID_Setup+0x68>
c0d0450c:	2803      	cmp	r0, #3
c0d0450e:	d01a      	beq.n	c0d04546 <USBD_HID_Setup+0x68>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d04510:	4620      	mov	r0, r4
c0d04512:	4629      	mov	r1, r5
c0d04514:	f7ff ff15 	bl	c0d04342 <USBD_CtlError>
c0d04518:	2702      	movs	r7, #2
c0d0451a:	e029      	b.n	c0d04570 <USBD_HID_Setup+0x92>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d0451c:	7868      	ldrb	r0, [r5, #1]
c0d0451e:	280b      	cmp	r0, #11
c0d04520:	d014      	beq.n	c0d0454c <USBD_HID_Setup+0x6e>
c0d04522:	280a      	cmp	r0, #10
c0d04524:	d00f      	beq.n	c0d04546 <USBD_HID_Setup+0x68>
c0d04526:	2806      	cmp	r0, #6
c0d04528:	d122      	bne.n	c0d04570 <USBD_HID_Setup+0x92>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d0452a:	8868      	ldrh	r0, [r5, #2]
c0d0452c:	0a00      	lsrs	r0, r0, #8
c0d0452e:	2700      	movs	r7, #0
c0d04530:	2821      	cmp	r0, #33	; 0x21
c0d04532:	d00f      	beq.n	c0d04554 <USBD_HID_Setup+0x76>
c0d04534:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d04536:	463a      	mov	r2, r7
c0d04538:	4639      	mov	r1, r7
c0d0453a:	d116      	bne.n	c0d0456a <USBD_HID_Setup+0x8c>
c0d0453c:	ae02      	add	r6, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d0453e:	4630      	mov	r0, r6
c0d04540:	f000 f852 	bl	c0d045e8 <USBD_HID_GetReportDescriptor_impl>
c0d04544:	e00a      	b.n	c0d0455c <USBD_HID_Setup+0x7e>
c0d04546:	a901      	add	r1, sp, #4
c0d04548:	2201      	movs	r2, #1
c0d0454a:	e00e      	b.n	c0d0456a <USBD_HID_Setup+0x8c>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d0454c:	4620      	mov	r0, r4
c0d0454e:	f000 f936 	bl	c0d047be <USBD_CtlSendStatus>
c0d04552:	e00d      	b.n	c0d04570 <USBD_HID_Setup+0x92>
c0d04554:	ae02      	add	r6, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d04556:	4630      	mov	r0, r6
c0d04558:	f000 f832 	bl	c0d045c0 <USBD_HID_GetHidDescriptor_impl>
c0d0455c:	4601      	mov	r1, r0
c0d0455e:	8832      	ldrh	r2, [r6, #0]
c0d04560:	88e8      	ldrh	r0, [r5, #6]
c0d04562:	4282      	cmp	r2, r0
c0d04564:	d300      	bcc.n	c0d04568 <USBD_HID_Setup+0x8a>
c0d04566:	4602      	mov	r2, r0
c0d04568:	8032      	strh	r2, [r6, #0]
c0d0456a:	4620      	mov	r0, r4
c0d0456c:	f000 f8fc 	bl	c0d04768 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d04570:	b2f8      	uxtb	r0, r7
c0d04572:	b003      	add	sp, #12
c0d04574:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d04576 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d04576:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04578:	b081      	sub	sp, #4
c0d0457a:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d0457c:	2182      	movs	r1, #130	; 0x82
c0d0457e:	2603      	movs	r6, #3
c0d04580:	2540      	movs	r5, #64	; 0x40
c0d04582:	4632      	mov	r2, r6
c0d04584:	462b      	mov	r3, r5
c0d04586:	f7ff fa8b 	bl	c0d03aa0 <USBD_LL_OpenEP>
c0d0458a:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0458c:	4620      	mov	r0, r4
c0d0458e:	4639      	mov	r1, r7
c0d04590:	4632      	mov	r2, r6
c0d04592:	462b      	mov	r3, r5
c0d04594:	f7ff fa84 	bl	c0d03aa0 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d04598:	4620      	mov	r0, r4
c0d0459a:	4639      	mov	r1, r7
c0d0459c:	462a      	mov	r2, r5
c0d0459e:	f7ff fb42 	bl	c0d03c26 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d045a2:	2000      	movs	r0, #0
c0d045a4:	b001      	add	sp, #4
c0d045a6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d045a8 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d045a8:	b510      	push	{r4, lr}
c0d045aa:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d045ac:	2182      	movs	r1, #130	; 0x82
c0d045ae:	f7ff fa9d 	bl	c0d03aec <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d045b2:	2102      	movs	r1, #2
c0d045b4:	4620      	mov	r0, r4
c0d045b6:	f7ff fa99 	bl	c0d03aec <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d045ba:	2000      	movs	r0, #0
c0d045bc:	bd10      	pop	{r4, pc}
	...

c0d045c0 <USBD_HID_GetHidDescriptor_impl>:
{
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
c0d045c0:	4601      	mov	r1, r0
  switch (USBD_Device.request.wIndex&0xFF) {
c0d045c2:	2043      	movs	r0, #67	; 0x43
c0d045c4:	0080      	lsls	r0, r0, #2
c0d045c6:	4a06      	ldr	r2, [pc, #24]	; (c0d045e0 <USBD_HID_GetHidDescriptor_impl+0x20>)
c0d045c8:	5c12      	ldrb	r2, [r2, r0]
      *len = sizeof(USBD_HID_Desc_fido);
      return (uint8_t*)USBD_HID_Desc_fido; 
#endif // HAVE_IO_U2F
    case HID_INTF:
      *len = sizeof(USBD_HID_Desc);
      return (uint8_t*)USBD_HID_Desc; 
c0d045ca:	2309      	movs	r3, #9
c0d045cc:	2000      	movs	r0, #0
c0d045ce:	2a00      	cmp	r2, #0
c0d045d0:	d000      	beq.n	c0d045d4 <USBD_HID_GetHidDescriptor_impl+0x14>
c0d045d2:	4603      	mov	r3, r0
    case U2F_INTF:
      *len = sizeof(USBD_HID_Desc_fido);
      return (uint8_t*)USBD_HID_Desc_fido; 
#endif // HAVE_IO_U2F
    case HID_INTF:
      *len = sizeof(USBD_HID_Desc);
c0d045d4:	800b      	strh	r3, [r1, #0]
      return (uint8_t*)USBD_HID_Desc; 
c0d045d6:	2a00      	cmp	r2, #0
c0d045d8:	d101      	bne.n	c0d045de <USBD_HID_GetHidDescriptor_impl+0x1e>
c0d045da:	4802      	ldr	r0, [pc, #8]	; (c0d045e4 <USBD_HID_GetHidDescriptor_impl+0x24>)
c0d045dc:	4478      	add	r0, pc
  }
  *len = 0;
  return 0;
}
c0d045de:	4770      	bx	lr
c0d045e0:	20001bc0 	.word	0x20001bc0
c0d045e4:	0000087c 	.word	0x0000087c

c0d045e8 <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d045e8:	4601      	mov	r1, r0
  switch (USBD_Device.request.wIndex&0xFF) {
c0d045ea:	2043      	movs	r0, #67	; 0x43
c0d045ec:	0080      	lsls	r0, r0, #2
c0d045ee:	4a06      	ldr	r2, [pc, #24]	; (c0d04608 <USBD_HID_GetReportDescriptor_impl+0x20>)
c0d045f0:	5c12      	ldrb	r2, [r2, r0]
    *len = sizeof(HID_ReportDesc_fido);
    return (uint8_t*)HID_ReportDesc_fido;
#endif // HAVE_IO_U2F
  case HID_INTF:
    *len = sizeof(HID_ReportDesc);
    return (uint8_t*)HID_ReportDesc;
c0d045f2:	2322      	movs	r3, #34	; 0x22
c0d045f4:	2000      	movs	r0, #0
c0d045f6:	2a00      	cmp	r2, #0
c0d045f8:	d000      	beq.n	c0d045fc <USBD_HID_GetReportDescriptor_impl+0x14>
c0d045fa:	4603      	mov	r3, r0

    *len = sizeof(HID_ReportDesc_fido);
    return (uint8_t*)HID_ReportDesc_fido;
#endif // HAVE_IO_U2F
  case HID_INTF:
    *len = sizeof(HID_ReportDesc);
c0d045fc:	800b      	strh	r3, [r1, #0]
    return (uint8_t*)HID_ReportDesc;
c0d045fe:	2a00      	cmp	r2, #0
c0d04600:	d101      	bne.n	c0d04606 <USBD_HID_GetReportDescriptor_impl+0x1e>
c0d04602:	4802      	ldr	r0, [pc, #8]	; (c0d0460c <USBD_HID_GetReportDescriptor_impl+0x24>)
c0d04604:	4478      	add	r0, pc
  }
  *len = 0;
  return 0;
}
c0d04606:	4770      	bx	lr
c0d04608:	20001bc0 	.word	0x20001bc0
c0d0460c:	0000085d 	.word	0x0000085d

c0d04610 <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d04610:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d04612:	2902      	cmp	r1, #2
c0d04614:	d103      	bne.n	c0d0461e <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d04616:	4803      	ldr	r0, [pc, #12]	; (c0d04624 <USBD_HID_DataIn_impl+0x14>)
c0d04618:	4478      	add	r0, pc
c0d0461a:	f7fe fbd5 	bl	c0d02dc8 <io_usb_hid_sent>
      break;
  }

  return USBD_OK;
c0d0461e:	2000      	movs	r0, #0
c0d04620:	bd80      	pop	{r7, pc}
c0d04622:	46c0      	nop			; (mov r8, r8)
c0d04624:	ffffea55 	.word	0xffffea55

c0d04628 <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d04628:	b5b0      	push	{r4, r5, r7, lr}
c0d0462a:	4614      	mov	r4, r2
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d0462c:	2902      	cmp	r1, #2
c0d0462e:	d11b      	bne.n	c0d04668 <USBD_HID_DataOut_impl+0x40>

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d04630:	2102      	movs	r1, #2
c0d04632:	2240      	movs	r2, #64	; 0x40
c0d04634:	f7ff faf7 	bl	c0d03c26 <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {      
c0d04638:	4d0c      	ldr	r5, [pc, #48]	; (c0d0466c <USBD_HID_DataOut_impl+0x44>)
c0d0463a:	7828      	ldrb	r0, [r5, #0]
c0d0463c:	2800      	cmp	r0, #0
c0d0463e:	d113      	bne.n	c0d04668 <USBD_HID_DataOut_impl+0x40>
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d04640:	2002      	movs	r0, #2
c0d04642:	f7fe fcb3 	bl	c0d02fac <io_seproxyhal_get_ep_rx_size>
c0d04646:	4602      	mov	r2, r0
c0d04648:	480c      	ldr	r0, [pc, #48]	; (c0d0467c <USBD_HID_DataOut_impl+0x54>)
c0d0464a:	4478      	add	r0, pc
c0d0464c:	4621      	mov	r1, r4
c0d0464e:	f7fe fae7 	bl	c0d02c20 <io_usb_hid_receive>
c0d04652:	2802      	cmp	r0, #2
c0d04654:	d108      	bne.n	c0d04668 <USBD_HID_DataOut_impl+0x40>
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d04656:	2001      	movs	r0, #1
c0d04658:	7028      	strb	r0, [r5, #0]
          G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d0465a:	4805      	ldr	r0, [pc, #20]	; (c0d04670 <USBD_HID_DataOut_impl+0x48>)
c0d0465c:	2107      	movs	r1, #7
c0d0465e:	7001      	strb	r1, [r0, #0]
          G_io_apdu_length = G_io_usb_hid_total_length;
c0d04660:	4804      	ldr	r0, [pc, #16]	; (c0d04674 <USBD_HID_DataOut_impl+0x4c>)
c0d04662:	6800      	ldr	r0, [r0, #0]
c0d04664:	4904      	ldr	r1, [pc, #16]	; (c0d04678 <USBD_HID_DataOut_impl+0x50>)
c0d04666:	8008      	strh	r0, [r1, #0]
      }
    }
    break;
  }

  return USBD_OK;
c0d04668:	2000      	movs	r0, #0
c0d0466a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0466c:	20001b50 	.word	0x20001b50
c0d04670:	20001b66 	.word	0x20001b66
c0d04674:	20001a3c 	.word	0x20001a3c
c0d04678:	20001b68 	.word	0x20001b68
c0d0467c:	ffffea23 	.word	0xffffea23

c0d04680 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d04680:	2012      	movs	r0, #18
c0d04682:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d04684:	4801      	ldr	r0, [pc, #4]	; (c0d0468c <USBD_DeviceDescriptor+0xc>)
c0d04686:	4478      	add	r0, pc
c0d04688:	4770      	bx	lr
c0d0468a:	46c0      	nop			; (mov r8, r8)
c0d0468c:	00000856 	.word	0x00000856

c0d04690 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d04690:	2004      	movs	r0, #4
c0d04692:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d04694:	4801      	ldr	r0, [pc, #4]	; (c0d0469c <USBD_LangIDStrDescriptor+0xc>)
c0d04696:	4478      	add	r0, pc
c0d04698:	4770      	bx	lr
c0d0469a:	46c0      	nop			; (mov r8, r8)
c0d0469c:	00000858 	.word	0x00000858

c0d046a0 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d046a0:	200e      	movs	r0, #14
c0d046a2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d046a4:	4801      	ldr	r0, [pc, #4]	; (c0d046ac <USBD_ManufacturerStrDescriptor+0xc>)
c0d046a6:	4478      	add	r0, pc
c0d046a8:	4770      	bx	lr
c0d046aa:	46c0      	nop			; (mov r8, r8)
c0d046ac:	0000084c 	.word	0x0000084c

c0d046b0 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d046b0:	200e      	movs	r0, #14
c0d046b2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d046b4:	4801      	ldr	r0, [pc, #4]	; (c0d046bc <USBD_ProductStrDescriptor+0xc>)
c0d046b6:	4478      	add	r0, pc
c0d046b8:	4770      	bx	lr
c0d046ba:	46c0      	nop			; (mov r8, r8)
c0d046bc:	0000084a 	.word	0x0000084a

c0d046c0 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d046c0:	200a      	movs	r0, #10
c0d046c2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d046c4:	4801      	ldr	r0, [pc, #4]	; (c0d046cc <USBD_SerialStrDescriptor+0xc>)
c0d046c6:	4478      	add	r0, pc
c0d046c8:	4770      	bx	lr
c0d046ca:	46c0      	nop			; (mov r8, r8)
c0d046cc:	00000848 	.word	0x00000848

c0d046d0 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d046d0:	200e      	movs	r0, #14
c0d046d2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d046d4:	4801      	ldr	r0, [pc, #4]	; (c0d046dc <USBD_ConfigStrDescriptor+0xc>)
c0d046d6:	4478      	add	r0, pc
c0d046d8:	4770      	bx	lr
c0d046da:	46c0      	nop			; (mov r8, r8)
c0d046dc:	0000082a 	.word	0x0000082a

c0d046e0 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d046e0:	200e      	movs	r0, #14
c0d046e2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d046e4:	4801      	ldr	r0, [pc, #4]	; (c0d046ec <USBD_InterfaceStrDescriptor+0xc>)
c0d046e6:	4478      	add	r0, pc
c0d046e8:	4770      	bx	lr
c0d046ea:	46c0      	nop			; (mov r8, r8)
c0d046ec:	0000081a 	.word	0x0000081a

c0d046f0 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d046f0:	b570      	push	{r4, r5, r6, lr}
c0d046f2:	4604      	mov	r4, r0
c0d046f4:	204d      	movs	r0, #77	; 0x4d
c0d046f6:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d046f8:	4810      	ldr	r0, [pc, #64]	; (c0d0473c <USB_power+0x4c>)
c0d046fa:	2100      	movs	r1, #0
c0d046fc:	462a      	mov	r2, r5
c0d046fe:	f7fe fb39 	bl	c0d02d74 <os_memset>

  if (enabled) {
c0d04702:	2c00      	cmp	r4, #0
c0d04704:	d016      	beq.n	c0d04734 <USB_power+0x44>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d04706:	4c0d      	ldr	r4, [pc, #52]	; (c0d0473c <USB_power+0x4c>)
c0d04708:	2600      	movs	r6, #0
c0d0470a:	4620      	mov	r0, r4
c0d0470c:	4631      	mov	r1, r6
c0d0470e:	462a      	mov	r2, r5
c0d04710:	f7fe fb30 	bl	c0d02d74 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d04714:	490a      	ldr	r1, [pc, #40]	; (c0d04740 <USB_power+0x50>)
c0d04716:	4479      	add	r1, pc
c0d04718:	4620      	mov	r0, r4
c0d0471a:	4632      	mov	r2, r6
c0d0471c:	f7ff fa96 	bl	c0d03c4c <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d04720:	4a08      	ldr	r2, [pc, #32]	; (c0d04744 <USB_power+0x54>)
c0d04722:	447a      	add	r2, pc
c0d04724:	4630      	mov	r0, r6
c0d04726:	4621      	mov	r1, r4
c0d04728:	f7ff faca 	bl	c0d03cc0 <USBD_RegisterClassForInterface>
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
    USBD_LL_PrepareReceive(&USBD_Device, WEBUSB_EPOUT_ADDR , WEBUSB_EPOUT_SIZE);
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d0472c:	4620      	mov	r0, r4
c0d0472e:	f7ff fad4 	bl	c0d03cda <USBD_Start>
  }
  else {
    USBD_DeInit(&USBD_Device);
  }
}
c0d04732:	bd70      	pop	{r4, r5, r6, pc}

    /* Start Device Process */
    USBD_Start(&USBD_Device);
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d04734:	4801      	ldr	r0, [pc, #4]	; (c0d0473c <USB_power+0x4c>)
c0d04736:	f7ff faa4 	bl	c0d03c82 <USBD_DeInit>
  }
}
c0d0473a:	bd70      	pop	{r4, r5, r6, pc}
c0d0473c:	20001bc0 	.word	0x20001bc0
c0d04740:	0000076e 	.word	0x0000076e
c0d04744:	00000782 	.word	0x00000782

c0d04748 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d04748:	2129      	movs	r1, #41	; 0x29
c0d0474a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d0474c:	4801      	ldr	r0, [pc, #4]	; (c0d04754 <USBD_GetCfgDesc_impl+0xc>)
c0d0474e:	4478      	add	r0, pc
c0d04750:	4770      	bx	lr
c0d04752:	46c0      	nop			; (mov r8, r8)
c0d04754:	000007ca 	.word	0x000007ca

c0d04758 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d04758:	210a      	movs	r1, #10
c0d0475a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d0475c:	4801      	ldr	r0, [pc, #4]	; (c0d04764 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d0475e:	4478      	add	r0, pc
c0d04760:	4770      	bx	lr
c0d04762:	46c0      	nop			; (mov r8, r8)
c0d04764:	000007e6 	.word	0x000007e6

c0d04768 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d04768:	b5b0      	push	{r4, r5, r7, lr}
c0d0476a:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d0476c:	21f4      	movs	r1, #244	; 0xf4
c0d0476e:	2302      	movs	r3, #2
c0d04770:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d04772:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d04774:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d04776:	2113      	movs	r1, #19
c0d04778:	0109      	lsls	r1, r1, #4
c0d0477a:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d0477c:	6a01      	ldr	r1, [r0, #32]
c0d0477e:	428a      	cmp	r2, r1
c0d04780:	d300      	bcc.n	c0d04784 <USBD_CtlSendData+0x1c>
c0d04782:	460a      	mov	r2, r1
c0d04784:	b293      	uxth	r3, r2
c0d04786:	2500      	movs	r5, #0
c0d04788:	4629      	mov	r1, r5
c0d0478a:	4622      	mov	r2, r4
c0d0478c:	f7ff fa32 	bl	c0d03bf4 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d04790:	4628      	mov	r0, r5
c0d04792:	bdb0      	pop	{r4, r5, r7, pc}

c0d04794 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d04794:	b5b0      	push	{r4, r5, r7, lr}
c0d04796:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d04798:	6a01      	ldr	r1, [r0, #32]
c0d0479a:	428a      	cmp	r2, r1
c0d0479c:	d300      	bcc.n	c0d047a0 <USBD_CtlContinueSendData+0xc>
c0d0479e:	460a      	mov	r2, r1
c0d047a0:	b293      	uxth	r3, r2
c0d047a2:	2500      	movs	r5, #0
c0d047a4:	4629      	mov	r1, r5
c0d047a6:	4622      	mov	r2, r4
c0d047a8:	f7ff fa24 	bl	c0d03bf4 <USBD_LL_Transmit>
  return USBD_OK;
c0d047ac:	4628      	mov	r0, r5
c0d047ae:	bdb0      	pop	{r4, r5, r7, pc}

c0d047b0 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d047b0:	b510      	push	{r4, lr}
c0d047b2:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d047b4:	4621      	mov	r1, r4
c0d047b6:	f7ff fa36 	bl	c0d03c26 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d047ba:	4620      	mov	r0, r4
c0d047bc:	bd10      	pop	{r4, pc}

c0d047be <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d047be:	b510      	push	{r4, lr}

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d047c0:	21f4      	movs	r1, #244	; 0xf4
c0d047c2:	2204      	movs	r2, #4
c0d047c4:	5042      	str	r2, [r0, r1]
c0d047c6:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d047c8:	4621      	mov	r1, r4
c0d047ca:	4622      	mov	r2, r4
c0d047cc:	4623      	mov	r3, r4
c0d047ce:	f7ff fa11 	bl	c0d03bf4 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d047d2:	4620      	mov	r0, r4
c0d047d4:	bd10      	pop	{r4, pc}

c0d047d6 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d047d6:	b510      	push	{r4, lr}
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d047d8:	21f4      	movs	r1, #244	; 0xf4
c0d047da:	2205      	movs	r2, #5
c0d047dc:	5042      	str	r2, [r0, r1]
c0d047de:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d047e0:	4621      	mov	r1, r4
c0d047e2:	4622      	mov	r2, r4
c0d047e4:	f7ff fa1f 	bl	c0d03c26 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d047e8:	4620      	mov	r0, r4
c0d047ea:	bd10      	pop	{r4, pc}

c0d047ec <__aeabi_uidiv>:
c0d047ec:	2200      	movs	r2, #0
c0d047ee:	0843      	lsrs	r3, r0, #1
c0d047f0:	428b      	cmp	r3, r1
c0d047f2:	d374      	bcc.n	c0d048de <__aeabi_uidiv+0xf2>
c0d047f4:	0903      	lsrs	r3, r0, #4
c0d047f6:	428b      	cmp	r3, r1
c0d047f8:	d35f      	bcc.n	c0d048ba <__aeabi_uidiv+0xce>
c0d047fa:	0a03      	lsrs	r3, r0, #8
c0d047fc:	428b      	cmp	r3, r1
c0d047fe:	d344      	bcc.n	c0d0488a <__aeabi_uidiv+0x9e>
c0d04800:	0b03      	lsrs	r3, r0, #12
c0d04802:	428b      	cmp	r3, r1
c0d04804:	d328      	bcc.n	c0d04858 <__aeabi_uidiv+0x6c>
c0d04806:	0c03      	lsrs	r3, r0, #16
c0d04808:	428b      	cmp	r3, r1
c0d0480a:	d30d      	bcc.n	c0d04828 <__aeabi_uidiv+0x3c>
c0d0480c:	22ff      	movs	r2, #255	; 0xff
c0d0480e:	0209      	lsls	r1, r1, #8
c0d04810:	ba12      	rev	r2, r2
c0d04812:	0c03      	lsrs	r3, r0, #16
c0d04814:	428b      	cmp	r3, r1
c0d04816:	d302      	bcc.n	c0d0481e <__aeabi_uidiv+0x32>
c0d04818:	1212      	asrs	r2, r2, #8
c0d0481a:	0209      	lsls	r1, r1, #8
c0d0481c:	d065      	beq.n	c0d048ea <__aeabi_uidiv+0xfe>
c0d0481e:	0b03      	lsrs	r3, r0, #12
c0d04820:	428b      	cmp	r3, r1
c0d04822:	d319      	bcc.n	c0d04858 <__aeabi_uidiv+0x6c>
c0d04824:	e000      	b.n	c0d04828 <__aeabi_uidiv+0x3c>
c0d04826:	0a09      	lsrs	r1, r1, #8
c0d04828:	0bc3      	lsrs	r3, r0, #15
c0d0482a:	428b      	cmp	r3, r1
c0d0482c:	d301      	bcc.n	c0d04832 <__aeabi_uidiv+0x46>
c0d0482e:	03cb      	lsls	r3, r1, #15
c0d04830:	1ac0      	subs	r0, r0, r3
c0d04832:	4152      	adcs	r2, r2
c0d04834:	0b83      	lsrs	r3, r0, #14
c0d04836:	428b      	cmp	r3, r1
c0d04838:	d301      	bcc.n	c0d0483e <__aeabi_uidiv+0x52>
c0d0483a:	038b      	lsls	r3, r1, #14
c0d0483c:	1ac0      	subs	r0, r0, r3
c0d0483e:	4152      	adcs	r2, r2
c0d04840:	0b43      	lsrs	r3, r0, #13
c0d04842:	428b      	cmp	r3, r1
c0d04844:	d301      	bcc.n	c0d0484a <__aeabi_uidiv+0x5e>
c0d04846:	034b      	lsls	r3, r1, #13
c0d04848:	1ac0      	subs	r0, r0, r3
c0d0484a:	4152      	adcs	r2, r2
c0d0484c:	0b03      	lsrs	r3, r0, #12
c0d0484e:	428b      	cmp	r3, r1
c0d04850:	d301      	bcc.n	c0d04856 <__aeabi_uidiv+0x6a>
c0d04852:	030b      	lsls	r3, r1, #12
c0d04854:	1ac0      	subs	r0, r0, r3
c0d04856:	4152      	adcs	r2, r2
c0d04858:	0ac3      	lsrs	r3, r0, #11
c0d0485a:	428b      	cmp	r3, r1
c0d0485c:	d301      	bcc.n	c0d04862 <__aeabi_uidiv+0x76>
c0d0485e:	02cb      	lsls	r3, r1, #11
c0d04860:	1ac0      	subs	r0, r0, r3
c0d04862:	4152      	adcs	r2, r2
c0d04864:	0a83      	lsrs	r3, r0, #10
c0d04866:	428b      	cmp	r3, r1
c0d04868:	d301      	bcc.n	c0d0486e <__aeabi_uidiv+0x82>
c0d0486a:	028b      	lsls	r3, r1, #10
c0d0486c:	1ac0      	subs	r0, r0, r3
c0d0486e:	4152      	adcs	r2, r2
c0d04870:	0a43      	lsrs	r3, r0, #9
c0d04872:	428b      	cmp	r3, r1
c0d04874:	d301      	bcc.n	c0d0487a <__aeabi_uidiv+0x8e>
c0d04876:	024b      	lsls	r3, r1, #9
c0d04878:	1ac0      	subs	r0, r0, r3
c0d0487a:	4152      	adcs	r2, r2
c0d0487c:	0a03      	lsrs	r3, r0, #8
c0d0487e:	428b      	cmp	r3, r1
c0d04880:	d301      	bcc.n	c0d04886 <__aeabi_uidiv+0x9a>
c0d04882:	020b      	lsls	r3, r1, #8
c0d04884:	1ac0      	subs	r0, r0, r3
c0d04886:	4152      	adcs	r2, r2
c0d04888:	d2cd      	bcs.n	c0d04826 <__aeabi_uidiv+0x3a>
c0d0488a:	09c3      	lsrs	r3, r0, #7
c0d0488c:	428b      	cmp	r3, r1
c0d0488e:	d301      	bcc.n	c0d04894 <__aeabi_uidiv+0xa8>
c0d04890:	01cb      	lsls	r3, r1, #7
c0d04892:	1ac0      	subs	r0, r0, r3
c0d04894:	4152      	adcs	r2, r2
c0d04896:	0983      	lsrs	r3, r0, #6
c0d04898:	428b      	cmp	r3, r1
c0d0489a:	d301      	bcc.n	c0d048a0 <__aeabi_uidiv+0xb4>
c0d0489c:	018b      	lsls	r3, r1, #6
c0d0489e:	1ac0      	subs	r0, r0, r3
c0d048a0:	4152      	adcs	r2, r2
c0d048a2:	0943      	lsrs	r3, r0, #5
c0d048a4:	428b      	cmp	r3, r1
c0d048a6:	d301      	bcc.n	c0d048ac <__aeabi_uidiv+0xc0>
c0d048a8:	014b      	lsls	r3, r1, #5
c0d048aa:	1ac0      	subs	r0, r0, r3
c0d048ac:	4152      	adcs	r2, r2
c0d048ae:	0903      	lsrs	r3, r0, #4
c0d048b0:	428b      	cmp	r3, r1
c0d048b2:	d301      	bcc.n	c0d048b8 <__aeabi_uidiv+0xcc>
c0d048b4:	010b      	lsls	r3, r1, #4
c0d048b6:	1ac0      	subs	r0, r0, r3
c0d048b8:	4152      	adcs	r2, r2
c0d048ba:	08c3      	lsrs	r3, r0, #3
c0d048bc:	428b      	cmp	r3, r1
c0d048be:	d301      	bcc.n	c0d048c4 <__aeabi_uidiv+0xd8>
c0d048c0:	00cb      	lsls	r3, r1, #3
c0d048c2:	1ac0      	subs	r0, r0, r3
c0d048c4:	4152      	adcs	r2, r2
c0d048c6:	0883      	lsrs	r3, r0, #2
c0d048c8:	428b      	cmp	r3, r1
c0d048ca:	d301      	bcc.n	c0d048d0 <__aeabi_uidiv+0xe4>
c0d048cc:	008b      	lsls	r3, r1, #2
c0d048ce:	1ac0      	subs	r0, r0, r3
c0d048d0:	4152      	adcs	r2, r2
c0d048d2:	0843      	lsrs	r3, r0, #1
c0d048d4:	428b      	cmp	r3, r1
c0d048d6:	d301      	bcc.n	c0d048dc <__aeabi_uidiv+0xf0>
c0d048d8:	004b      	lsls	r3, r1, #1
c0d048da:	1ac0      	subs	r0, r0, r3
c0d048dc:	4152      	adcs	r2, r2
c0d048de:	1a41      	subs	r1, r0, r1
c0d048e0:	d200      	bcs.n	c0d048e4 <__aeabi_uidiv+0xf8>
c0d048e2:	4601      	mov	r1, r0
c0d048e4:	4152      	adcs	r2, r2
c0d048e6:	4610      	mov	r0, r2
c0d048e8:	4770      	bx	lr
c0d048ea:	e7ff      	b.n	c0d048ec <__aeabi_uidiv+0x100>
c0d048ec:	b501      	push	{r0, lr}
c0d048ee:	2000      	movs	r0, #0
c0d048f0:	f000 f806 	bl	c0d04900 <__aeabi_idiv0>
c0d048f4:	bd02      	pop	{r1, pc}
c0d048f6:	46c0      	nop			; (mov r8, r8)

c0d048f8 <__aeabi_uidivmod>:
c0d048f8:	2900      	cmp	r1, #0
c0d048fa:	d0f7      	beq.n	c0d048ec <__aeabi_uidiv+0x100>
c0d048fc:	e776      	b.n	c0d047ec <__aeabi_uidiv>
c0d048fe:	4770      	bx	lr

c0d04900 <__aeabi_idiv0>:
c0d04900:	4770      	bx	lr
c0d04902:	46c0      	nop			; (mov r8, r8)

c0d04904 <__aeabi_lmul>:
c0d04904:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04906:	464f      	mov	r7, r9
c0d04908:	4646      	mov	r6, r8
c0d0490a:	b4c0      	push	{r6, r7}
c0d0490c:	0416      	lsls	r6, r2, #16
c0d0490e:	0c36      	lsrs	r6, r6, #16
c0d04910:	4699      	mov	r9, r3
c0d04912:	0033      	movs	r3, r6
c0d04914:	0405      	lsls	r5, r0, #16
c0d04916:	0c2c      	lsrs	r4, r5, #16
c0d04918:	0c07      	lsrs	r7, r0, #16
c0d0491a:	0c15      	lsrs	r5, r2, #16
c0d0491c:	4363      	muls	r3, r4
c0d0491e:	437e      	muls	r6, r7
c0d04920:	436f      	muls	r7, r5
c0d04922:	4365      	muls	r5, r4
c0d04924:	0c1c      	lsrs	r4, r3, #16
c0d04926:	19ad      	adds	r5, r5, r6
c0d04928:	1964      	adds	r4, r4, r5
c0d0492a:	469c      	mov	ip, r3
c0d0492c:	42a6      	cmp	r6, r4
c0d0492e:	d903      	bls.n	c0d04938 <__aeabi_lmul+0x34>
c0d04930:	2380      	movs	r3, #128	; 0x80
c0d04932:	025b      	lsls	r3, r3, #9
c0d04934:	4698      	mov	r8, r3
c0d04936:	4447      	add	r7, r8
c0d04938:	4663      	mov	r3, ip
c0d0493a:	0c25      	lsrs	r5, r4, #16
c0d0493c:	19ef      	adds	r7, r5, r7
c0d0493e:	041d      	lsls	r5, r3, #16
c0d04940:	464b      	mov	r3, r9
c0d04942:	434a      	muls	r2, r1
c0d04944:	4343      	muls	r3, r0
c0d04946:	0c2d      	lsrs	r5, r5, #16
c0d04948:	0424      	lsls	r4, r4, #16
c0d0494a:	1964      	adds	r4, r4, r5
c0d0494c:	1899      	adds	r1, r3, r2
c0d0494e:	19c9      	adds	r1, r1, r7
c0d04950:	0020      	movs	r0, r4
c0d04952:	bc0c      	pop	{r2, r3}
c0d04954:	4690      	mov	r8, r2
c0d04956:	4699      	mov	r9, r3
c0d04958:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0495a:	46c0      	nop			; (mov r8, r8)

c0d0495c <__aeabi_memclr>:
c0d0495c:	b510      	push	{r4, lr}
c0d0495e:	2200      	movs	r2, #0
c0d04960:	f000 f806 	bl	c0d04970 <__aeabi_memset>
c0d04964:	bd10      	pop	{r4, pc}
c0d04966:	46c0      	nop			; (mov r8, r8)

c0d04968 <__aeabi_memcpy>:
c0d04968:	b510      	push	{r4, lr}
c0d0496a:	f000 f809 	bl	c0d04980 <memcpy>
c0d0496e:	bd10      	pop	{r4, pc}

c0d04970 <__aeabi_memset>:
c0d04970:	0013      	movs	r3, r2
c0d04972:	b510      	push	{r4, lr}
c0d04974:	000a      	movs	r2, r1
c0d04976:	0019      	movs	r1, r3
c0d04978:	f000 f840 	bl	c0d049fc <memset>
c0d0497c:	bd10      	pop	{r4, pc}
c0d0497e:	46c0      	nop			; (mov r8, r8)

c0d04980 <memcpy>:
c0d04980:	b570      	push	{r4, r5, r6, lr}
c0d04982:	2a0f      	cmp	r2, #15
c0d04984:	d932      	bls.n	c0d049ec <memcpy+0x6c>
c0d04986:	000c      	movs	r4, r1
c0d04988:	4304      	orrs	r4, r0
c0d0498a:	000b      	movs	r3, r1
c0d0498c:	07a4      	lsls	r4, r4, #30
c0d0498e:	d131      	bne.n	c0d049f4 <memcpy+0x74>
c0d04990:	0015      	movs	r5, r2
c0d04992:	0004      	movs	r4, r0
c0d04994:	3d10      	subs	r5, #16
c0d04996:	092d      	lsrs	r5, r5, #4
c0d04998:	3501      	adds	r5, #1
c0d0499a:	012d      	lsls	r5, r5, #4
c0d0499c:	1949      	adds	r1, r1, r5
c0d0499e:	681e      	ldr	r6, [r3, #0]
c0d049a0:	6026      	str	r6, [r4, #0]
c0d049a2:	685e      	ldr	r6, [r3, #4]
c0d049a4:	6066      	str	r6, [r4, #4]
c0d049a6:	689e      	ldr	r6, [r3, #8]
c0d049a8:	60a6      	str	r6, [r4, #8]
c0d049aa:	68de      	ldr	r6, [r3, #12]
c0d049ac:	3310      	adds	r3, #16
c0d049ae:	60e6      	str	r6, [r4, #12]
c0d049b0:	3410      	adds	r4, #16
c0d049b2:	4299      	cmp	r1, r3
c0d049b4:	d1f3      	bne.n	c0d0499e <memcpy+0x1e>
c0d049b6:	230f      	movs	r3, #15
c0d049b8:	1945      	adds	r5, r0, r5
c0d049ba:	4013      	ands	r3, r2
c0d049bc:	2b03      	cmp	r3, #3
c0d049be:	d91b      	bls.n	c0d049f8 <memcpy+0x78>
c0d049c0:	1f1c      	subs	r4, r3, #4
c0d049c2:	2300      	movs	r3, #0
c0d049c4:	08a4      	lsrs	r4, r4, #2
c0d049c6:	3401      	adds	r4, #1
c0d049c8:	00a4      	lsls	r4, r4, #2
c0d049ca:	58ce      	ldr	r6, [r1, r3]
c0d049cc:	50ee      	str	r6, [r5, r3]
c0d049ce:	3304      	adds	r3, #4
c0d049d0:	429c      	cmp	r4, r3
c0d049d2:	d1fa      	bne.n	c0d049ca <memcpy+0x4a>
c0d049d4:	2303      	movs	r3, #3
c0d049d6:	192d      	adds	r5, r5, r4
c0d049d8:	1909      	adds	r1, r1, r4
c0d049da:	401a      	ands	r2, r3
c0d049dc:	d005      	beq.n	c0d049ea <memcpy+0x6a>
c0d049de:	2300      	movs	r3, #0
c0d049e0:	5ccc      	ldrb	r4, [r1, r3]
c0d049e2:	54ec      	strb	r4, [r5, r3]
c0d049e4:	3301      	adds	r3, #1
c0d049e6:	429a      	cmp	r2, r3
c0d049e8:	d1fa      	bne.n	c0d049e0 <memcpy+0x60>
c0d049ea:	bd70      	pop	{r4, r5, r6, pc}
c0d049ec:	0005      	movs	r5, r0
c0d049ee:	2a00      	cmp	r2, #0
c0d049f0:	d1f5      	bne.n	c0d049de <memcpy+0x5e>
c0d049f2:	e7fa      	b.n	c0d049ea <memcpy+0x6a>
c0d049f4:	0005      	movs	r5, r0
c0d049f6:	e7f2      	b.n	c0d049de <memcpy+0x5e>
c0d049f8:	001a      	movs	r2, r3
c0d049fa:	e7f8      	b.n	c0d049ee <memcpy+0x6e>

c0d049fc <memset>:
c0d049fc:	b570      	push	{r4, r5, r6, lr}
c0d049fe:	0783      	lsls	r3, r0, #30
c0d04a00:	d03f      	beq.n	c0d04a82 <memset+0x86>
c0d04a02:	1e54      	subs	r4, r2, #1
c0d04a04:	2a00      	cmp	r2, #0
c0d04a06:	d03b      	beq.n	c0d04a80 <memset+0x84>
c0d04a08:	b2ce      	uxtb	r6, r1
c0d04a0a:	0003      	movs	r3, r0
c0d04a0c:	2503      	movs	r5, #3
c0d04a0e:	e003      	b.n	c0d04a18 <memset+0x1c>
c0d04a10:	1e62      	subs	r2, r4, #1
c0d04a12:	2c00      	cmp	r4, #0
c0d04a14:	d034      	beq.n	c0d04a80 <memset+0x84>
c0d04a16:	0014      	movs	r4, r2
c0d04a18:	3301      	adds	r3, #1
c0d04a1a:	1e5a      	subs	r2, r3, #1
c0d04a1c:	7016      	strb	r6, [r2, #0]
c0d04a1e:	422b      	tst	r3, r5
c0d04a20:	d1f6      	bne.n	c0d04a10 <memset+0x14>
c0d04a22:	2c03      	cmp	r4, #3
c0d04a24:	d924      	bls.n	c0d04a70 <memset+0x74>
c0d04a26:	25ff      	movs	r5, #255	; 0xff
c0d04a28:	400d      	ands	r5, r1
c0d04a2a:	022a      	lsls	r2, r5, #8
c0d04a2c:	4315      	orrs	r5, r2
c0d04a2e:	042a      	lsls	r2, r5, #16
c0d04a30:	4315      	orrs	r5, r2
c0d04a32:	2c0f      	cmp	r4, #15
c0d04a34:	d911      	bls.n	c0d04a5a <memset+0x5e>
c0d04a36:	0026      	movs	r6, r4
c0d04a38:	3e10      	subs	r6, #16
c0d04a3a:	0936      	lsrs	r6, r6, #4
c0d04a3c:	3601      	adds	r6, #1
c0d04a3e:	0136      	lsls	r6, r6, #4
c0d04a40:	001a      	movs	r2, r3
c0d04a42:	199b      	adds	r3, r3, r6
c0d04a44:	6015      	str	r5, [r2, #0]
c0d04a46:	6055      	str	r5, [r2, #4]
c0d04a48:	6095      	str	r5, [r2, #8]
c0d04a4a:	60d5      	str	r5, [r2, #12]
c0d04a4c:	3210      	adds	r2, #16
c0d04a4e:	4293      	cmp	r3, r2
c0d04a50:	d1f8      	bne.n	c0d04a44 <memset+0x48>
c0d04a52:	220f      	movs	r2, #15
c0d04a54:	4014      	ands	r4, r2
c0d04a56:	2c03      	cmp	r4, #3
c0d04a58:	d90a      	bls.n	c0d04a70 <memset+0x74>
c0d04a5a:	1f26      	subs	r6, r4, #4
c0d04a5c:	08b6      	lsrs	r6, r6, #2
c0d04a5e:	3601      	adds	r6, #1
c0d04a60:	00b6      	lsls	r6, r6, #2
c0d04a62:	001a      	movs	r2, r3
c0d04a64:	199b      	adds	r3, r3, r6
c0d04a66:	c220      	stmia	r2!, {r5}
c0d04a68:	4293      	cmp	r3, r2
c0d04a6a:	d1fc      	bne.n	c0d04a66 <memset+0x6a>
c0d04a6c:	2203      	movs	r2, #3
c0d04a6e:	4014      	ands	r4, r2
c0d04a70:	2c00      	cmp	r4, #0
c0d04a72:	d005      	beq.n	c0d04a80 <memset+0x84>
c0d04a74:	b2c9      	uxtb	r1, r1
c0d04a76:	191c      	adds	r4, r3, r4
c0d04a78:	7019      	strb	r1, [r3, #0]
c0d04a7a:	3301      	adds	r3, #1
c0d04a7c:	429c      	cmp	r4, r3
c0d04a7e:	d1fb      	bne.n	c0d04a78 <memset+0x7c>
c0d04a80:	bd70      	pop	{r4, r5, r6, pc}
c0d04a82:	0014      	movs	r4, r2
c0d04a84:	0003      	movs	r3, r0
c0d04a86:	e7cc      	b.n	c0d04a22 <memset+0x26>

c0d04a88 <setjmp>:
c0d04a88:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d04a8a:	4641      	mov	r1, r8
c0d04a8c:	464a      	mov	r2, r9
c0d04a8e:	4653      	mov	r3, sl
c0d04a90:	465c      	mov	r4, fp
c0d04a92:	466d      	mov	r5, sp
c0d04a94:	4676      	mov	r6, lr
c0d04a96:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d04a98:	3828      	subs	r0, #40	; 0x28
c0d04a9a:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d04a9c:	2000      	movs	r0, #0
c0d04a9e:	4770      	bx	lr

c0d04aa0 <longjmp>:
c0d04aa0:	3010      	adds	r0, #16
c0d04aa2:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d04aa4:	4690      	mov	r8, r2
c0d04aa6:	4699      	mov	r9, r3
c0d04aa8:	46a2      	mov	sl, r4
c0d04aaa:	46ab      	mov	fp, r5
c0d04aac:	46b5      	mov	sp, r6
c0d04aae:	c808      	ldmia	r0!, {r3}
c0d04ab0:	3828      	subs	r0, #40	; 0x28
c0d04ab2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d04ab4:	1c08      	adds	r0, r1, #0
c0d04ab6:	d100      	bne.n	c0d04aba <longjmp+0x1a>
c0d04ab8:	2001      	movs	r0, #1
c0d04aba:	4718      	bx	r3

c0d04abc <strlen>:
c0d04abc:	b510      	push	{r4, lr}
c0d04abe:	0783      	lsls	r3, r0, #30
c0d04ac0:	d027      	beq.n	c0d04b12 <strlen+0x56>
c0d04ac2:	7803      	ldrb	r3, [r0, #0]
c0d04ac4:	2b00      	cmp	r3, #0
c0d04ac6:	d026      	beq.n	c0d04b16 <strlen+0x5a>
c0d04ac8:	0003      	movs	r3, r0
c0d04aca:	2103      	movs	r1, #3
c0d04acc:	e002      	b.n	c0d04ad4 <strlen+0x18>
c0d04ace:	781a      	ldrb	r2, [r3, #0]
c0d04ad0:	2a00      	cmp	r2, #0
c0d04ad2:	d01c      	beq.n	c0d04b0e <strlen+0x52>
c0d04ad4:	3301      	adds	r3, #1
c0d04ad6:	420b      	tst	r3, r1
c0d04ad8:	d1f9      	bne.n	c0d04ace <strlen+0x12>
c0d04ada:	6819      	ldr	r1, [r3, #0]
c0d04adc:	4a0f      	ldr	r2, [pc, #60]	; (c0d04b1c <strlen+0x60>)
c0d04ade:	4c10      	ldr	r4, [pc, #64]	; (c0d04b20 <strlen+0x64>)
c0d04ae0:	188a      	adds	r2, r1, r2
c0d04ae2:	438a      	bics	r2, r1
c0d04ae4:	4222      	tst	r2, r4
c0d04ae6:	d10f      	bne.n	c0d04b08 <strlen+0x4c>
c0d04ae8:	3304      	adds	r3, #4
c0d04aea:	6819      	ldr	r1, [r3, #0]
c0d04aec:	4a0b      	ldr	r2, [pc, #44]	; (c0d04b1c <strlen+0x60>)
c0d04aee:	188a      	adds	r2, r1, r2
c0d04af0:	438a      	bics	r2, r1
c0d04af2:	4222      	tst	r2, r4
c0d04af4:	d108      	bne.n	c0d04b08 <strlen+0x4c>
c0d04af6:	3304      	adds	r3, #4
c0d04af8:	6819      	ldr	r1, [r3, #0]
c0d04afa:	4a08      	ldr	r2, [pc, #32]	; (c0d04b1c <strlen+0x60>)
c0d04afc:	188a      	adds	r2, r1, r2
c0d04afe:	438a      	bics	r2, r1
c0d04b00:	4222      	tst	r2, r4
c0d04b02:	d0f1      	beq.n	c0d04ae8 <strlen+0x2c>
c0d04b04:	e000      	b.n	c0d04b08 <strlen+0x4c>
c0d04b06:	3301      	adds	r3, #1
c0d04b08:	781a      	ldrb	r2, [r3, #0]
c0d04b0a:	2a00      	cmp	r2, #0
c0d04b0c:	d1fb      	bne.n	c0d04b06 <strlen+0x4a>
c0d04b0e:	1a18      	subs	r0, r3, r0
c0d04b10:	bd10      	pop	{r4, pc}
c0d04b12:	0003      	movs	r3, r0
c0d04b14:	e7e1      	b.n	c0d04ada <strlen+0x1e>
c0d04b16:	2000      	movs	r0, #0
c0d04b18:	e7fa      	b.n	c0d04b10 <strlen+0x54>
c0d04b1a:	46c0      	nop			; (mov r8, r8)
c0d04b1c:	fefefeff 	.word	0xfefefeff
c0d04b20:	80808080 	.word	0x80808080

c0d04b24 <order25519>:
c0d04b24:	5cf5d3ed 5812631a a2f79cd6 14def9de     ...\.c.X........
	...
c0d04b40:	10000000                                ....

c0d04b44 <base_r2y>:
c0d04b44:	00001670 007c8650 00491a6d 00d24229     p...P.|.m.I.)B..
c0d04b54:	0221359e 00bf5d19 02ed3a0b 01ca7caf     .5!..]...:...|..
c0d04b64:	02637055 005f00d4                       Upc..._.

c0d04b6c <order_times_8>:
c0d04b6c:	e7ae9f68 c09318d2 17bce6b2 a6f7cef5     h...............
	...
c0d04b88:	80000000                                ....

c0d04b8c <bagl_ui_approval_nanos>:
c0d04b8c:	00000003 00800000 00000020 00000001     ........ .......
c0d04b9c:	00000000 00ffffff 00000000 00000000     ................
	...
c0d04bc4:	00000207 0080000c 0000000b 00000000     ................
c0d04bd4:	00ffffff 00000000 0000800a c0d04c6c     ............lL..
	...
c0d04bfc:	00030005 0007000c 00000007 00000000     ................
c0d04c0c:	00ffffff 00000000 00070000 00000000     ................
	...
c0d04c34:	00750005 0008000d 00000006 00000000     ..u.............
c0d04c44:	00ffffff 00000000 00060000 00000000     ................
	...
c0d04c6c:	6e676953 73656d20 65676173 69615700     Sign message.Wai
c0d04c7c:	676e6974 726f6620 73656d20 65676173     ting for message
c0d04c8c:	72655600 20796669 74786574 00000000     .Verify text....

c0d04c9c <bagl_ui_idle_nanos>:
c0d04c9c:	00000003 00800000 00000020 00000001     ........ .......
c0d04cac:	00000000 00ffffff 00000000 00000000     ................
	...
c0d04cd4:	00000207 0080000c 0000000b 00000000     ................
c0d04ce4:	00ffffff 00000000 0000800a c0d04c79     ............yL..
	...
c0d04d0c:	00030005 0007000c 00000007 00000000     ................
c0d04d1c:	00ffffff 00000000 00070000 00000000     ................
	...

c0d04d44 <bagl_ui_text_review_nanos>:
c0d04d44:	00000003 00800000 00000020 00000001     ........ .......
c0d04d54:	00000000 00ffffff 00000000 00000000     ................
	...
c0d04d7c:	00000207 0080000c 0000000b 00000000     ................
c0d04d8c:	00ffffff 00000000 0000800a c0d04c8d     .............L..
	...
c0d04db4:	00170207 0052001a 008a000b 00000000     ......R.........
c0d04dc4:	00ffffff 00000000 001a8008 20001999     ............... 
	...
c0d04dec:	00030005 0007000c 00000007 00000000     ................
c0d04dfc:	00ffffff 00000000 00070000 00000000     ................
	...
c0d04e24:	00750005 0008000d 00000006 00000000     ..u.............
c0d04e34:	00ffffff 00000000 00060000 00000000     ................
	...

c0d04e5c <USBD_HID_Desc>:
c0d04e5c:	01112109 22220100 ffa00600                       .!...."".

c0d04e65 <HID_ReportDesc>:
c0d04e65:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d04e75:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d04e85:	8100c008                                         ...

c0d04e88 <HID_Desc>:
c0d04e88:	c0d04681 c0d04691 c0d046a1 c0d046b1     .F...F...F...F..
c0d04e98:	c0d046c1 c0d046d1 c0d046e1 00000000     .F...F...F......

c0d04ea8 <USBD_HID>:
c0d04ea8:	c0d04577 c0d045a9 c0d044df 00000000     wE...E...D......
c0d04eb8:	00000000 c0d04611 c0d04629 00000000     .....F..)F......
	...
c0d04ed0:	c0d04749 c0d04749 c0d04749 c0d04759     IG..IG..IG..YG..

c0d04ee0 <USBD_DeviceDesc>:
c0d04ee0:	02000112 40000000 00012c97 02010200     .......@.,......
c0d04ef0:	03040103                                         ..

c0d04ef2 <USBD_LangIDDesc>:
c0d04ef2:	04090304                                ....

c0d04ef6 <USBD_MANUFACTURER_STRING>:
c0d04ef6:	004c030e 00640065 00650067 030e0072              ..L.e.d.g.e.r.

c0d04f04 <USBD_PRODUCT_FS_STRING>:
c0d04f04:	004e030e 006e0061 0020006f 030a0053              ..N.a.n.o. .S.

c0d04f12 <USB_SERIAL_STRING>:
c0d04f12:	0030030a 00300030 02090031                       ..0.0.0.1.

c0d04f1c <USBD_CfgDesc>:
c0d04f1c:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d04f2c:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d04f3c:	05070100 00400302 00000001              ......@.....

c0d04f48 <USBD_DeviceQualifierDesc>:
c0d04f48:	0200060a 40000000 00000001              .......@....

c0d04f54 <_etext>:
	...

c0d04f80 <_nvram_data>:
c0d04f80:	00000000 	.word	0x00000000

c0d04f84 <N_privateKey>:
	...
