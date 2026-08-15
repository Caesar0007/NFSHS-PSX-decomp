/* eaclib/psx/eacpsxz/shpsubs.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\shpsubs.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\SHPSUBS.ASM (per SYM SLD @0x800F0AAC line 7).
 *   THREE contiguous XDEFs: shapecount @0x800F0AAC (3), shapepointer @0x800F0AB8 (10, 0x28),
 *   shapename @0x800F0AE0 (15, 0x3C). EA "shape file" accessors -- shapepointer/shapename use the
 *   unsigned `sltu` bounds check + `swr`/`swl` unaligned name store, and a label sitting AT a `jr`
 *   delay slot, none of which the C recon reproduces (shapepointer/shapename FAILed). Transcribed
 /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
  * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
  * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
  * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
  * Gate-lane object is byte-identical (proven by hash); see
  * scratchpad/w64a20/RECEIPTS.md. */
 *   VERBATIM in ONE __asm__ block; C fallback for the host build.
 *
 *   A shape file: int count @+0x08, then 8-byte dir entries @+0x10: entry[i] = {u32 name, u32 offset}.
 *     shapecount(sf)        = *(int*)(sf+8)
 *     shapepointer(sf,i)    = (i<count) ? sf + entry[i].offset : 0
 *     shapename(sf,i,dst)   = *(u32*)dst = (i<count) ? entry[i].name : 0   (unaligned swr/swl store)
 *   maspsx: load/store offsets DECIMAL; `sltu` comma-joined; `.set noat` for the explicit $at.
 */

#if defined(__mips__)
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl shapecount\n"        /* @0x800F0AAC : int shapecount(void *sf) */
    "shapecount:\n"
    "\tlw\t$2,8($4)\n"
    "\tjr\t$31\n"
    "\t nop\n"

    "\t.globl shapepointer\n"      /* @0x800F0AB8 : void *shapepointer(void *sf, unsigned i) */
    "shapepointer:\n"
    "\tlw\t$8,8($4)\n"            /* count */
    "\tsll\t$10,$5,3\n"            /* i*8 */
    "\tsltu\t$1,$5,$8\n"         /* i < count (unsigned) */
    "\tbeqz\t$1,.L800F0AD8\n"      /* out of range -> 0 */
    "\t addu\t$10,$4,$10\n"        /* delay: sf + i*8 */
    "\tlw\t$2,20($10)\n"           /* entry[i].offset  (0x10 + i*8 + 4) */
    "\tjr\t$31\n"
    "\t addu\t$2,$4,$2\n"        /* delay: sf + offset */
    ".L800F0AD8:\n"
    "\tjr\t$31\n"
    "\t addiu\t$2,$0,0\n"       /* delay: return 0 */

    "\t.globl shapename\n"         /* @0x800F0AE0 : void shapename(void *sf, unsigned i, void *dst) */
    "shapename:\n"
    "\tlw\t$8,8($4)\n"            /* count */
    "\tsll\t$10,$5,3\n"            /* i*8 */
    "\tsltu\t$1,$5,$8\n"         /* i < count */
    "\tbeqz\t$1,.L800F0B08\n"      /* out of range */
    "\t addu\t$10,$4,$10\n"        /* delay: sf + i*8 */
    "\tlw\t$2,16($10)\n"           /* entry[i].name  (0x10 + i*8) */
    "\tnop\n"
    "\tswr\t$2,0($6)\n"           /* unaligned store name -> dst */
    "\tswl\t$2,3($6)\n"
    "\tjr\t$31\n"
    ".L800F0B08:\n"                 /* (label sits AT the jr delay slot) */
    "\t addiu\t$2,$0,0\n"       /* name = 0 */
    "\tswr\t$2,0($6)\n"
    "\tswl\t$2,3($6)\n"
    "\tjr\t$31\n"
    "\t nop\n"
    "\t.set at\n"
    "\t.set reorder\n"
);
#else
extern int shapecount(void *shapefile)   /* @0x800F0AAC */
{
    return *(int *)((char *)shapefile + 8);
}

extern void *shapepointer(void *shapefile, unsigned int index)   /* @0x800F0AB8 */
{
    char *sf = (char *)shapefile;
    if (index < (unsigned)*(int *)(sf + 8))
        return sf + *(int *)(sf + index * 8 + 0x14);
    return 0;
}

extern void shapename(void *shapefile, unsigned int index, void *dst)   /* @0x800F0AE0 */
{
    char *sf = (char *)shapefile;
    int name = (index < (unsigned)*(int *)(sf + 8)) ? *(int *)(sf + index * 8 + 0x10) : 0;
    ((char *)dst)[0] = (char)(name);
    ((char *)dst)[1] = (char)(name >> 8);
    ((char *)dst)[2] = (char)(name >> 16);
    ((char *)dst)[3] = (char)(name >> 24);
}
#endif
