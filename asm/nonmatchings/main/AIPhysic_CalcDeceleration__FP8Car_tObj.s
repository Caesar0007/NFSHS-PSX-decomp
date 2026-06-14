.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CalcDeceleration__FP8Car_tObj, 0x4C

glabel AIPhysic_CalcDeceleration__FP8Car_tObj
    /* 5A1E8 800699E8 B806828C */  lw         $v0, 0x6B8($a0)
    /* 5A1EC 800699EC 3007858C */  lw         $a1, 0x730($a0)
    /* 5A1F0 800699F0 8000438C */  lw         $v1, 0x80($v0)
    /* 5A1F4 800699F4 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 5A1F8 800699F8 2A104500 */  slt        $v0, $v0, $a1
    /* 5A1FC 800699FC 0B004010 */  beqz       $v0, .L80069A2C
    /* 5A200 80069A00 00000000 */   nop
    /* 5A204 80069A04 02006104 */  bgez       $v1, .L80069A10
    /* 5A208 80069A08 21206000 */   addu      $a0, $v1, $zero
    /* 5A20C 80069A0C FF006424 */  addiu      $a0, $v1, 0xFF
  .L80069A10:
    /* 5A210 80069A10 2110A000 */  addu       $v0, $a1, $zero
    /* 5A214 80069A14 02004104 */  bgez       $v0, .L80069A20
    /* 5A218 80069A18 031A0400 */   sra       $v1, $a0, 8
    /* 5A21C 80069A1C FF004224 */  addiu      $v0, $v0, 0xFF
  .L80069A20:
    /* 5A220 80069A20 03120200 */  sra        $v0, $v0, 8
    /* 5A224 80069A24 18006200 */  mult       $v1, $v0
    /* 5A228 80069A28 12180000 */  mflo       $v1
  .L80069A2C:
    /* 5A22C 80069A2C 0800E003 */  jr         $ra
    /* 5A230 80069A30 21106000 */   addu      $v0, $v1, $zero
endlabel AIPhysic_CalcDeceleration__FP8Car_tObj
