.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__22tMenuItemLeftRightFade, 0x68

glabel TransitionIsFinished__22tMenuItemLeftRightFade
    /* CBD0 8001C3D0 22008284 */  lh         $v0, 0x22($a0)
    /* CBD4 8001C3D4 00000000 */  nop
    /* CBD8 8001C3D8 10004010 */  beqz       $v0, .L8001C41C
    /* CBDC 8001C3DC 00000000 */   nop
    /* CBE0 8001C3E0 06004104 */  bgez       $v0, .L8001C3FC
    /* CBE4 8001C3E4 00000000 */   nop
    /* CBE8 8001C3E8 20008284 */  lh         $v0, 0x20($a0)
    /* CBEC 8001C3EC 00000000 */  nop
    /* CBF0 8001C3F0 0A004018 */  blez       $v0, .L8001C41C
    /* CBF4 8001C3F4 00000000 */   nop
    /* CBF8 8001C3F8 22008284 */  lh         $v0, 0x22($a0)
  .L8001C3FC:
    /* CBFC 8001C3FC 00000000 */  nop
    /* CC00 8001C400 09004018 */  blez       $v0, .L8001C428
    /* CC04 8001C404 01000224 */   addiu     $v0, $zero, 0x1
    /* CC08 8001C408 20008284 */  lh         $v0, 0x20($a0)
    /* CC0C 8001C40C 00000000 */  nop
    /* CC10 8001C410 80004228 */  slti       $v0, $v0, 0x80
    /* CC14 8001C414 03004014 */  bnez       $v0, .L8001C424
    /* CC18 8001C418 00000000 */   nop
  .L8001C41C:
    /* CC1C 8001C41C 0B710008 */  j          .L8001C42C
    /* CC20 8001C420 240080AC */   sw        $zero, 0x24($a0)
  .L8001C424:
    /* CC24 8001C424 01000224 */  addiu      $v0, $zero, 0x1
  .L8001C428:
    /* CC28 8001C428 240082AC */  sw         $v0, 0x24($a0)
  .L8001C42C:
    /* CC2C 8001C42C 2400828C */  lw         $v0, 0x24($a0)
    /* CC30 8001C430 0800E003 */  jr         $ra
    /* CC34 8001C434 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__22tMenuItemLeftRightFade
