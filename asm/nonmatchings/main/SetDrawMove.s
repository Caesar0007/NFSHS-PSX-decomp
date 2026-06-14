.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDrawMove, 0x60

glabel SetDrawMove
    /* FCE98 8010C698 21408000 */  addu       $t0, $a0, $zero
    /* FCE9C 8010C69C 0400A284 */  lh         $v0, 0x4($a1)
    /* FCEA0 8010C6A0 00000000 */  nop
    /* FCEA4 8010C6A4 05004010 */  beqz       $v0, .L8010C6BC
    /* FCEA8 8010C6A8 05000424 */   addiu     $a0, $zero, 0x5
    /* FCEAC 8010C6AC 0600A284 */  lh         $v0, 0x6($a1)
    /* FCEB0 8010C6B0 00000000 */  nop
    /* FCEB4 8010C6B4 03004014 */  bnez       $v0, .L8010C6C4
    /* FCEB8 8010C6B8 0001023C */   lui       $v0, (0x1000000 >> 16)
  .L8010C6BC:
    /* FCEBC 8010C6BC 21200000 */  addu       $a0, $zero, $zero
    /* FCEC0 8010C6C0 0001023C */  lui        $v0, (0x1000000 >> 16)
  .L8010C6C4:
    /* FCEC4 8010C6C4 040002AD */  sw         $v0, 0x4($t0)
    /* FCEC8 8010C6C8 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* FCECC 8010C6CC 080002AD */  sw         $v0, 0x8($t0)
    /* FCED0 8010C6D0 00140700 */  sll        $v0, $a3, 16
    /* FCED4 8010C6D4 FFFFC330 */  andi       $v1, $a2, 0xFFFF
    /* FCED8 8010C6D8 030004A1 */  sb         $a0, 0x3($t0)
    /* FCEDC 8010C6DC 0000A48C */  lw         $a0, 0x0($a1)
    /* FCEE0 8010C6E0 25104300 */  or         $v0, $v0, $v1
    /* FCEE4 8010C6E4 100002AD */  sw         $v0, 0x10($t0)
    /* FCEE8 8010C6E8 0C0004AD */  sw         $a0, 0xC($t0)
    /* FCEEC 8010C6EC 0400A28C */  lw         $v0, 0x4($a1)
    /* FCEF0 8010C6F0 0800E003 */  jr         $ra
    /* FCEF4 8010C6F4 140002AD */   sw        $v0, 0x14($t0)
endlabel SetDrawMove
