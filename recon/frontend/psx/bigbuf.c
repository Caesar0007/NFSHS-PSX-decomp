/* frontend/psx/bigbuf.c -- RECONSTRUCTED.  obj bigbuf.obj: the FIRST module of the retail link (SYM FILE record 0).
 *   A zero-filled SPACE RESERVATION in the main binary for the front.bin overlay: the `text` group's .rdata starts at
 *   0x80010000 with this block, and the `front` group (front.rdata / front.text / front.data / front.bss, 0x44548 bytes)
 *   is linked `over(text)` at the same origin -- at run time nfs3.cpp loads front.bin AT bigBuf, and in the retail EXE the
 *   overlay image already lies over the first 0x44548 bytes.  Size: address.obj, the next module, starts at 0x80054D90,
 *   so the block is 0x44D90 = 282000 bytes exactly; the 2120 bytes past the overlay's end are the unused tail and are
 *   zero in the image.  No function, no debug record: the original is an assembler file like its neighbour ADDRESS.ASM.
 *   The other TUs see it as `extern char bigBuf[]` (a scratch / load buffer once the front end is gone). */
const char bigBuf[282000] = { 0 };   /* @0x80010000 (.rdata) */
