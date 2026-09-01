/* NFS4-R-FR-DE CHANGED @80076E60 | base 80076420 AudioCmn_MusicLevel__Fi */
/* callers: AudioCmn_Reset__Fv, MPause_MusicLogic__Fc, MPause_MusicLogic__Fc */
s32 func_80076E60(s32 arg0) {
    if (arg0 < 0x55) {
        return (s32) (arg0 * 0x60) >> 7;
    }
    return (s32) (((arg0 * 2) - 0x54) * 0x60) >> 7;
}
