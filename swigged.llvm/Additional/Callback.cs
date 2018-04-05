using System;
using System.Runtime.InteropServices;

namespace Swigged.LLVM {

public delegate ulong cppLLVMOrcSymbolResolverFn([MarshalAs(UnmanagedType.LPWStr)] string name, IntPtr lookupCtx);
public delegate ulong cppLLVMOrcLazyCompileCallbackFn(OrcJITStackRef r, IntPtr callbackCtx);
    
}
