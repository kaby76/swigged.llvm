//------------------------------------------------------------------------------
// <auto-generated />
//
// This file was automatically generated by SWIG (http://www.swig.org).
// Version 3.0.12
//
// Do not make changes to this file unless you know what you are doing--modify
// the SWIG interface file instead.
//------------------------------------------------------------------------------

namespace Swigged.LLVM {

public partial struct JITEventListenerRef : System.IEquatable<JITEventListenerRef> {
        public JITEventListenerRef(global::System.IntPtr cPtr)
        {
            Value = cPtr;
        }

        public System.IntPtr Value;

        public bool Equals(JITEventListenerRef other)
        {
            return Value.Equals(other.Value);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            return obj is JITEventListenerRef && Equals((JITEventListenerRef)obj);
        }

        public override int GetHashCode()
        {
            return Value.GetHashCode();
        }

        public static bool operator ==(JITEventListenerRef left, JITEventListenerRef right)
        {
            return left.Equals(right);
        }

        public static bool operator !=(JITEventListenerRef left, JITEventListenerRef right)
        {
            return !left.Equals(right);
        }
    
}

}
