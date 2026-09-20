/* frontend/common/fescreen_virtuals.inc -- tScreen's VIRTUALS, in retail slot order (real virtuals since 2026-09-20).
 * A member-declaration fragment: every owner-surface copy of `struct tScreen` includes it where the hand-written
 * `_vf` member used to be (the vptr follows the data members), so all copies agree on the vtable layout while keeping
 * their own non-virtual member sets.  The three types the signatures name come from
 * fescreen_virtual_types.h, included before every copy. */
    virtual void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    virtual void DrawBackground();
    virtual void DrawForeground();
    virtual ~tScreen();
    virtual void PreLoad();
    virtual void Initialize();
    virtual void Cleanup();
    virtual bool TransitionIsFinished();
    virtual void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);
