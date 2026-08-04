extern int CD_debug;
int CdSetDebug(int level){ int prev = CD_debug; CD_debug = level; return prev; }
