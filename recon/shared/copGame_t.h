/* copGame_t -- shared complete-type alias supplied by retail SYM.
   Field layout is unchanged; complete header/type-copy order remains under review. */
#ifndef NFS4_SHARED_COPGAME_T_H
#define NFS4_SHARED_COPGAME_T_H

typedef struct copGame_t {
    int numLevels;
    copLevel_t *levels;
} copGame_t;
#endif
