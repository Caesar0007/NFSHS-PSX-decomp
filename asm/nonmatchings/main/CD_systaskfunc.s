.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_systaskfunc, 0x15C

glabel CD_systaskfunc
    /* EA2E8 800F9AE8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* EA2EC 800F9AEC 2800B0AF */  sw         $s0, 0x28($sp)
    /* EA2F0 800F9AF0 21800000 */  addu       $s0, $zero, $zero
    /* EA2F4 800F9AF4 01000424 */  addiu      $a0, $zero, 0x1
    /* EA2F8 800F9AF8 3000BFAF */  sw         $ra, 0x30($sp)
    /* EA2FC 800F9AFC 12A1030C */  jal        CdDiskReady
    /* EA300 800F9B00 2C00B1AF */   sw        $s1, 0x2C($sp)
    /* EA304 800F9B04 21184000 */  addu       $v1, $v0, $zero
    /* EA308 800F9B08 05000224 */  addiu      $v0, $zero, 0x5
    /* EA30C 800F9B0C 0A006210 */  beq        $v1, $v0, .L800F9B38
    /* EA310 800F9B10 06006228 */   slti      $v0, $v1, 0x6
    /* EA314 800F9B14 18004010 */  beqz       $v0, .L800F9B78
    /* EA318 800F9B18 02000224 */   addiu     $v0, $zero, 0x2
    /* EA31C 800F9B1C 16006214 */  bne        $v1, $v0, .L800F9B78
    /* EA320 800F9B20 00000000 */   nop
    /* EA324 800F9B24 61A1030C */  jal        CdGetDiskType
    /* EA328 800F9B28 00000000 */   nop
    /* EA32C 800F9B2C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* EA330 800F9B30 DEE60308 */  j          .L800F9B78
    /* EA334 800F9B34 0200502C */   sltiu     $s0, $v0, 0x2
  .L800F9B38:
    /* EA338 800F9B38 1480023C */  lui        $v0, %hi(Cdinfo)
    /* EA33C 800F9B3C C46C4424 */  addiu      $a0, $v0, %lo(Cdinfo)
    /* EA340 800F9B40 1800828C */  lw         $v0, 0x18($a0)
    /* EA344 800F9B44 00000000 */  nop
    /* EA348 800F9B48 08004014 */  bnez       $v0, .L800F9B6C
    /* EA34C 800F9B4C FFFF4224 */   addiu     $v0, $v0, -0x1
    /* EA350 800F9B50 1480023C */  lui        $v0, %hi(timerhz)
    /* EA354 800F9B54 C4DC438C */  lw         $v1, %lo(timerhz)($v0)
    /* EA358 800F9B58 00000000 */  nop
    /* EA35C 800F9B5C 80100300 */  sll        $v0, $v1, 2
    /* EA360 800F9B60 21104300 */  addu       $v0, $v0, $v1
    /* EA364 800F9B64 DEE60308 */  j          .L800F9B78
    /* EA368 800F9B68 180082AC */   sw        $v0, 0x18($a0)
  .L800F9B6C:
    /* EA36C 800F9B6C 02004014 */  bnez       $v0, .L800F9B78
    /* EA370 800F9B70 180082AC */   sw        $v0, 0x18($a0)
    /* EA374 800F9B74 01001024 */  addiu      $s0, $zero, 0x1
  .L800F9B78:
    /* EA378 800F9B78 2C000012 */  beqz       $s0, .L800F9C2C
    /* EA37C 800F9B7C 1080043C */   lui       $a0, %hi(CD_systaskfunc)
    /* EA380 800F9B80 EA9A030C */  jal        delsystemtask
    /* EA384 800F9B84 E89A8424 */   addiu     $a0, $a0, %lo(CD_systaskfunc)
    /* EA388 800F9B88 EBDD030C */  jal        CdReset
    /* EA38C 800F9B8C 21200000 */   addu      $a0, $zero, $zero
    /* EA390 800F9B90 0E000424 */  addiu      $a0, $zero, 0xE
    /* EA394 800F9B94 2000A527 */  addiu      $a1, $sp, 0x20
    /* EA398 800F9B98 1000A627 */  addiu      $a2, $sp, 0x10
    /* EA39C 800F9B9C A0000224 */  addiu      $v0, $zero, 0xA0
    /* EA3A0 800F9BA0 C9DE030C */  jal        CdControlB
    /* EA3A4 800F9BA4 2000A2A3 */   sb        $v0, 0x20($sp)
    /* EA3A8 800F9BA8 C7C8030C */  jal        VSync
    /* EA3AC 800F9BAC 03000424 */   addiu     $a0, $zero, 0x3
    /* EA3B0 800F9BB0 06DE030C */  jal        CdFlush
    /* EA3B4 800F9BB4 00000000 */   nop
    /* EA3B8 800F9BB8 21200000 */  addu       $a0, $zero, $zero
    /* EA3BC 800F9BBC 13DE030C */  jal        CdSync
    /* EA3C0 800F9BC0 21288000 */   addu      $a1, $a0, $zero
    /* EA3C4 800F9BC4 1480023C */  lui        $v0, %hi(Cdinfo)
    /* EA3C8 800F9BC8 C46C5124 */  addiu      $s1, $v0, %lo(Cdinfo)
    /* EA3CC 800F9BCC 1800B027 */  addiu      $s0, $sp, 0x18
    /* EA3D0 800F9BD0 0C00248E */  lw         $a0, 0xC($s1)
    /* EA3D4 800F9BD4 3DDF030C */  jal        CdIntToPos
    /* EA3D8 800F9BD8 21280002 */   addu      $a1, $s0, $zero
    /* EA3DC 800F9BDC 1B000424 */  addiu      $a0, $zero, 0x1B
    /* EA3E0 800F9BE0 21280002 */  addu       $a1, $s0, $zero
    /* EA3E4 800F9BE4 2DDE030C */  jal        CdControl
    /* EA3E8 800F9BE8 1000A627 */   addiu     $a2, $sp, 0x10
    /* EA3EC 800F9BEC 1080043C */  lui        $a0, %hi(CdReadyHandler)
    /* EA3F0 800F9BF0 28DE030C */  jal        CdReadyCallback
    /* EA3F4 800F9BF4 A49C8424 */   addiu     $a0, $a0, %lo(CdReadyHandler)
    /* EA3F8 800F9BF8 2400228E */  lw         $v0, 0x24($s1)
    /* EA3FC 800F9BFC 00000000 */  nop
    /* EA400 800F9C00 0A004018 */  blez       $v0, .L800F9C2C
    /* EA404 800F9C04 1480023C */   lui       $v0, %hi(timerhz)
    /* EA408 800F9C08 1080043C */  lui        $a0, %hi(CD_timerfunc)
    /* EA40C 800F9C0C C4DC438C */  lw         $v1, %lo(timerhz)($v0)
    /* EA410 800F9C10 449C8424 */  addiu      $a0, $a0, %lo(CD_timerfunc)
    /* EA414 800F9C14 1C0020AE */  sw         $zero, 0x1C($s1)
    /* EA418 800F9C18 40100300 */  sll        $v0, $v1, 1
    /* EA41C 800F9C1C 21104300 */  addu       $v0, $v0, $v1
    /* EA420 800F9C20 40100200 */  sll        $v0, $v0, 1
    /* EA424 800F9C24 FAAB030C */  jal        addtimer
    /* EA428 800F9C28 180022AE */   sw        $v0, 0x18($s1)
  .L800F9C2C:
    /* EA42C 800F9C2C 3000BF8F */  lw         $ra, 0x30($sp)
    /* EA430 800F9C30 2C00B18F */  lw         $s1, 0x2C($sp)
    /* EA434 800F9C34 2800B08F */  lw         $s0, 0x28($sp)
    /* EA438 800F9C38 21100000 */  addu       $v0, $zero, $zero
    /* EA43C 800F9C3C 0800E003 */  jr         $ra
    /* EA440 800F9C40 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CD_systaskfunc
