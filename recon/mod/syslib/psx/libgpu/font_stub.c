/* NFS4 never opens or loads a PsyQ debug-font stream.  Movie calls FntFlush(-1), but without any
 * FntOpen call there is nothing to flush.  This ABI-compatible no-op replaces FONT.OBJ and its
 * 17 KiB BSS / 2.9 KiB initialized storage. */

unsigned long *FntFlush(int id)
{
    (void)id;
    return 0;
}

