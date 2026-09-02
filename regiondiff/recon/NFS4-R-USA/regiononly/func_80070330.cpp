/* NFS4-R-USA REGION-ONLY @80070330 */
extern "C" unsigned char RDAT_8010EA70[]; /* [INFERRED] identity TBD */
extern "C" int RDAT_8010F0B0[];          /* [INFERRED] identity TBD */

extern "C" void func_80070330(void *stateToFree)
{
    int *used;
    int i;
    int state;

    i = 0;
    used = RDAT_8010F0B0;
    state = (int)RDAT_8010EA70;
loop:
    i++;
    if ((int)stateToFree == state) {
        *used = 0;
        return;
    }
    used++;
    state += 0xA0;
    if (i < 10)
        goto loop;
}
