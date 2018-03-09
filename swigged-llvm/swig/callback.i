// From http://swig.10945.n7.nabble.com/C-pointer-to-method-as-parameter-to-C-td8118.html
//////////////////////////////////////////////////////////////////////// 
/// 
// cs_callback is used to marshall callbacks. It allows a C# function to 
// be passed to C++ as a function pointer through P/Invoke, which has the 
// ability to make unmanaged-to-managed thunks. It does NOT allow you to 
// pass C++ function pointers to C#. 
// 
// Anyway, to use this macro you need to declare the function pointer type 
// TYPE in the appropriate header file (including the calling convention), 
// declare a delegate named after CSTYPE in your C# project, and use this 
// macro in your .i file. Here is an example: 
// 
// in C++ header file (%include this header in your .i file): 
// typedef void (__stdcall *Callback)(PCWSTR); 
// void Foo(Callback c); 
// 
// in C# code: 
// public delegate void CppCallback([MarshalAs(UnmanagedType.LPWStr)] string message); 
// 
// in your .i file: 
// %cs_callback(Callback, CppCallback) 
// 
%define %cs_callback(TYPE, CSTYPE) 
   %typemap(ctype) TYPE, TYPE& "void*" 
   %typemap(in) TYPE  %{ $1 = (TYPE)$input; %} 
   %typemap(in) TYPE& %{ $1 = (TYPE*)&$input; %} 
   %typemap(imtype, out="IntPtr") TYPE, TYPE& "CSTYPE" 
   %typemap(cstype, out="IntPtr") TYPE, TYPE& "CSTYPE" 
   %typemap(csin) TYPE, TYPE& "$csinput" 
%enddef 

