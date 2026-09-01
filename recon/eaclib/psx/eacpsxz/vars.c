/* eaclib/psx/eacpsxz/vars.c -- data-only archive member proven by NFS4 SYM.
 *
 * The 40-symbol 0xA0-byte span is exact at 0x8013DC64..0x8013DD03: the NFS4
 * SYM top-level records, NFS4.MAP, linker placement, and retail bytes agree.
 * Declaration types are corroborated by the earlier EA EACLIB vars.asm
 * member in the NFS2 PC beta symbols, where the corresponding objects are
 * class EXT / type INT.
 */

int kanjiwidth = 0;        /* @0x8013DC64 */
int grmode = 0;            /* @0x8013DC68 */
int mouseflag = 0;         /* @0x8013DC6C */
int mx = 0;                /* @0x8013DC70 */
int my = 0;                /* @0x8013DC74 */
int mbuttons = 0;          /* @0x8013DC78 */
int mouseshown = 0;        /* @0x8013DC7C */
int mouseratio = 0;        /* @0x8013DC80 */
int numjoy = 0;            /* @0x8013DC84 */
int screenwidth = 0;       /* @0x8013DC88 */
int screenheight = 0;      /* @0x8013DC8C */
int screenbpp = 0;         /* @0x8013DC90 */
int screenvisiblex = 16;   /* @0x8013DC94 */
int screenvisibley = 16;   /* @0x8013DC98 */
int screenvisiblew = 288;  /* @0x8013DC9C */
int screenvisibleh = 208;  /* @0x8013DCA0 */
int zclipvalue = 10;       /* @0x8013DCA4 */
int zclipflag = 0;         /* @0x8013DCA8 */
int ticks = 0;             /* @0x8013DCAC */
int libticks = 0;          /* @0x8013DCB0 */
int vblflag = 0;           /* @0x8013DCB4 */
int pageflipflag = 0;      /* @0x8013DCB8 */
int vblticks = 0;          /* @0x8013DCBC */
int debugexit = 0;         /* @0x8013DCC0 */
int timerhz = 0;           /* @0x8013DCC4 */
int mb_default = 0;        /* @0x8013DCC8 */
int loadfilesize = 0;      /* @0x8013DCCC */
int sendtoprintmem = 0;    /* @0x8013DCD0 */
int abortflag = 0;         /* @0x8013DCD4 */
int cenxpix = 160;         /* @0x8013DCD8 */
int cenypix = 100;         /* @0x8013DCDC */
int originx = 0;           /* @0x8013DCE0 */
int originy = 0;           /* @0x8013DCE4 */
int centerx = 160;         /* @0x8013DCE8 */
int centery = 100;         /* @0x8013DCEC */
int xscale = 0;            /* @0x8013DCF0 */
int yscale = 0;            /* @0x8013DCF4 */
int xbangle = 0;           /* @0x8013DCF8 */
int ybangle = 0;           /* @0x8013DCFC */
int aspectratio = 0x10000; /* @0x8013DD00 */
