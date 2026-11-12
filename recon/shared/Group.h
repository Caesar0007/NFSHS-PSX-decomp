/* Group -- GROUP.H element-array header, one definition for every includer (header-truth 4n). */
#ifndef NFS4_SHARED_GROUP_H
#define NFS4_SHARED_GROUP_H
struct Group {
    int m_num_elements;
    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
    inline void SetNumElements(int numElements) { m_num_elements = numElements; }   /* object.cpp / draww.cpp call it */
};
#endif
