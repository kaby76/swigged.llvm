namespace Swigged.LLVM
{
    public partial struct TypeRef
    {
        //public static readonly TypeRef Empty = new TypeRef();

        public override string ToString()
        {
            return "unimplemented"; //return LLVM.PrintTypeToString(this);
        }
    }

    public partial struct MCJITCompilerOptions : global::System.IDisposable
    {
        public void Dispose()
        {
        }
    }
}
