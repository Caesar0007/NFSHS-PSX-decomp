.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_kill, 0x1A4

glabel STREAM_kill
    /* EE008 800FD808 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE00C 800FD80C 1800B0AF */  sw         $s0, 0x18($sp)
    /* EE010 800FD810 21808000 */  addu       $s0, $a0, $zero
    /* EE014 800FD814 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE018 800FD818 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* EE01C 800FD81C BEF0030C */  jal        validatehandle
    /* EE020 800FD820 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE024 800FD824 5D004014 */  bnez       $v0, .L800FD99C
    /* EE028 800FD828 00000000 */   nop
    /* EE02C 800FD82C 1000A28F */  lw         $v0, 0x10($sp)
    /* EE030 800FD830 00000000 */  nop
    /* EE034 800FD834 5400458C */  lw         $a1, 0x54($v0)
    /* EE038 800FD838 00000000 */  nop
    /* EE03C 800FD83C 5700A010 */  beqz       $a1, .L800FD99C
    /* EE040 800FD840 00000000 */   nop
    /* EE044 800FD844 19F60308 */  j          .L800FD864
    /* EE048 800FD848 00000000 */   nop
  .L800FD84C:
    /* EE04C 800FD84C 0000A58C */  lw         $a1, 0x0($a1)
    /* EE050 800FD850 55F5030C */  jal        STREAM_cancelrequest
    /* EE054 800FD854 21200002 */   addu      $a0, $s0, $zero
    /* EE058 800FD858 1000A28F */  lw         $v0, 0x10($sp)
    /* EE05C 800FD85C 00000000 */  nop
    /* EE060 800FD860 5400458C */  lw         $a1, 0x54($v0)
  .L800FD864:
    /* EE064 800FD864 00000000 */  nop
    /* EE068 800FD868 0400A28C */  lw         $v0, 0x4($a1)
    /* EE06C 800FD86C 00000000 */  nop
    /* EE070 800FD870 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* EE074 800FD874 0200422C */  sltiu      $v0, $v0, 0x2
    /* EE078 800FD878 06004010 */  beqz       $v0, .L800FD894
    /* EE07C 800FD87C 00000000 */   nop
    /* EE080 800FD880 13F60308 */  j          .L800FD84C
    /* EE084 800FD884 00000000 */   nop
  .L800FD888:
    /* EE088 800FD888 4C00858C */  lw         $a1, 0x4C($a0)
    /* EE08C 800FD88C 52F1030C */  jal        freerequest
    /* EE090 800FD890 00000000 */   nop
  .L800FD894:
    /* EE094 800FD894 1000A48F */  lw         $a0, 0x10($sp)
    /* EE098 800FD898 00000000 */  nop
    /* EE09C 800FD89C 4C00838C */  lw         $v1, 0x4C($a0)
    /* EE0A0 800FD8A0 5000828C */  lw         $v0, 0x50($a0)
    /* EE0A4 800FD8A4 00000000 */  nop
    /* EE0A8 800FD8A8 F7FF6214 */  bne        $v1, $v0, .L800FD888
    /* EE0AC 800FD8AC 00000000 */   nop
    /* EE0B0 800FD8B0 1000A28F */  lw         $v0, 0x10($sp)
    /* EE0B4 800FD8B4 00000000 */  nop
    /* EE0B8 800FD8B8 21284000 */  addu       $a1, $v0, $zero
    /* EE0BC 800FD8BC 5000438C */  lw         $v1, 0x50($v0)
    /* EE0C0 800FD8C0 04000224 */  addiu      $v0, $zero, 0x4
    /* EE0C4 800FD8C4 040062AC */  sw         $v0, 0x4($v1)
    /* EE0C8 800FD8C8 1C00A28C */  lw         $v0, 0x1C($a1)
    /* EE0CC 800FD8CC 00000000 */  nop
    /* EE0D0 800FD8D0 0B004018 */  blez       $v0, .L800FD900
    /* EE0D4 800FD8D4 21200000 */   addu      $a0, $zero, $zero
    /* EE0D8 800FD8D8 00190400 */  sll        $v1, $a0, 4
  .L800FD8DC:
    /* EE0DC 800FD8DC 1800A28C */  lw         $v0, 0x18($a1)
    /* EE0E0 800FD8E0 1000A58F */  lw         $a1, 0x10($sp)
    /* EE0E4 800FD8E4 21186200 */  addu       $v1, $v1, $v0
    /* EE0E8 800FD8E8 080060AC */  sw         $zero, 0x8($v1)
    /* EE0EC 800FD8EC 1C00A28C */  lw         $v0, 0x1C($a1)
    /* EE0F0 800FD8F0 01008424 */  addiu      $a0, $a0, 0x1
    /* EE0F4 800FD8F4 2A108200 */  slt        $v0, $a0, $v0
    /* EE0F8 800FD8F8 F8FF4014 */  bnez       $v0, .L800FD8DC
    /* EE0FC 800FD8FC 00190400 */   sll       $v1, $a0, 4
  .L800FD900:
    /* EE100 800FD900 1000A48F */  lw         $a0, 0x10($sp)
    /* EE104 800FD904 00000000 */  nop
    /* EE108 800FD908 3C00858C */  lw         $a1, 0x3C($a0)
    /* EE10C 800FD90C DDF0030C */  jal        decbufferusage
    /* EE110 800FD910 00000000 */   nop
    /* EE114 800FD914 1000A48F */  lw         $a0, 0x10($sp)
    /* EE118 800FD918 00000000 */  nop
    /* EE11C 800FD91C 4000838C */  lw         $v1, 0x40($a0)
    /* EE120 800FD920 4400828C */  lw         $v0, 0x44($a0)
    /* EE124 800FD924 00000000 */  nop
    /* EE128 800FD928 17006210 */  beq        $v1, $v0, .L800FD988
    /* EE12C 800FD92C 00000000 */   nop
    /* EE130 800FD930 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* EE134 800FD934 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* EE138 800FD938 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* EE13C 800FD93C FEFF0624 */  addiu      $a2, $zero, -0x2
  .L800FD940:
    /* EE140 800FD940 0000628C */  lw         $v0, 0x0($v1)
    /* EE144 800FD944 00000000 */  nop
    /* EE148 800FD948 04004714 */  bne        $v0, $a3, .L800FD95C
    /* EE14C 800FD94C 00000000 */   nop
    /* EE150 800FD950 2000838C */  lw         $v1, 0x20($a0)
    /* EE154 800FD954 5CF60308 */  j          .L800FD970
    /* EE158 800FD958 00000000 */   nop
  .L800FD95C:
    /* EE15C 800FD95C 0400628C */  lw         $v0, 0x4($v1)
    /* EE160 800FD960 000066AC */  sw         $a2, 0x0($v1)
    /* EE164 800FD964 24104500 */  and        $v0, $v0, $a1
    /* EE168 800FD968 040062AC */  sw         $v0, 0x4($v1)
    /* EE16C 800FD96C 21186200 */  addu       $v1, $v1, $v0
  .L800FD970:
    /* EE170 800FD970 1000A48F */  lw         $a0, 0x10($sp)
    /* EE174 800FD974 00000000 */  nop
    /* EE178 800FD978 4400828C */  lw         $v0, 0x44($a0)
    /* EE17C 800FD97C 00000000 */  nop
    /* EE180 800FD980 EFFF6214 */  bne        $v1, $v0, .L800FD940
    /* EE184 800FD984 00000000 */   nop
  .L800FD988:
    /* EE188 800FD988 2800838C */  lw         $v1, 0x28($a0)
    /* EE18C 800FD98C 02000224 */  addiu      $v0, $zero, 0x2
    /* EE190 800FD990 02006214 */  bne        $v1, $v0, .L800FD99C
    /* EE194 800FD994 00000000 */   nop
    /* EE198 800FD998 280080AC */  sw         $zero, 0x28($a0)
  .L800FD99C:
    /* EE19C 800FD99C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* EE1A0 800FD9A0 1800B08F */  lw         $s0, 0x18($sp)
    /* EE1A4 800FD9A4 0800E003 */  jr         $ra
    /* EE1A8 800FD9A8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_kill
