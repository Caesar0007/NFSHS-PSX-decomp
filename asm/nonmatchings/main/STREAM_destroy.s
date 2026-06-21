.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_destroy, 0xB4

glabel STREAM_destroy
    /* ED944 800FD144 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ED948 800FD148 1800B0AF */  sw         $s0, 0x18($sp)
    /* ED94C 800FD14C 21808000 */  addu       $s0, $a0, $zero
    /* ED950 800FD150 1000A527 */  addiu      $a1, $sp, 0x10
    /* ED954 800FD154 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* ED958 800FD158 BEF0030C */  jal        validatehandle
    /* ED95C 800FD15C 1400A627 */   addiu     $a2, $sp, 0x14
    /* ED960 800FD160 21004014 */  bnez       $v0, .L800FD1E8
    /* ED964 800FD164 00000000 */   nop
    /* ED968 800FD168 02F6030C */  jal        STREAM_kill
    /* ED96C 800FD16C 21200002 */   addu      $a0, $s0, $zero
    /* ED970 800FD170 1000A28F */  lw         $v0, 0x10($sp)
    /* ED974 800FD174 00000000 */  nop
    /* ED978 800FD178 2800438C */  lw         $v1, 0x28($v0)
    /* ED97C 800FD17C 01000224 */  addiu      $v0, $zero, 0x1
    /* ED980 800FD180 0F006214 */  bne        $v1, $v0, .L800FD1C0
    /* ED984 800FD184 21804000 */   addu      $s0, $v0, $zero
  .L800FD188:
    /* ED988 800FD188 02F9030C */  jal        iscurrentthread
    /* ED98C 800FD18C 21200000 */   addu      $a0, $zero, $zero
    /* ED990 800FD190 03004010 */  beqz       $v0, .L800FD1A0
    /* ED994 800FD194 00000000 */   nop
    /* ED998 800FD198 019B030C */  jal        systemtask
    /* ED99C 800FD19C 21200000 */   addu      $a0, $zero, $zero
  .L800FD1A0:
    /* ED9A0 800FD1A0 07F9030C */  jal        yieldthread
    /* ED9A4 800FD1A4 21200000 */   addu      $a0, $zero, $zero
    /* ED9A8 800FD1A8 1000A28F */  lw         $v0, 0x10($sp)
    /* ED9AC 800FD1AC 00000000 */  nop
    /* ED9B0 800FD1B0 2800428C */  lw         $v0, 0x28($v0)
    /* ED9B4 800FD1B4 00000000 */  nop
    /* ED9B8 800FD1B8 F3FF5010 */  beq        $v0, $s0, .L800FD188
    /* ED9BC 800FD1BC 00000000 */   nop
  .L800FD1C0:
    /* ED9C0 800FD1C0 1000A28F */  lw         $v0, 0x10($sp)
    /* ED9C4 800FD1C4 00000000 */  nop
    /* ED9C8 800FD1C8 0400448C */  lw         $a0, 0x4($v0)
    /* ED9CC 800FD1CC 20F9030C */  jal        freemutex
    /* ED9D0 800FD1D0 000040AC */   sw        $zero, 0x0($v0)
    /* ED9D4 800FD1D4 1000A28F */  lw         $v0, 0x10($sp)
    /* ED9D8 800FD1D8 00000000 */  nop
    /* ED9DC 800FD1DC 9C00448C */  lw         $a0, 0x9C($v0)
    /* ED9E0 800FD1E0 54AA030C */  jal        FILE_closesync
    /* ED9E4 800FD1E4 64000524 */   addiu     $a1, $zero, 0x64
  .L800FD1E8:
    /* ED9E8 800FD1E8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* ED9EC 800FD1EC 1800B08F */  lw         $s0, 0x18($sp)
    /* ED9F0 800FD1F0 0800E003 */  jr         $ra
    /* ED9F4 800FD1F4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_destroy
