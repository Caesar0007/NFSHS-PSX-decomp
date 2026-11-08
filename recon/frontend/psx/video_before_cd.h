/* video.obj (via NFS4_CORE_HOOK_BEFORE_CD in nfs4_types.h): retail records windowtbl right after shapetbl, before the CD stream. */
struct windowtbl {
    long   id;
    int    x, y, width, height;
    u_char bpp, type, ram, unused;
    int    minx, miny, maxx, maxy;
    struct shapetbl *shape;
    DISPENV dispenv;
    DRAWENV drawenv;
};
