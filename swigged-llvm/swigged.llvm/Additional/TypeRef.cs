namespace Swigged.LLVM
{
    public partial struct TypeRef
    {
        //public static readonly TypeRef Empty = new TypeRef();

        public override string ToString()
        {
            string v = LLVM.PrintTypeToString(this);
            v = v.Substring(0);
            return v;
        }
    }

    //public partial class MCJITCompilerOptions : global::System.IDisposable
    //{
    //    public void Dispose()
    //    {
    //    }
    //}
}
