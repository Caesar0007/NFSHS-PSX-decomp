.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_SetMatrix__FP10matrixtdef, 0xAC

glabel Flare_SetMatrix__FP10matrixtdef
    /* BC54C 800CBD4C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BC550 800CBD50 0000828C */  lw         $v0, 0x0($a0)
    /* BC554 800CBD54 0C00838C */  lw         $v1, 0xC($a0)
    /* BC558 800CBD58 1800858C */  lw         $a1, 0x18($a0)
    /* BC55C 800CBD5C 03110200 */  sra        $v0, $v0, 4
    /* BC560 800CBD60 03190300 */  sra        $v1, $v1, 4
    /* BC564 800CBD64 03290500 */  sra        $a1, $a1, 4
    /* BC568 800CBD68 0000A2A7 */  sh         $v0, 0x0($sp)
    /* BC56C 800CBD6C 0200A3A7 */  sh         $v1, 0x2($sp)
    /* BC570 800CBD70 0400A5A7 */  sh         $a1, 0x4($sp)
    /* BC574 800CBD74 0400828C */  lw         $v0, 0x4($a0)
    /* BC578 800CBD78 1000838C */  lw         $v1, 0x10($a0)
    /* BC57C 800CBD7C 1C00858C */  lw         $a1, 0x1C($a0)
    /* BC580 800CBD80 03110200 */  sra        $v0, $v0, 4
    /* BC584 800CBD84 03190300 */  sra        $v1, $v1, 4
    /* BC588 800CBD88 03290500 */  sra        $a1, $a1, 4
    /* BC58C 800CBD8C 0600A2A7 */  sh         $v0, 0x6($sp)
    /* BC590 800CBD90 0800A3A7 */  sh         $v1, 0x8($sp)
    /* BC594 800CBD94 0A00A5A7 */  sh         $a1, 0xA($sp)
    /* BC598 800CBD98 0800828C */  lw         $v0, 0x8($a0)
    /* BC59C 800CBD9C 1400838C */  lw         $v1, 0x14($a0)
    /* BC5A0 800CBDA0 2000848C */  lw         $a0, 0x20($a0)
    /* BC5A4 800CBDA4 03110200 */  sra        $v0, $v0, 4
    /* BC5A8 800CBDA8 03190300 */  sra        $v1, $v1, 4
    /* BC5AC 800CBDAC 03210400 */  sra        $a0, $a0, 4
    /* BC5B0 800CBDB0 0C00A2A7 */  sh         $v0, 0xC($sp)
    /* BC5B4 800CBDB4 0E00A3A7 */  sh         $v1, 0xE($sp)
    /* BC5B8 800CBDB8 1000A4A7 */  sh         $a0, 0x10($sp)
    /* BC5BC 800CBDBC 0000AC8F */  lw         $t4, 0x0($sp)
    /* BC5C0 800CBDC0 0400AD8F */  lw         $t5, 0x4($sp)
    /* BC5C4 800CBDC4 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BC5C8 800CBDC8 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BC5CC 800CBDCC 0800AC8F */  lw         $t4, 0x8($sp)
    /* BC5D0 800CBDD0 0C00AD8F */  lw         $t5, 0xC($sp)
    /* BC5D4 800CBDD4 1000AE8F */  lw         $t6, 0x10($sp)
    /* BC5D8 800CBDD8 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BC5DC 800CBDDC 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BC5E0 800CBDE0 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BC5E4 800CBDE4 0028C048 */  ctc2       $zero, $5 /* handwritten instruction */
    /* BC5E8 800CBDE8 0030C048 */  ctc2       $zero, $6 /* handwritten instruction */
    /* BC5EC 800CBDEC 0038C048 */  ctc2       $zero, $7 /* handwritten instruction */
    /* BC5F0 800CBDF0 0800E003 */  jr         $ra
    /* BC5F4 800CBDF4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Flare_SetMatrix__FP10matrixtdef
