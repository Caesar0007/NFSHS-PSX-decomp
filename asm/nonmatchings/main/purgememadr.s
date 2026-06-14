.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching purgememadr, 0xC8

glabel purgememadr
    /* D5D40 800E5540 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D5D44 800E5544 2000BFAF */  sw         $ra, 0x20($sp)
    /* D5D48 800E5548 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D5D4C 800E554C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D5D50 800E5550 1400B1AF */  sw         $s1, 0x14($sp)
    /* D5D54 800E5554 24008010 */  beqz       $a0, .L800E55E8
    /* D5D58 800E5558 1000B0AF */   sw        $s0, 0x10($sp)
    /* D5D5C 800E555C F0FF9024 */  addiu      $s0, $a0, -0x10
    /* D5D60 800E5560 1480023C */  lui        $v0, %hi(memclass)
    /* D5D64 800E5564 00E94224 */  addiu      $v0, $v0, %lo(memclass)
    /* D5D68 800E5568 0800118E */  lw         $s1, 0x8($s0)
    /* D5D6C 800E556C F2FF8394 */  lhu        $v1, -0xE($a0)
    /* D5D70 800E5570 0C00128E */  lw         $s2, 0xC($s0)
    /* D5D74 800E5574 0F006330 */  andi       $v1, $v1, 0xF
    /* D5D78 800E5578 80180300 */  sll        $v1, $v1, 2
    /* D5D7C 800E557C 21186200 */  addu       $v1, $v1, $v0
    /* D5D80 800E5580 02004496 */  lhu        $a0, 0x2($s2)
    /* D5D84 800E5584 0000738C */  lw         $s3, 0x0($v1)
    /* D5D88 800E5588 00408430 */  andi       $a0, $a0, 0x4000
    /* D5D8C 800E558C 08008010 */  beqz       $a0, .L800E55B0
    /* D5D90 800E5590 21206002 */   addu      $a0, $s3, $zero
    /* D5D94 800E5594 C193030C */  jal        FREE_remove
    /* D5D98 800E5598 21284002 */   addu      $a1, $s2, $zero
    /* D5D9C 800E559C 21804002 */  addu       $s0, $s2, $zero
    /* D5DA0 800E55A0 0C00128E */  lw         $s2, 0xC($s0)
    /* D5DA4 800E55A4 080011AE */  sw         $s1, 0x8($s0)
    /* D5DA8 800E55A8 080050AE */  sw         $s0, 0x8($s2)
    /* D5DAC 800E55AC 0C0030AE */  sw         $s0, 0xC($s1)
  .L800E55B0:
    /* D5DB0 800E55B0 02002296 */  lhu        $v0, 0x2($s1)
    /* D5DB4 800E55B4 00000000 */  nop
    /* D5DB8 800E55B8 00404230 */  andi       $v0, $v0, 0x4000
    /* D5DBC 800E55BC 07004010 */  beqz       $v0, .L800E55DC
    /* D5DC0 800E55C0 21206002 */   addu      $a0, $s3, $zero
    /* D5DC4 800E55C4 C193030C */  jal        FREE_remove
    /* D5DC8 800E55C8 21282002 */   addu      $a1, $s1, $zero
    /* D5DCC 800E55CC 0800318E */  lw         $s1, 0x8($s1)
    /* D5DD0 800E55D0 0C0012AE */  sw         $s2, 0xC($s0)
    /* D5DD4 800E55D4 080011AE */  sw         $s1, 0x8($s0)
    /* D5DD8 800E55D8 0C0030AE */  sw         $s0, 0xC($s1)
  .L800E55DC:
    /* D5DDC 800E55DC 21206002 */  addu       $a0, $s3, $zero
    /* D5DE0 800E55E0 9C93030C */  jal        FREE_add
    /* D5DE4 800E55E4 21280002 */   addu      $a1, $s0, $zero
  .L800E55E8:
    /* D5DE8 800E55E8 2000BF8F */  lw         $ra, 0x20($sp)
    /* D5DEC 800E55EC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D5DF0 800E55F0 1800B28F */  lw         $s2, 0x18($sp)
    /* D5DF4 800E55F4 1400B18F */  lw         $s1, 0x14($sp)
    /* D5DF8 800E55F8 1000B08F */  lw         $s0, 0x10($sp)
    /* D5DFC 800E55FC 01000224 */  addiu      $v0, $zero, 0x1
    /* D5E00 800E5600 0800E003 */  jr         $ra
    /* D5E04 800E5604 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel purgememadr
