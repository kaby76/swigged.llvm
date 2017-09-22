using System;
namespace Swigged.LLVM
{
    public partial struct ValueRef
    {
        //public static readonly ValueRef Empty = new ValueRef();

        public override string ToString()
        {
            string v = LLVM.PrintValueToString(this);
            v = v.Substring(0);
            return v;
        }
    }
}