%define REF_ARRAY(TYPE, CSTYPE)
    // Arrays (ptr)
    %typemap(csin, pre="    fixed (CSTYPE* swig_ptrTo_$csinput = $csinput)")
                     (TYPE *ARRAY) "(System.IntPtr)swig_ptrTo_$csinput"
    %typemap(cstype) (TYPE *ARRAY) "CSTYPE[]"
    %typemap(imtype) (TYPE *ARRAY) "System.IntPtr"

    // Arrays (ptr + count)
    %typemap(in) (TYPE *ARRAY, unsigned ARRAYSIZE) "$1 = (TYPE*)$1_data; $2 = $input;"
    %typemap(ctype) (TYPE *ARRAY, unsigned ARRAYSIZE) "void* $1_data, unsigned int"
    %typemap(csin, pre="    fixed (CSTYPE* swig_ptrTo_$csinput = $csinput)")
                     (TYPE *ARRAY, unsigned ARRAYSIZE) "(System.IntPtr)swig_ptrTo_$csinput, (uint)$csinput.Length"
    %typemap(imtype) (TYPE *ARRAY, unsigned ARRAYSIZE) "System.IntPtr $1_data, uint"
    %typemap(cstype) (TYPE *ARRAY, unsigned ARRAYSIZE) "CSTYPE[]"

    // Arrays (count + const array)
    %typemap(in) (unsigned ARRAYSIZE, const TYPE ARRAY[]) "$1 = $1_count; $2 = (TYPE*)$input;"
    %typemap(ctype) (unsigned ARRAYSIZE, const TYPE ARRAY[]) "unsigned int $1_count, void*"
    %typemap(csin, pre="    fixed (CSTYPE* swig_ptrTo_$csinput = $csinput)")
                     (unsigned ARRAYSIZE, const TYPE ARRAY[]) "(uint)$csinput.Length, (System.IntPtr)swig_ptrTo_$csinput"
    %typemap(imtype) (unsigned ARRAYSIZE, const TYPE ARRAY[]) "uint $1_count, System.IntPtr"
    %typemap(cstype) (unsigned ARRAYSIZE, const TYPE ARRAY[]) "CSTYPE[]"
%enddef

%define REF_CLASS(TYPE, CSTYPE)
    %typemap(cstype) TYPE "$csclassname"
    %typemap(cstype, out="$csclassname") TYPE* "out $csclassname"
    %typemap(csin) TYPE* "out $csinput.Value"
    %typemap(csin) TYPE "$csinput.Value"
    %typemap(imtype) TYPE "System.IntPtr"
    %typemap(imtype, out="System.IntPtr") TYPE* "out System.IntPtr"
    %typemap(csinterfaces) TYPE "System.IEquatable<$csclassname>"
    %typemap(csclassmodifiers) TYPE "public partial struct"
    %typemap(csout, excode=SWIGEXCODE) TYPE {
        $&csclassname ret = new $&csclassname($imcall);$excode
        return ret;
    }
    %typemap(csbody) TYPE %{
        public $csclassname(global::System.IntPtr cPtr)
        {
            Value = cPtr;
        }

        public System.IntPtr Value;

        public bool Equals($csclassname other)
        {
            return Value.Equals(other.Value);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            return obj is $csclassname && Equals(($csclassname)obj);
        }

        public override int GetHashCode()
        {
            return Value.GetHashCode();
        }

        public static bool operator ==($csclassname left, $csclassname right)
        {
            return left.Equals(right);
        }

        public static bool operator !=($csclassname left, $csclassname right)
        {
            return !left.Equals(right);
        }
    %}

    %typemap(csdestruct) SWIGTYPE ;
    %typemap(csfinalize) SWIGTYPE ;

    REF_ARRAY(TYPE, CSTYPE)

    typedef struct TYPE { } TYPE;
%enddef

%define REF_CLASS_SPECIAL(TYPE, CSTYPE)
   %typemap(cstype) TYPE "$csclassname"
   %typemap(cstype, out="$csclassname") TYPE* "$csclassname"
   %typemap(csclassmodifiers) TYPE "public partial class"
   //%typemap(csin) TYPE* "out $csinput.Value"
   //%typemap(csin) TYPE "$csinput.Value"
   //%typemap(imtype) TYPE "System.IntPtr"
   //%typemap(imtype, out="System.IntPtr") TYPE* "out System.IntPtr"
   REF_ARRAY(TYPE, CSTYPE)
//   typedef struct TYPE { } TYPE;
%enddef
   
%nodefault;
%typemap(out) SWIGTYPE %{ $result = $1; %}
%typemap(in) SWIGTYPE %{ $1 = ($1_ltype)$input; %}

%typemap(cstype) char** "MyString"
%typemap(csin) char** "out $csinput.Value"
%typemap(imtype) char** "out System.IntPtr"
%typemap(in) char** {
    // Used in generating wrap.cpp:
    // Converts input parameter of target type to C.
    $1 = (char**)$input;
}
//%typemap(argout) char**
//%{ 
//  if (*$1 != NULL) *$1 = SWIG_csharp_string_callback(*$1);
//%}
//


%typemap(cstype) size_t* arg1 "out System.IntPtr"
// Output garbage to catch cases not handled.
%typemap(imtype) size_t* "out System.IntPtr"
%typemap(cstype) size_t* "out System.IntPtr"
%typemap(csin) size_t* "out $csinput"

%typemap(cstype) uint64_t* arg1 "out System.IntPtr"
// Output garbage to catch cases not handled.
%typemap(imtype) uint64_t* "out System.IntPtr"
%typemap(cstype) uint64_t* "out System.IntPtr"
%typemap(csin) uint64_t* "out $csinput"

%typemap(cstype) int64_t* arg1 "System.Int64[]"
%typemap(imtype) int64_t* "System.Int64[]"
%typemap(cstype) int64_t* "System.Int64[]"
%typemap(csin) int64_t* "$csinput"

%typemap(cstype) uint32_t*  "out uint"

%typemap(cstype) unsigned * Length "out uint"
// Output garbage to catch cases not handled.
%typemap(cstype) unsigned * "outasdf uint"
%typemap(imtype) unsigned * "out uint"
%typemap(csin) unsigned * "out $csinput"

%typemap(cstype) unsigned "uint"
%typemap(csin) unsigned "$csinput"
%typemap(imtype) unsigned "uint"

%typemap(ctype)  void * "void *"
%typemap(imtype) void * "System.IntPtr"
%typemap(cstype) void * "System.IntPtr"
%typemap(csin)   void * "$csinput"
%typemap(in)     void * %{ $1 = $input; %}
%typemap(out)    void * %{ $result = $1; %}
%typemap(csout)  void * { return $imcall; }

%typemap(cstype) LLVMMetadataRef * ParameterTypes "MetadataRef[]"
%typemap(csin, pre="    fixed (MetadataRef * swig_ptrTo_$csinput = $csinput)")
   LLVMMetadataRef * ParameterTypes "(System.IntPtr)swig_ptrTo_$csinput"
%typemap(imtype) LLVMMetadataRef * ParameterTypes "System.IntPtr"
