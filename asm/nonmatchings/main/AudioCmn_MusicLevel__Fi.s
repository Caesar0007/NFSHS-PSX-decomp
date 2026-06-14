.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_MusicLevel__Fi, 0x60

glabel AudioCmn_MusicLevel__Fi
    /* 66C20 80076420 56008228 */  slti       $v0, $a0, 0x56
    /* 66C24 80076424 08004010 */  beqz       $v0, .L80076448
    /* 66C28 80076428 00000000 */   nop
    /* 66C2C 8007642C C0100400 */  sll        $v0, $a0, 3
    /* 66C30 80076430 21104400 */  addu       $v0, $v0, $a0
    /* 66C34 80076434 80100200 */  sll        $v0, $v0, 2
    /* 66C38 80076438 23104400 */  subu       $v0, $v0, $a0
    /* 66C3C 8007643C 40100200 */  sll        $v0, $v0, 1
    /* 66C40 80076440 0800E003 */  jr         $ra
    /* 66C44 80076444 C3110200 */   sra       $v0, $v0, 7
  .L80076448:
    /* 66C48 80076448 ABFF8224 */  addiu      $v0, $a0, -0x55
    /* 66C4C 8007644C C0180200 */  sll        $v1, $v0, 3
    /* 66C50 80076450 23186200 */  subu       $v1, $v1, $v0
    /* 66C54 80076454 C2170300 */  srl        $v0, $v1, 31
    /* 66C58 80076458 21186200 */  addu       $v1, $v1, $v0
    /* 66C5C 8007645C 43180300 */  sra        $v1, $v1, 1
    /* 66C60 80076460 55006324 */  addiu      $v1, $v1, 0x55
    /* 66C64 80076464 C0100300 */  sll        $v0, $v1, 3
    /* 66C68 80076468 21104300 */  addu       $v0, $v0, $v1
    /* 66C6C 8007646C 80100200 */  sll        $v0, $v0, 2
    /* 66C70 80076470 23104300 */  subu       $v0, $v0, $v1
    /* 66C74 80076474 40100200 */  sll        $v0, $v0, 1
    /* 66C78 80076478 0800E003 */  jr         $ra
    /* 66C7C 8007647C C3110200 */   sra       $v0, $v0, 7
endlabel AudioCmn_MusicLevel__Fi
