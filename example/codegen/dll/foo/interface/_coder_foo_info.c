/*
 * _coder_foo_info.c
 *
 * Code generation for function '_coder_foo_info'
 *
 */

/* Include files */
#include "_coder_foo_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *emlrtMexFcnResolvedFunctionsInfo(void);

/* Function Definitions */
static const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[9] = {
    "789ced59cf4fd360182e88c4c42098180fc644134f86b02ec88fcd1bec8705b731d9c64f8d7c6d3fb666dfd7afb4dd185edcd14413fd0b3cebcda307133d1ac3"
    "0d4dbc7bf05fe0e0c175ed07dddcd2416781b23759cacbb3f679bfe76d9fafbc307d73c93e8661ae30662863e671a8f649f533cc88f5fb7ea6319af13eeb78a9",
    "29a771911960f69f9be751dc38ffb5950b44d66145371319607870a648b0240359cfee289051a14650198a75645342302b6198b1272923c3711b74901890f173"
    "a4008562a68419b5a01d5688ecc9811eef6ceb35eaa7eb1d68a1871da7eb8fd97203a73162e5145f8f3d89dc67731a5435368f85b2c446a156d489c2f2124112",
    "3f86818e003f261011aa633a214828004966610560054176939000b6ea3674dd7059f7802d6facdbeca3b6a5ea54a76ef00db6e51bace72229f1081ef2b9ed0b"
    "d796cfcc29be3e9758a9b726ad92bc0af06de306d2d8e44c363133cb2e8e07c7838035dac1930a0b31626bbd62cd5eb1106d9664d6502a809d741aeeb06efbd1",
    "5ef750edc933f2c0afeff5af78c5c75cb8a579ca67c549f155da5cafd3fbee7a1b3e7adf513c3c9f8a86392eba3a3fb1945b8e8612a1ed897cfcb08eb4038f53"
    "1d8c2d6fb5ceff7dfdb3fafc565dd67dd3a16e8ad77d3e20d53645550628206951826b7e1f5355a2da75545cd6336ccb5bd543f19a12822e11f96901c862cd88",
    "29ff4797fc39077e8a1fb98fc667b4ae223b4a65641b64ec68bf3cb3befcfe93e2299f157ef7e574504e63902b2f832c4c4e8617cadb0b538907fef165bf3fcf"
    "9daec3fe774ce33accfb4fd23405a81a3ca9f7df0f2ef9526df9cc9ce26ef64f43216307a55a190df2ca1f76bf79ecb770f7a7a77c56f8dd6fb72264313dc507",
    "17435c72510c1696a64b281bedf9ed69f3db172ed771c7611d146f7a2f0665228933aa0a76e208e83a942539dfa0efc631eb6a8e7675d1a07c5f5ceaf0d8818f"
    "e2dde9672bf9ea6df5cc575e5dddf3d6a7abbfff78ca6785df7dfad93c772f925356f0237e419c59d9e49215bcc0f9c7a7cfebbce28643dd146ff2654d0008a8",
    "013a253e393f76bbbf661df828de1d3f1e3575b37ad8896eddf28dd4db1f9efa70f5f2e76b5ef2d1f0bb0fcf3e5c9a0be9ba02c3021e2f8672d3f9109789f57c"
    "f8a47df88dcbbaef3ad44df1e6f76345413b99baa9c4ad09ee9c9c4640a0ff5f3d2d73e4af2ef979077e8a77e9bdb9adaca66b7be7332ff73c9e7394b87d4ff9",
    "acf0bb6f4f15278bcb991551e6d15a789e686babe959c94773e5f3f67cf7e6cc66f4e6ccdde5ebcd99cde8cd998f767dbffa6fd5e5ba4ecb7ce3b8fedc9b6ffc"
    "7beccd37fcebd37e9d6ffc058d9e01b9", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 11656U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * epFieldName[6] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs", "FullPath", "TimeStamp" };

  mxArray *xInputs;
  const char * propFieldName[4] = { "Version", "ResolvedFunctions",
    "EntryPoints", "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 6, epFieldName);
  xInputs = emlrtCreateLogicalMatrix(1, 1);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("foo"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath", emlrtMxCreateString(
    "C:\\Users\\gmcvi\\Desktop\\biolib-matlab-coder-toolchain\\example\\foo.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp", emlrtMxCreateDoubleScalar
                (737933.3201967593));
  xResult = emlrtCreateStructMatrix(1, 1, 4, propFieldName);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.8.0.1359463 (R2020a) Update 1"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

/* End of code generation (_coder_foo_info.c) */
