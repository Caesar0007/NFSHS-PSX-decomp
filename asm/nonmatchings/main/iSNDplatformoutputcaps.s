.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformoutputcaps, 0x58

glabel iSNDplatformoutputcaps
    /* EFDA8 800FF5A8 1480033C */  lui        $v1, %hi(sndgs)
    /* EFDAC 800FF5AC 60786224 */  addiu      $v0, $v1, %lo(sndgs)
    /* EFDB0 800FF5B0 18000524 */  addiu      $a1, $zero, 0x18
    /* EFDB4 800FF5B4 44AC0434 */  ori        $a0, $zero, 0xAC44
    /* EFDB8 800FF5B8 070040A0 */  sb         $zero, 0x7($v0)
    /* EFDBC 800FF5BC 080040A0 */  sb         $zero, 0x8($v0)
    /* EFDC0 800FF5C0 090040A0 */  sb         $zero, 0x9($v0)
    /* EFDC4 800FF5C4 060045A0 */  sb         $a1, 0x6($v0)
    /* EFDC8 800FF5C8 607864A4 */  sh         $a0, %lo(sndgs)($v1)
    /* EFDCC 800FF5CC 01000324 */  addiu      $v1, $zero, 0x1
    /* EFDD0 800FF5D0 040043A0 */  sb         $v1, 0x4($v0)
    /* EFDD4 800FF5D4 02000324 */  addiu      $v1, $zero, 0x2
    /* EFDD8 800FF5D8 020044A4 */  sh         $a0, 0x2($v0)
    /* EFDDC 800FF5DC 050043A0 */  sb         $v1, 0x5($v0)
    /* EFDE0 800FF5E0 130040A0 */  sb         $zero, 0x13($v0)
    /* EFDE4 800FF5E4 140040A0 */  sb         $zero, 0x14($v0)
    /* EFDE8 800FF5E8 120040A0 */  sb         $zero, 0x12($v0)
    /* EFDEC 800FF5EC 110045A0 */  sb         $a1, 0x11($v0)
    /* EFDF0 800FF5F0 0E0044A4 */  sh         $a0, 0xE($v0)
    /* EFDF4 800FF5F4 100043A0 */  sb         $v1, 0x10($v0)
    /* EFDF8 800FF5F8 0800E003 */  jr         $ra
    /* EFDFC 800FF5FC 21100000 */   addu      $v0, $zero, $zero
endlabel iSNDplatformoutputcaps
