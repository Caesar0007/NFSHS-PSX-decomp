.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LocateCreateGroupType__15SerializedGroupiP9SimpleMemi, 0x78

glabel LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 8CA04 8009C204 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8CA08 8009C208 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8CA0C 8009C20C 21808000 */  addu       $s0, $a0, $zero
    /* 8CA10 8009C210 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8CA14 8009C214 2188A000 */  addu       $s1, $a1, $zero
    /* 8CA18 8009C218 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8CA1C 8009C21C 2198C000 */  addu       $s3, $a2, $zero
    /* 8CA20 8009C220 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8CA24 8009C224 2190E000 */  addu       $s2, $a3, $zero
    /* 8CA28 8009C228 2000BFAF */  sw         $ra, 0x20($sp)
    /* 8CA2C 8009C22C 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* 8CA30 8009C230 21304002 */   addu      $a2, $s2, $zero
    /* 8CA34 8009C234 03004014 */  bnez       $v0, .L8009C244
    /* 8CA38 8009C238 21200002 */   addu      $a0, $s0, $zero
    /* 8CA3C 8009C23C 98700208 */  j          .L8009C260
    /* 8CA40 8009C240 21100000 */   addu      $v0, $zero, $zero
  .L8009C244:
    /* 8CA44 8009C244 21282002 */  addu       $a1, $s1, $zero
    /* 8CA48 8009C248 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* 8CA4C 8009C24C 21304002 */   addu      $a2, $s2, $zero
    /* 8CA50 8009C250 21200002 */  addu       $a0, $s0, $zero
    /* 8CA54 8009C254 21284000 */  addu       $a1, $v0, $zero
    /* 8CA58 8009C258 9F70020C */  jal        CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
    /* 8CA5C 8009C25C 21306002 */   addu      $a2, $s3, $zero
  .L8009C260:
    /* 8CA60 8009C260 2000BF8F */  lw         $ra, 0x20($sp)
    /* 8CA64 8009C264 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8CA68 8009C268 1800B28F */  lw         $s2, 0x18($sp)
    /* 8CA6C 8009C26C 1400B18F */  lw         $s1, 0x14($sp)
    /* 8CA70 8009C270 1000B08F */  lw         $s0, 0x10($sp)
    /* 8CA74 8009C274 0800E003 */  jr         $ra
    /* 8CA78 8009C278 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
