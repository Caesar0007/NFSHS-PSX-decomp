.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDsin, 0x94

glabel iSNDsin
    /* FD440 8010CC40 03120400 */  sra        $v0, $a0, 8
    /* FD444 8010CC44 03004330 */  andi       $v1, $v0, 0x3
    /* FD448 8010CC48 08006014 */  bnez       $v1, .L8010CC6C
    /* FD44C 8010CC4C FF008430 */   andi      $a0, $a0, 0xFF
    /* FD450 8010CC50 1480033C */  lui        $v1, %hi(sndsintbl)
    /* FD454 8010CC54 48C36324 */  addiu      $v1, $v1, %lo(sndsintbl)
    /* FD458 8010CC58 40100400 */  sll        $v0, $a0, 1
  .L8010CC5C:
    /* FD45C 8010CC5C 21104300 */  addu       $v0, $v0, $v1
    /* FD460 8010CC60 00004294 */  lhu        $v0, 0x0($v0)
    /* FD464 8010CC64 0800E003 */  jr         $ra
    /* FD468 8010CC68 00000000 */   nop
  .L8010CC6C:
    /* FD46C 8010CC6C 01000224 */  addiu      $v0, $zero, 0x1
    /* FD470 8010CC70 06006214 */  bne        $v1, $v0, .L8010CC8C
    /* FD474 8010CC74 00010224 */   addiu     $v0, $zero, 0x100
    /* FD478 8010CC78 1480033C */  lui        $v1, %hi(sndsintbl)
    /* FD47C 8010CC7C 48C36324 */  addiu      $v1, $v1, %lo(sndsintbl)
    /* FD480 8010CC80 23104400 */  subu       $v0, $v0, $a0
    /* FD484 8010CC84 17330408 */  j          .L8010CC5C
    /* FD488 8010CC88 40100200 */   sll       $v0, $v0, 1
  .L8010CC8C:
    /* FD48C 8010CC8C 02000224 */  addiu      $v0, $zero, 0x2
    /* FD490 8010CC90 0A006210 */  beq        $v1, $v0, .L8010CCBC
    /* FD494 8010CC94 40180400 */   sll       $v1, $a0, 1
    /* FD498 8010CC98 1480023C */  lui        $v0, %hi(sndsintbl)
    /* FD49C 8010CC9C 48C34224 */  addiu      $v0, $v0, %lo(sndsintbl)
    /* FD4A0 8010CCA0 00010324 */  addiu      $v1, $zero, 0x100
    /* FD4A4 8010CCA4 23186400 */  subu       $v1, $v1, $a0
    /* FD4A8 8010CCA8 40180300 */  sll        $v1, $v1, 1
    /* FD4AC 8010CCAC 21186200 */  addu       $v1, $v1, $v0
    /* FD4B0 8010CCB0 00006294 */  lhu        $v0, 0x0($v1)
    /* FD4B4 8010CCB4 0800E003 */  jr         $ra
    /* FD4B8 8010CCB8 23100200 */   negu      $v0, $v0
  .L8010CCBC:
    /* FD4BC 8010CCBC 1480023C */  lui        $v0, %hi(sndsintbl)
    /* FD4C0 8010CCC0 48C34224 */  addiu      $v0, $v0, %lo(sndsintbl)
    /* FD4C4 8010CCC4 21186200 */  addu       $v1, $v1, $v0
    /* FD4C8 8010CCC8 00006294 */  lhu        $v0, 0x0($v1)
    /* FD4CC 8010CCCC 0800E003 */  jr         $ra
    /* FD4D0 8010CCD0 23100200 */   negu      $v0, $v0
endlabel iSNDsin
