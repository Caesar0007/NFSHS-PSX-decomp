.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x58

glabel ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 392F0 80048AF0 0000C38C */  lw         $v1, 0x0($a2)
    /* 392F4 80048AF4 04000224 */  addiu      $v0, $zero, 0x4
    /* 392F8 80048AF8 11006210 */  beq        $v1, $v0, .L80048B40
    /* 392FC 80048AFC 0580023C */   lui       $v0, %hi(D_800514F8)
    /* 39300 80048B00 F8144294 */  lhu        $v0, %lo(D_800514F8)($v0)
    /* 39304 80048B04 00000000 */  nop
    /* 39308 80048B08 09004014 */  bnez       $v0, .L80048B30
    /* 3930C 80048B0C 21280000 */   addu      $a1, $zero, $zero
    /* 39310 80048B10 1480023C */  lui        $v0, %hi(ticks)
    /* 39314 80048B14 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 39318 80048B18 8800838C */  lw         $v1, 0x88($a0)
    /* 3931C 80048B1C 00000000 */  nop
    /* 39320 80048B20 23104300 */  subu       $v0, $v0, $v1
    /* 39324 80048B24 96004228 */  slti       $v0, $v0, 0x96
    /* 39328 80048B28 02004010 */  beqz       $v0, .L80048B34
    /* 3932C 80048B2C 00000000 */   nop
  .L80048B30:
    /* 39330 80048B30 01000524 */  addiu      $a1, $zero, 0x1
  .L80048B34:
    /* 39334 80048B34 0200A010 */  beqz       $a1, .L80048B40
    /* 39338 80048B38 01000224 */   addiu     $v0, $zero, 0x1
    /* 3933C 80048B3C 0000C2AC */  sw         $v0, 0x0($a2)
  .L80048B40:
    /* 39340 80048B40 0800E003 */  jr         $ra
    /* 39344 80048B44 00000000 */   nop
endlabel ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand
