.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DecDCTin, 0x7C

glabel DecDCTin
    /* E91FC 800F89FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E9200 800F8A00 0100A230 */  andi       $v0, $a1, 0x1
    /* E9204 800F8A04 06004010 */  beqz       $v0, .L800F8A20
    /* E9208 800F8A08 1000BFAF */   sw        $ra, 0x10($sp)
    /* E920C 800F8A0C FFF7033C */  lui        $v1, (0xF7FFFFFF >> 16)
    /* E9210 800F8A10 0000828C */  lw         $v0, 0x0($a0)
    /* E9214 800F8A14 FFFF6334 */  ori        $v1, $v1, (0xF7FFFFFF & 0xFFFF)
    /* E9218 800F8A18 8BE20308 */  j          .L800F8A2C
    /* E921C 800F8A1C 24104300 */   and       $v0, $v0, $v1
  .L800F8A20:
    /* E9220 800F8A20 0000828C */  lw         $v0, 0x0($a0)
    /* E9224 800F8A24 0008033C */  lui        $v1, (0x8000000 >> 16)
    /* E9228 800F8A28 25104300 */  or         $v0, $v0, $v1
  .L800F8A2C:
    /* E922C 800F8A2C 000082AC */  sw         $v0, 0x0($a0)
    /* E9230 800F8A30 0200A230 */  andi       $v0, $a1, 0x2
    /* E9234 800F8A34 04004010 */  beqz       $v0, .L800F8A48
    /* E9238 800F8A38 0002033C */   lui       $v1, (0x2000000 >> 16)
    /* E923C 800F8A3C 0000828C */  lw         $v0, 0x0($a0)
    /* E9240 800F8A40 96E20308 */  j          .L800F8A58
    /* E9244 800F8A44 25104300 */   or        $v0, $v0, $v1
  .L800F8A48:
    /* E9248 800F8A48 FFFD033C */  lui        $v1, (0xFDFFFFFF >> 16)
    /* E924C 800F8A4C 0000828C */  lw         $v0, 0x0($a0)
    /* E9250 800F8A50 FFFF6334 */  ori        $v1, $v1, (0xFDFFFFFF & 0xFFFF)
    /* E9254 800F8A54 24104300 */  and        $v0, $v0, $v1
  .L800F8A58:
    /* E9258 800F8A58 000082AC */  sw         $v0, 0x0($a0)
    /* E925C 800F8A5C 00008594 */  lhu        $a1, 0x0($a0)
    /* E9260 800F8A60 FAE2030C */  jal        _MDEC_in_dma
    /* E9264 800F8A64 00000000 */   nop
    /* E9268 800F8A68 1000BF8F */  lw         $ra, 0x10($sp)
    /* E926C 800F8A6C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E9270 800F8A70 0800E003 */  jr         $ra
    /* E9274 800F8A74 00000000 */   nop
endlabel DecDCTin
