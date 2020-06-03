#include <string.h>
#include "main_biolib_emxAPI.h"
#include "main_biolib.h"

int main(int argc, char** argv) {
    // concat input parameters to a single space-separated string
    int parameters_string_len = 1;
    char *parameters = (char*) malloc(parameters_string_len);

    for(int i = 0; i < argc; i++) {
        parameters_string_len += strlen(argv[i]);
        parameters = (char*) realloc(parameters, parameters_string_len);
        strncat(parameters, argv[i], parameters_string_len);
        if (i != argc - 1) {
            parameters_string_len++;
            parameters = (char*) realloc(parameters, parameters_string_len);
            strncat(parameters, " ", parameters_string_len);
        }
    }

    // cast parameters string to MATLAB compatible string
    emxArray_char_T *parameters_emx = emxCreateWrapper_char_T(parameters, 1, strlen(parameters));

    // call custom MATLAB function
    return main_biolib(parameters_emx);
}