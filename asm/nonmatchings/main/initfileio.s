.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching initfileio, 0x98

glabel initfileio
    /* E4234 800F3A34 1480023C */  lui        $v0, %hi(disablecd)
    /* E4238 800F3A38 58DC428C */  lw         $v0, %lo(disablecd)($v0)
    /* E423C 800F3A3C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E4240 800F3A40 07004014 */  bnez       $v0, .L800F3A60
    /* E4244 800F3A44 1000BFAF */   sw        $ra, 0x10($sp)
    /* E4248 800F3A48 1480023C */  lui        $v0, %hi(availablefilesystems)
    /* E424C 800F3A4C 60DC428C */  lw         $v0, %lo(availablefilesystems)($v0)
    /* E4250 800F3A50 00000000 */  nop
    /* E4254 800F3A54 01004234 */  ori        $v0, $v0, 0x1
    /* E4258 800F3A58 1480013C */  lui        $at, %hi(availablefilesystems)
    /* E425C 800F3A5C 60DC22AC */  sw         $v0, %lo(availablefilesystems)($at)
  .L800F3A60:
    /* E4260 800F3A60 3C1B040C */  jal        psxdevelopmentsystem
    /* E4264 800F3A64 00000000 */   nop
    /* E4268 800F3A68 12004010 */  beqz       $v0, .L800F3AB4
    /* E426C 800F3A6C 01000224 */   addiu     $v0, $zero, 0x1
    /* E4270 800F3A70 311B040C */  jal        PCinit
    /* E4274 800F3A74 00000000 */   nop
    /* E4278 800F3A78 0F80043C */  lui        $a0, %hi(readfile_systask)
    /* E427C 800F3A7C 803F8424 */  addiu      $a0, $a0, %lo(readfile_systask)
    /* E4280 800F3A80 21280000 */  addu       $a1, $zero, $zero
    /* E4284 800F3A84 BD9A030C */  jal        addsystemtask
    /* E4288 800F3A88 2130A000 */   addu      $a2, $a1, $zero
    /* E428C 800F3A8C 1480023C */  lui        $v0, %hi(availablefilesystems)
    /* E4290 800F3A90 60DC428C */  lw         $v0, %lo(availablefilesystems)($v0)
    /* E4294 800F3A94 02000324 */  addiu      $v1, $zero, 0x2
    /* E4298 800F3A98 1480013C */  lui        $at, %hi(currentfilesystem)
    /* E429C 800F3A9C 5CDC23AC */  sw         $v1, %lo(currentfilesystem)($at)
    /* E42A0 800F3AA0 25104300 */  or         $v0, $v0, $v1
    /* E42A4 800F3AA4 1480013C */  lui        $at, %hi(availablefilesystems)
    /* E42A8 800F3AA8 60DC22AC */  sw         $v0, %lo(availablefilesystems)($at)
    /* E42AC 800F3AAC AFCE0308 */  j          .L800F3ABC
    /* E42B0 800F3AB0 00000000 */   nop
  .L800F3AB4:
    /* E42B4 800F3AB4 1480013C */  lui        $at, %hi(currentfilesystem)
    /* E42B8 800F3AB8 5CDC22AC */  sw         $v0, %lo(currentfilesystem)($at)
  .L800F3ABC:
    /* E42BC 800F3ABC 1000BF8F */  lw         $ra, 0x10($sp)
    /* E42C0 800F3AC0 00000000 */  nop
    /* E42C4 800F3AC4 0800E003 */  jr         $ra
    /* E42C8 800F3AC8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel initfileio
