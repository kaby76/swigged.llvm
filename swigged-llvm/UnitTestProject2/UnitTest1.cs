using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using CSLLVM;

namespace UnitTestProject2
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            CSLLVM.ContextRef g = CSLLVM.LLVM.GetGlobalContext();
            

            //LLVM.ConstantRange ConstantRangeTest::Full(16);
            //ConstantRange ConstantRangeTest::Empty(16, false);
            //ConstantRange ConstantRangeTest::One(APInt(16, 0xa));
            //ConstantRange ConstantRangeTest::Some(APInt(16, 0xa), APInt(16, 0xaaa));
            //ConstantRange ConstantRangeTest::Wrap(APInt(16, 0xaaa), APInt(16, 0xa));
        }
    }
}
