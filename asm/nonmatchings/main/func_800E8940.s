.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800E8940, 0x7C

glabel func_800E8940
    /* D9140 800E8940 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D9144 800E8944 1800B2AF */  sw         $s2, 0x18($sp)
    /* D9148 800E8948 21908000 */  addu       $s2, $a0, $zero
    /* D914C 800E894C 1000B0AF */  sw         $s0, 0x10($sp)
    /* D9150 800E8950 2180A000 */  addu       $s0, $a1, $zero
    /* D9154 800E8954 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D9158 800E8958 1400B1AF */  sw         $s1, 0x14($sp)
    /* D915C 800E895C 00000292 */  lbu        $v0, 0x0($s0)
    /* D9160 800E8960 00000000 */  nop
    /* D9164 800E8964 0E004010 */  beqz       $v0, .L800E89A0
    /* D9168 800E8968 21880000 */   addu      $s1, $zero, $zero
  .L800E896C:
    /* D916C 800E896C 00000592 */  lbu        $a1, 0x0($s0)
    /* D9170 800E8970 640D040C */  jal        strrchr
    /* D9174 800E8974 21204002 */   addu      $a0, $s2, $zero
    /* D9178 800E8978 21184000 */  addu       $v1, $v0, $zero
    /* D917C 800E897C 2B102302 */  sltu       $v0, $s1, $v1
    /* D9180 800E8980 02004010 */  beqz       $v0, .L800E898C
    /* D9184 800E8984 00000000 */   nop
    /* D9188 800E8988 21886000 */  addu       $s1, $v1, $zero
  .L800E898C:
    /* D918C 800E898C 01001026 */  addiu      $s0, $s0, 0x1
    /* D9190 800E8990 00000292 */  lbu        $v0, 0x0($s0)
    /* D9194 800E8994 00000000 */  nop
    /* D9198 800E8998 F4FF4014 */  bnez       $v0, .L800E896C
    /* D919C 800E899C 00000000 */   nop
  .L800E89A0:
    /* D91A0 800E89A0 21102002 */  addu       $v0, $s1, $zero
    /* D91A4 800E89A4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D91A8 800E89A8 1800B28F */  lw         $s2, 0x18($sp)
    /* D91AC 800E89AC 1400B18F */  lw         $s1, 0x14($sp)
    /* D91B0 800E89B0 1000B08F */  lw         $s0, 0x10($sp)
    /* D91B4 800E89B4 0800E003 */  jr         $ra
    /* D91B8 800E89B8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800E8940
