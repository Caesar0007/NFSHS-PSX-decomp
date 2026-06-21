.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawShape_SubtractNFS4RectEdges__FR4RECT, 0x1B0

glabel DrawShape_SubtractNFS4RectEdges__FR4RECT
    /* 3C600 8004BE00 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3C604 8004BE04 21488000 */  addu       $t1, $a0, $zero
    /* 3C608 8004BE08 21680000 */  addu       $t5, $zero, $zero
    /* 3C60C 8004BE0C 801F0E3C */  lui        $t6, (0x1F800004 >> 16)
    /* 3C610 8004BE10 0400CE35 */  ori        $t6, $t6, (0x1F800004 & 0xFFFF)
    /* 3C614 8004BE14 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3C618 8004BE18 801F103C */  lui        $s0, (0x1F800000 >> 16)
    /* 3C61C 8004BE1C FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* 3C620 8004BE20 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* 3C624 8004BE24 00FF0F3C */  lui        $t7, (0xFF000000 >> 16)
    /* 3C628 8004BE28 80000C3C */  lui        $t4, (0x808080 >> 16)
    /* 3C62C 8004BE2C 80808C35 */  ori        $t4, $t4, (0x808080 & 0xFFFF)
    /* 3C630 8004BE30 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 3C634 8004BE34 02002295 */  lhu        $v0, 0x2($t1)
    /* 3C638 8004BE38 06002395 */  lhu        $v1, 0x6($t1)
    /* 3C63C 8004BE3C 01004224 */  addiu      $v0, $v0, 0x1
    /* 3C640 8004BE40 21584000 */  addu       $t3, $v0, $zero
    /* 3C644 8004BE44 21104300 */  addu       $v0, $v0, $v1
    /* 3C648 8004BE48 FFFF4A24 */  addiu      $t2, $v0, -0x1
    /* 3C64C 8004BE4C 00002395 */  lhu        $v1, 0x0($t1)
    /* 3C650 8004BE50 04002295 */  lhu        $v0, 0x4($t1)
    /* 3C654 8004BE54 02006724 */  addiu      $a3, $v1, 0x2
    /* 3C658 8004BE58 00140200 */  sll        $v0, $v0, 16
    /* 3C65C 8004BE5C C3140200 */  sra        $v0, $v0, 19
    /* 3C660 8004BE60 21306200 */  addu       $a2, $v1, $v0
  .L8004BE64:
    /* 3C664 8004BE64 0000C48D */  lw         $a0, 0x0($t6)
    /* 3C668 8004BE68 0000058E */  lw         $a1, (0x1F800000 & 0xFFFF)($s0)
    /* 3C66C 8004BE6C 0000838C */  lw         $v1, 0x0($a0)
    /* 3C670 8004BE70 0000A28C */  lw         $v0, 0x0($a1)
    /* 3C674 8004BE74 24186F00 */  and        $v1, $v1, $t7
    /* 3C678 8004BE78 24104800 */  and        $v0, $v0, $t0
    /* 3C67C 8004BE7C 25186200 */  or         $v1, $v1, $v0
    /* 3C680 8004BE80 000083AC */  sw         $v1, 0x0($a0)
    /* 3C684 8004BE84 0000A38C */  lw         $v1, 0x0($a1)
    /* 3C688 8004BE88 24008224 */  addiu      $v0, $a0, 0x24
    /* 3C68C 8004BE8C 0000C2AD */  sw         $v0, 0x0($t6)
    /* 3C690 8004BE90 24108800 */  and        $v0, $a0, $t0
    /* 3C694 8004BE94 24186F00 */  and        $v1, $v1, $t7
    /* 3C698 8004BE98 25186200 */  or         $v1, $v1, $v0
    /* 3C69C 8004BE9C 3A000224 */  addiu      $v0, $zero, 0x3A
    /* 3C6A0 8004BEA0 0000A3AC */  sw         $v1, 0x0($a1)
    /* 3C6A4 8004BEA4 04008CAC */  sw         $t4, 0x4($a0)
    /* 3C6A8 8004BEA8 070082A0 */  sb         $v0, 0x7($a0)
    /* 3C6AC 8004BEAC 08000224 */  addiu      $v0, $zero, 0x8
    /* 3C6B0 8004BEB0 030082A0 */  sb         $v0, 0x3($a0)
    /* 3C6B4 8004BEB4 02006225 */  addiu      $v0, $t3, 0x2
    /* 3C6B8 8004BEB8 0A0082A4 */  sh         $v0, 0xA($a0)
    /* 3C6BC 8004BEBC FEFF4225 */  addiu      $v0, $t2, -0x2
    /* 3C6C0 8004BEC0 0100A325 */  addiu      $v1, $t5, 0x1
    /* 3C6C4 8004BEC4 21686000 */  addu       $t5, $v1, $zero
    /* 3C6C8 8004BEC8 001C0300 */  sll        $v1, $v1, 16
    /* 3C6CC 8004BECC 031C0300 */  sra        $v1, $v1, 16
    /* 3C6D0 8004BED0 14008CAC */  sw         $t4, 0x14($a0)
    /* 3C6D4 8004BED4 1C0080AC */  sw         $zero, 0x1C($a0)
    /* 3C6D8 8004BED8 0C0080AC */  sw         $zero, 0xC($a0)
    /* 3C6DC 8004BEDC 080087A4 */  sh         $a3, 0x8($a0)
    /* 3C6E0 8004BEE0 100086A4 */  sh         $a2, 0x10($a0)
    /* 3C6E4 8004BEE4 12008BA4 */  sh         $t3, 0x12($a0)
    /* 3C6E8 8004BEE8 180087A4 */  sh         $a3, 0x18($a0)
    /* 3C6EC 8004BEEC 1A0082A4 */  sh         $v0, 0x1A($a0)
    /* 3C6F0 8004BEF0 200086A4 */  sh         $a2, 0x20($a0)
    /* 3C6F4 8004BEF4 22008AA4 */  sh         $t2, 0x22($a0)
    /* 3C6F8 8004BEF8 00002495 */  lhu        $a0, 0x0($t1)
    /* 3C6FC 8004BEFC 04002295 */  lhu        $v0, 0x4($t1)
    /* 3C700 8004BF00 02006328 */  slti       $v1, $v1, 0x2
    /* 3C704 8004BF04 21208200 */  addu       $a0, $a0, $v0
    /* 3C708 8004BF08 FEFF8424 */  addiu      $a0, $a0, -0x2
    /* 3C70C 8004BF0C 21388000 */  addu       $a3, $a0, $zero
    /* 3C710 8004BF10 00140200 */  sll        $v0, $v0, 16
    /* 3C714 8004BF14 C3140200 */  sra        $v0, $v0, 19
    /* 3C718 8004BF18 D2FF6014 */  bnez       $v1, .L8004BE64
    /* 3C71C 8004BF1C 23308200 */   subu      $a2, $a0, $v0
    /* 3C720 8004BF20 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* 3C724 8004BF24 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* 3C728 8004BF28 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* 3C72C 8004BF2C FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* 3C730 8004BF30 02000424 */  addiu      $a0, $zero, 0x2
    /* 3C734 8004BF34 21288000 */  addu       $a1, $a0, $zero
    /* 3C738 8004BF38 21300000 */  addu       $a2, $zero, $zero
    /* 3C73C 8004BF3C 00010724 */  addiu      $a3, $zero, 0x100
    /* 3C740 8004BF40 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* 3C744 8004BF44 0000708D */  lw         $s0, 0x0($t3)
    /* 3C748 8004BF48 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* 3C74C 8004BF4C 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* 3C750 8004BF50 0000038E */  lw         $v1, 0x0($s0)
    /* 3C754 8004BF54 0000028D */  lw         $v0, 0x0($t0)
    /* 3C758 8004BF58 24186A00 */  and        $v1, $v1, $t2
    /* 3C75C 8004BF5C 24104900 */  and        $v0, $v0, $t1
    /* 3C760 8004BF60 25186200 */  or         $v1, $v1, $v0
    /* 3C764 8004BF64 000003AE */  sw         $v1, 0x0($s0)
    /* 3C768 8004BF68 0C000326 */  addiu      $v1, $s0, 0xC
    /* 3C76C 8004BF6C 0000028D */  lw         $v0, 0x0($t0)
    /* 3C770 8004BF70 24480902 */  and        $t1, $s0, $t1
    /* 3C774 8004BF74 000063AD */  sw         $v1, 0x0($t3)
    /* 3C778 8004BF78 24104A00 */  and        $v0, $v0, $t2
    /* 3C77C 8004BF7C 25104900 */  or         $v0, $v0, $t1
    /* 3C780 8004BF80 FFC6030C */  jal        GetTPage
    /* 3C784 8004BF84 000002AD */   sw        $v0, 0x0($t0)
    /* 3C788 8004BF88 21200002 */  addu       $a0, $s0, $zero
    /* 3C78C 8004BF8C 21280000 */  addu       $a1, $zero, $zero
    /* 3C790 8004BF90 2130A000 */  addu       $a2, $a1, $zero
    /* 3C794 8004BF94 FFFF4730 */  andi       $a3, $v0, 0xFFFF
    /* 3C798 8004BF98 EFB8030C */  jal        SetDrawMode
    /* 3C79C 8004BF9C 1000A0AF */   sw        $zero, 0x10($sp)
    /* 3C7A0 8004BFA0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3C7A4 8004BFA4 1800B08F */  lw         $s0, 0x18($sp)
    /* 3C7A8 8004BFA8 0800E003 */  jr         $ra
    /* 3C7AC 8004BFAC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel DrawShape_SubtractNFS4RectEdges__FR4RECT
