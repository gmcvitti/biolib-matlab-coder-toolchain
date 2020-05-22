/*
 * _coder_foo_api.h
 *
 * Code generation for function '_coder_foo_api'
 *
 */

#ifndef _CODER_FOO_API_H
#define _CODER_FOO_API_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern real_T foo(real_T in);
  extern void foo_api(const mxArray * const prhs[1], int32_T nlhs, const mxArray
                      *plhs[1]);
  extern void foo_atexit(void);
  extern void foo_initialize(void);
  extern void foo_terminate(void);
  extern void foo_xil_shutdown(void);
  extern void foo_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (_coder_foo_api.h) */
