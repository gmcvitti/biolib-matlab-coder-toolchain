#include <string.h>
#include "main_biolib_emxAPI.h"
#include "main_biolib.h"

int main(int argc, char** argv) {
    emxArray_char_T *arg1 = emxCreateWrapper_char_T(argv[1], 1, strlen(argv[1]));
    emxArray_char_T *arg2 = emxCreateWrapper_char_T(argv[2], 1, strlen(argv[2]));
    emxArray_char_T *arg3 = emxCreateWrapper_char_T(argv[3], 1, strlen(argv[3]));
    emxArray_char_T *arg4 = emxCreateWrapper_char_T(argv[4], 1, strlen(argv[4]));
    return main_biolib(argc, arg1, arg2, arg3, arg4);
}