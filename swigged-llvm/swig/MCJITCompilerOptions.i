%define REF_MCJIT_CLASS(TYPE, CSTYPE)
%typemap(cstype) TYPE "$csclassname"

   // Replacement in LLVM.cs, in function declaration.
   %typemap(cstype, out="$csclassname") TYPE* "$csclassname"

   // Replacement in LLVM.cs, in function call. In this case, the
   // function value has already been set by constructor of the class.
   %typemap(csin) TYPE* "$csinput.Value"

   
   %typemap(csin) TYPE "$csinput.Value"
   %typemap(imtype) TYPE "System.IntPtr"
   %typemap(imtype, out="System.IntPtr") TYPE* "System.IntPtr"
   %typemap(csinterfaces) TYPE "System.IEquatable<$csclassname>"
   %typemap(csclassmodifiers) TYPE "public partial class"
   %typemap(csout, excode=SWIGEXCODE) TYPE {
    $&csclassname ret = new $&csclassname($imcall);$excode
                return ret;
}

   /* Properties */
%typemap(csvarin, excode=SWIGEXCODE2) SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*) %{
    set {
        // a Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        $imcall;$excode
    } %}

%typemap(csvarin, excode=SWIGEXCODE2) TYPE, TYPE *, TYPE &, TYPE &&, TYPE [], TYPE (CLASS::*) %{
    set {
        // b Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        $imcall;$excode
    } %}

%typemap(csvarin, excode=SWIGEXCODE2) char *, char *&, char[ANY], char[] %{
    set {
        // c Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        $imcall;$excode
    } %}


%typemap(csvarout, excode=SWIGEXCODE2) SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*),
const SWIGTYPE, const SWIGTYPE *, const SWIGTYPE &, const SWIGTYPE &&, const SWIGTYPE [], const SWIGTYPE (CLASS::*)
%{
	get {
	// Unfortunately, Swig hardwires the value of the
	// string $imcall. So, create necessary crap to get it
	// to work.
		System.IntPtr swigCPtr = Value;
		bool ret = $imcall;$excode
			   return ret;
	} %}

%typemap(csvarout, excode=SWIGEXCODE2) CodeModel, LLVMCodeModel
%{
	get {
	// Unfortunately, Swig hardwires the value of the
	// string $imcall. So, create necessary crap to get it
	// to work.
		System.IntPtr swigCPtr = Value;
		CodeModel ret = (CodeModel) $imcall;$excode
		return ret;
	} %}


%typemap(csvarout, excode=SWIGEXCODE2) bool,               const bool &               %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        bool ret = $imcall;$excode
               return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) char,               const char &               %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        char ret = $imcall;$excode
               return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) signed char,        const signed char &        %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        sbyte ret = $imcall;$excode
                return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) unsigned char,      const unsigned char &      %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        byte ret = $imcall;$excode
               return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) short,              const short &              %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        short ret = $imcall;$excode
                return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) unsigned short,     const unsigned short &     %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        ushort ret = $imcall;$excode
                 return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) int,                const int &                %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        int ret = $imcall;$excode
              return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) unsigned int,       const unsigned int &       %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        uint ret = $imcall;$excode
               return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) long,               const long &               %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        int ret = $imcall;$excode
              return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) unsigned long,      const unsigned long &      %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        uint ret = $imcall;$excode
               return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) long long,          const long long &          %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        long ret = $imcall;$excode
               return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) unsigned long long, const unsigned long long & %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        ulong ret = $imcall;$excode
                return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) float,              const float &              %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        float ret = $imcall;$excode
                return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) double,             const double &             %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        double ret = $imcall;$excode
                 return ret;
    } %}


%typemap(csvarout, excode=SWIGEXCODE2) char *, char *&, char[ANY], char[] %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        string ret = $imcall;$excode
                 return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) void %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) SWIGTYPE %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        $&csclassname ret = new $&csclassname($imcall, true);
        $excode
        return ret;
    } %}

%typemap(csvarout, excode=SWIGEXCODE2) SWIGTYPE & %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        $csclassname ret = new $csclassname($imcall, $owner);$excode
                   return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) SWIGTYPE && %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        $csclassname ret = new $csclassname($imcall, $owner);$excode
                   return ret;
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) SWIGTYPE *, SWIGTYPE [] %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        global::System.IntPtr cPtr = $imcall;
        return new $csclassname(cPtr);
        $excode
    } %}

%typemap(csvarout, excode=SWIGEXCODE2) SWIGTYPE (CLASS::*) %{
    get {
        // Unfortunately, Swig hardwires the value of the
        // string $imcall. So, create necessary crap to get it
        // to work.
        System.IntPtr swigCPtr = Value;
        var cPtr = $imcall;
        return new $csclassname(cPtr);
        $excode
    } %}





%typemap(csbody) TYPE %{
    public System.IntPtr Value;

    public $csclassname()
    {
        System.IntPtr pointer = System.Runtime.InteropServices.Marshal.AllocHGlobal(1024);
        Value = pointer;
    }

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

   // The following typedef has the effect of nuking all fields from
   // the generated type. Comment out if you want the C-fields to be
   // tranlated over into C# code.
   // typedef struct TYPE { } TYPE;

%enddef

REF_MCJIT_CLASS(LLVMMCJITCompilerOptions, MCJITCompilerOptions)
