
namespace Swigged.LLVM {

public partial struct MyString : System.IEquatable<MyString> {
	public MyString(global::System.IntPtr cPtr)
	{
		Value = cPtr;
	}

	public System.IntPtr Value;

	public bool Equals(MyString other)
	{
		return Value.Equals(other.Value);
	}

	public override bool Equals(object obj)
	{
		if (ReferenceEquals(null, obj)) return false;
		return obj is MyString && Equals((MyString)obj);
	}

	public override int GetHashCode()
	{
		return Value.GetHashCode();
	}

	public static bool operator ==(MyString left, MyString right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(MyString left, MyString right)
	{
		return !left.Equals(right);
	}

}

}
