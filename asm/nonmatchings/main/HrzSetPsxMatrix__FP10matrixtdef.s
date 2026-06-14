.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching HrzSetPsxMatrix__FP10matrixtdef, 0xE0

glabel HrzSetPsxMatrix__FP10matrixtdef
    /* C103C 800D083C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C1040 800D0840 0000898C */  lw         $t1, 0x0($a0)
    /* C1044 800D0844 0400888C */  lw         $t0, 0x4($a0)
    /* C1048 800D0848 08008A8C */  lw         $t2, 0x8($a0)
    /* C104C 800D084C 23280800 */  negu       $a1, $t0
    /* C1050 800D0850 2400A5AF */  sw         $a1, 0x24($sp)
    /* C1054 800D0854 03290500 */  sra        $a1, $a1, 4
    /* C1058 800D0858 2000A9AF */  sw         $t1, 0x20($sp)
    /* C105C 800D085C 2800AAAF */  sw         $t2, 0x28($sp)
    /* C1060 800D0860 0C00898C */  lw         $t1, 0xC($a0)
    /* C1064 800D0864 1000888C */  lw         $t0, 0x10($a0)
    /* C1068 800D0868 14008A8C */  lw         $t2, 0x14($a0)
    /* C106C 800D086C 2000A38F */  lw         $v1, 0x20($sp)
    /* C1070 800D0870 2800A68F */  lw         $a2, 0x28($sp)
    /* C1074 800D0874 03190300 */  sra        $v1, $v1, 4
    /* C1078 800D0878 23100800 */  negu       $v0, $t0
    /* C107C 800D087C 03310600 */  sra        $a2, $a2, 4
    /* C1080 800D0880 2C00A9AF */  sw         $t1, 0x2C($sp)
    /* C1084 800D0884 3000A2AF */  sw         $v0, 0x30($sp)
    /* C1088 800D0888 3400AAAF */  sw         $t2, 0x34($sp)
    /* C108C 800D088C 1800898C */  lw         $t1, 0x18($a0)
    /* C1090 800D0890 1C00888C */  lw         $t0, 0x1C($a0)
    /* C1094 800D0894 20008A8C */  lw         $t2, 0x20($a0)
    /* C1098 800D0898 2C00A48F */  lw         $a0, 0x2C($sp)
    /* C109C 800D089C 3400A78F */  lw         $a3, 0x34($sp)
    /* C10A0 800D08A0 03110200 */  sra        $v0, $v0, 4
    /* C10A4 800D08A4 0000A3A7 */  sh         $v1, 0x0($sp)
    /* C10A8 800D08A8 0600A5A7 */  sh         $a1, 0x6($sp)
    /* C10AC 800D08AC 0800A2A7 */  sh         $v0, 0x8($sp)
    /* C10B0 800D08B0 0C00A6A7 */  sh         $a2, 0xC($sp)
    /* C10B4 800D08B4 03210400 */  sra        $a0, $a0, 4
    /* C10B8 800D08B8 03390700 */  sra        $a3, $a3, 4
    /* C10BC 800D08BC 23180800 */  negu       $v1, $t0
    /* C10C0 800D08C0 03110900 */  sra        $v0, $t1, 4
    /* C10C4 800D08C4 3C00A3AF */  sw         $v1, 0x3C($sp)
    /* C10C8 800D08C8 03190300 */  sra        $v1, $v1, 4
    /* C10CC 800D08CC 0400A2A7 */  sh         $v0, 0x4($sp)
    /* C10D0 800D08D0 03110A00 */  sra        $v0, $t2, 4
    /* C10D4 800D08D4 3800A9AF */  sw         $t1, 0x38($sp)
    /* C10D8 800D08D8 4000AAAF */  sw         $t2, 0x40($sp)
    /* C10DC 800D08DC 0200A4A7 */  sh         $a0, 0x2($sp)
    /* C10E0 800D08E0 0A00A3A7 */  sh         $v1, 0xA($sp)
    /* C10E4 800D08E4 0E00A7A7 */  sh         $a3, 0xE($sp)
    /* C10E8 800D08E8 1000A2A7 */  sh         $v0, 0x10($sp)
    /* C10EC 800D08EC 0000AC8F */  lw         $t4, 0x0($sp)
    /* C10F0 800D08F0 0400AD8F */  lw         $t5, 0x4($sp)
    /* C10F4 800D08F4 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* C10F8 800D08F8 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* C10FC 800D08FC 0800AC8F */  lw         $t4, 0x8($sp)
    /* C1100 800D0900 0C00AD8F */  lw         $t5, 0xC($sp)
    /* C1104 800D0904 1000AE8F */  lw         $t6, 0x10($sp)
    /* C1108 800D0908 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* C110C 800D090C 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* C1110 800D0910 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* C1114 800D0914 0800E003 */  jr         $ra
    /* C1118 800D0918 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel HrzSetPsxMatrix__FP10matrixtdef
