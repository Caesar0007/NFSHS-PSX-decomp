	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\savegp.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
	       .set noreorder
       .set noat
       .globl initgp
initgp:
       lui     $1, %hi(g_bootGP)
       sw      $28, %lo(g_bootGP)($1)
       jr      $31
        nop
       .globl savegp
savegp:
       sw      $28, 0($4)
       lui     $28, 32786
       lw      $28, 13544($28)
       jr      $31
        nop
       .globl restoregp
restoregp:
       jr      $31
        or     $28, $0, $4
       .set at
       .set reorder


	.text
