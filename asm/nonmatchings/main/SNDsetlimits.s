.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDsetlimits, 0x80

glabel SNDsetlimits
    /* DA7D4 800E9FD4 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA7D8 800E9FD8 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA7DC 800E9FDC 00000000 */  nop
    /* DA7E0 800E9FE0 03004014 */  bnez       $v0, .L800E9FF0
    /* DA7E4 800E9FE4 21188000 */   addu      $v1, $a0, $zero
    /* DA7E8 800E9FE8 0800E003 */  jr         $ra
    /* DA7EC 800E9FEC F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E9FF0:
    /* DA7F0 800E9FF0 1000628C */  lw         $v0, 0x10($v1)
    /* DA7F4 800E9FF4 00000000 */  nop
    /* DA7F8 800E9FF8 00204228 */  slti       $v0, $v0, 0x2000
    /* DA7FC 800E9FFC 13004014 */  bnez       $v0, .L800EA04C
    /* DA800 800EA000 21100000 */   addu      $v0, $zero, $zero
    /* DA804 800EA004 1280043C */  lui        $a0, %hi(sndpsxlimits)
    /* DA808 800EA008 D4348924 */  addiu      $t1, $a0, %lo(sndpsxlimits)
    /* DA80C 800EA00C 0000668C */  lw         $a2, 0x0($v1)
    /* DA810 800EA010 0400678C */  lw         $a3, 0x4($v1)
    /* DA814 800EA014 0800688C */  lw         $t0, 0x8($v1)
    /* DA818 800EA018 000026AD */  sw         $a2, 0x0($t1)
    /* DA81C 800EA01C 040027AD */  sw         $a3, 0x4($t1)
    /* DA820 800EA020 080028AD */  sw         $t0, 0x8($t1)
    /* DA824 800EA024 0C00668C */  lw         $a2, 0xC($v1)
    /* DA828 800EA028 1000678C */  lw         $a3, 0x10($v1)
    /* DA82C 800EA02C 0C0026AD */  sw         $a2, 0xC($t1)
    /* DA830 800EA030 100027AD */  sw         $a3, 0x10($t1)
    /* DA834 800EA034 D4348424 */  addiu      $a0, $a0, %lo(sndpsxlimits)
    /* DA838 800EA038 1000838C */  lw         $v1, 0x10($a0)
    /* DA83C 800EA03C 00E00524 */  addiu      $a1, $zero, -0x2000
    /* DA840 800EA040 24186500 */  and        $v1, $v1, $a1
    /* DA844 800EA044 0800E003 */  jr         $ra
    /* DA848 800EA048 100083AC */   sw        $v1, 0x10($a0)
  .L800EA04C:
    /* DA84C 800EA04C 0800E003 */  jr         $ra
    /* DA850 800EA050 FFFF0224 */   addiu     $v0, $zero, -0x1
endlabel SNDsetlimits
