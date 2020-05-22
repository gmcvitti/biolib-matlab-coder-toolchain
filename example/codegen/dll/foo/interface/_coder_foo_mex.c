/*
 * _coder_foo_mex.c
 *
 * Code generation for function '_coder_foo_mex'
 *
 */

/* Include files */
#include "_coder_foo_mex.h"
#include "_coder_foo_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void foo_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T
  nrhs, const mxArray *prhs[1]);

/* Function Definitions */
void foo_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs, const mxArray
                     *prhs[1])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 1, 4, 3,
                        "foo");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 3,
                        "foo");
  }

  /* Call the function. */
  foo_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&foo_atexit);

  /* Module initialization. */
  foo_initialize();

  /* Dispatch the entry-point. */
  foo_mexFunction(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  foo_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_foo_mex.c) */
