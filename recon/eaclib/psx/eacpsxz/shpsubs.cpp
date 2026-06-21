/* eaclib/psx/eacpsxz/shpsubs.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\shpsubs.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   3 fns: shapecount@0x800F0AAC, shapepointer@0x800F0AB8, shapename@0x800F0AE0.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  C-linkage.  EA "shape file" accessors.
 *
 *   A shape file (EA .SHP archive, loaded in RAM) has an 8-byte header word, an int count at +0x08,
 *   then a directory of 8-byte entries starting at +0x10: entry[i] = { u32 name @+0, u32 dataoffset
 *   @+4 } at base + 0x10 + i*8.  `name` is a packed 4-char tag; `dataoffset` is relative to the file
 *   base.  shapepointer/shapename bounds-check the (unsigned) index against the count.
 */
extern "C" int   shapecount  (void *shapefile);                       /* @0x800F0AAC */
extern "C" void *shapepointer(void *shapefile, unsigned int index);   /* @0x800F0AB8 */
extern "C" void  shapename   (void *shapefile, unsigned int index, void *dst);  /* @0x800F0AE0 */

/* shapecount @0x800F0AAC : number of shapes in the file (header +0x08). */
extern "C" int shapecount(void *shapefile)
{
    return *(int *)((char *)shapefile + 8);
}

/* shapepointer @0x800F0AB8 : base + entry[index].dataoffset, or 0 if index out of range. */
extern "C" void *shapepointer(void *shapefile, unsigned int index)
{
    char *sf = (char *)shapefile;
    int   count = *(int *)(sf + 8);
    if ((int)index < count)
        return sf + *(int *)(sf + index * 8 + 0x14);   /* entry[index].dataoffset (0x10+i*8+4) */
    return 0;
}

/* shapename @0x800F0AE0 : copy entry[index].name (4 bytes) to dst (0 if out of range). */
extern "C" void shapename(void *shapefile, unsigned int index, void *dst)
{
    char *sf = (char *)shapefile;
    int   count = *(int *)(sf + 8);
    int   name  = ((int)index < count) ? *(int *)(sf + index * 8 + 0x10) : 0;
    /* asm uses swr/swl -> unaligned 4-byte store; copy byte-wise to stay alignment-safe */
    ((char *)dst)[0] = (char)(name);
    ((char *)dst)[1] = (char)(name >> 8);
    ((char *)dst)[2] = (char)(name >> 16);
    ((char *)dst)[3] = (char)(name >> 24);
}
