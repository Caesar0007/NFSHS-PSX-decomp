/* frontend/common/fescreen.h -- retail FRONTEND\COMMON\FESCREEN.H: the one definition of class tScreen.  The SYM's
 * SLD records put DrawBackground/DrawForeground at lines 96/97 of that header, and every object that names
 * the class records the same layout (size 100).  The surface that includes this header provides the types
 * the declarations name (tShapeInformation, tTexture_ShapeInfo, tMenu, tPlayer, tInputKeyType,
 * tMenuCommand); tScreen_TransitionType is the class's own enum and lives here, as in retail. */
#ifndef NFS4_FRONTEND_COMMON_FESCREEN_H
#define NFS4_FRONTEND_COMMON_FESCREEN_H

typedef enum tScreen_TransitionType {
    kScreen_TransitionTypeItem = 0,
    kScreen_TransitionTypeMenu = 1,
    kScreen_TransitionTypeScreen = 2
} tScreen_TransitionType;

struct tScreen {
    static int fSuppressLoadingText;   /* retail FEScreen.obj .data @0x800517c8 (SYM `_7tScreen.fSuppressLoadingText`) */
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
    /* the virtuals, in retail vtable slot order */
    virtual void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);
    virtual void DrawBackground();
    virtual void DrawForeground();
    virtual ~tScreen();
    virtual void PreLoad();
    virtual void Initialize();
    virtual void Cleanup();
    virtual bool TransitionIsFinished();
    virtual void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);

    tScreen();
    static void DisplayLoadingText();
    static void GoNonInterlaced();
    void DrawBackgroundImage(int startShape, int numShapes,
                             tTexture_ShapeInfo *shapes, int flip_axis);
    void AsyncLoadPermanentShapeFile(char *fileName);
    void AsyncLoadSwapShapeFile(char *fileName);
    bool IsShapeFileLoaded(tShapeInformation &shapes);
    void UploadPermanentShapes(int numPermanentShapes);
    void UploadSwapShapes(int numSwapShapes);
    void Draw(bool drawBackground);
    void AsyncLoadShapeFile(char *name, tShapeInformation &data);
    void CancelAsyncLoad(tShapeInformation &data);
    void InitializeShapes(tShapeInformation &data, unsigned int numShapes);
    void FreeShapes(tShapeInformation &data);
    void UploadShapes(tShapeInformation &data, short x, short y,
                      short numShapes, short index);
    void TransitionOff(tScreen_TransitionType type, tMenu *); /* Original unused name unknown. */
    void TransitionOn(tScreen_TransitionType type, tMenu *); /* Original unused name unknown. */
    void UpdateTransition();
};
#endif
