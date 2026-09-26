/* tMenuCommand -- the one definition of this type, shared by 10 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TMENUCOMMAND_H
#define NFS4_SHARED_TMENUCOMMAND_H

struct tMenuCommand {
    tMenuCommandType type;
    tMenu *nextMenu;
};
#endif
