/* Player selector enum shared by frontend owners that do not retain input-key
 * records in their own SYM type graph. */
#ifndef NFS4_FRONTEND_COMMON_FE_PLAYER_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_PLAYER_TYPES_H

typedef enum tPlayer {
    kPlayerBoth = -1,
    kPlayerOne = 0,
    kPlayerTwo = 1
} tPlayer;

#endif
