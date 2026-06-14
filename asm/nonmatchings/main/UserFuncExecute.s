.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UserFuncExecute, 0x6C

glabel UserFuncExecute
    /* FA48C 80109C8C 1480033C */  lui        $v1, %hi(D_8013C2E0)
    /* FA490 80109C90 E0C2638C */  lw         $v1, %lo(D_8013C2E0)($v1)
    /* FA494 80109C94 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA498 80109C98 13006004 */  bltz       $v1, .L80109CE8
    /* FA49C 80109C9C 1000BFAF */   sw        $ra, 0x10($sp)
    /* FA4A0 80109CA0 80100300 */  sll        $v0, $v1, 2
    /* FA4A4 80109CA4 00190300 */  sll        $v1, $v1, 4
    /* FA4A8 80109CA8 1580043C */  lui        $a0, %hi(D_80148A2C)
    /* FA4AC 80109CAC 2C8A8424 */  addiu      $a0, $a0, %lo(D_80148A2C)
    /* FA4B0 80109CB0 1580013C */  lui        $at, %hi(D_80148A6C)
    /* FA4B4 80109CB4 21082200 */  addu       $at, $at, $v0
    /* FA4B8 80109CB8 6C8A228C */  lw         $v0, %lo(D_80148A6C)($at)
    /* FA4BC 80109CBC 00000000 */  nop
    /* FA4C0 80109CC0 09F84000 */  jalr       $v0
    /* FA4C4 80109CC4 21206400 */   addu      $a0, $v1, $a0
    /* FA4C8 80109CC8 07004010 */  beqz       $v0, .L80109CE8
    /* FA4CC 80109CCC 00000000 */   nop
    /* FA4D0 80109CD0 1480023C */  lui        $v0, %hi(D_8013C2E0)
    /* FA4D4 80109CD4 E0C2428C */  lw         $v0, %lo(D_8013C2E0)($v0)
    /* FA4D8 80109CD8 00000000 */  nop
    /* FA4DC 80109CDC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* FA4E0 80109CE0 1480013C */  lui        $at, %hi(D_8013C2E0)
    /* FA4E4 80109CE4 E0C222AC */  sw         $v0, %lo(D_8013C2E0)($at)
  .L80109CE8:
    /* FA4E8 80109CE8 1000BF8F */  lw         $ra, 0x10($sp)
    /* FA4EC 80109CEC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* FA4F0 80109CF0 0800E003 */  jr         $ra
    /* FA4F4 80109CF4 00000000 */   nop
endlabel UserFuncExecute
