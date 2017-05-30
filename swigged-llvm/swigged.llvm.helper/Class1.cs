using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Runtime.Loader;

namespace Swigged.LLVM.Helper
{
    public static class Adjust
    {
        /// <summary>
        /// Adjust the search path for DLL's and SO's to depend on the environment to
        /// depend on the type of build, the OS, and/or the ABI. This eases the
        /// responsibility of the developer to copy the native file around which are
        /// problematic and error prone. There is no "right" vs. "wrong" way to place
        /// assembly files in a file system. We need to be robust. At worse case, the
        /// user will need to still copy the native dll to the build output directory
        /// if this search path adjustment fails.
        /// 
        /// Some OSes limit the size of the search path. Therefore, we need to actually
        /// look for the directories specified.
        /// </summary>
        public static void Path()
        {
            string Version = "4.0.9-alpha";

            List<string> additional_paths = new List<string>();

            // First, let's gather some basic information.

            string path = Environment.GetEnvironmentVariable("PATH") ?? string.Empty;
            if (path == null || path.Equals(""))
                return;

            var is64bitProcess = IntPtr.Size == 8;

            bool isDebug;
#if DEBUG
            isDebug = true;
#else
            isDebug = false;
#endif
            var the_os = System.Runtime.InteropServices.RuntimeInformation.OSDescription;
            var os = Environment.GetEnvironmentVariable("OS");
            bool isWindows = os != null && os.IndexOf("windows", StringComparison.OrdinalIgnoreCase) >= 0;
            if (the_os != null && the_os.IndexOf("windows", StringComparison.OrdinalIgnoreCase) >= 0) isWindows = true;

            bool isUbuntu = false;
            var hosttype = Environment.GetEnvironmentVariable("HOSTTYPE");
            if (hosttype != null && hosttype.IndexOf("x86_64", StringComparison.OrdinalIgnoreCase) >= 0) isUbuntu = true;
            if (the_os != null && the_os.IndexOf("ubuntu", StringComparison.OrdinalIgnoreCase) >= 0) isUbuntu = true;

            bool isAndroid = false;
            if (the_os != null && the_os.IndexOf("android", StringComparison.OrdinalIgnoreCase) >= 0) isAndroid = true;

            // Get "home"---platform specific.
            string home = "";
            if (isWindows)
            {
                var home_drive = Environment.GetEnvironmentVariable("HOMEDRIVE");
                var home_path = Environment.GetEnvironmentVariable("HOMEPATH");
                // Note: "HOME" will be dependent on the parent process, which could be Cygwin or Mingw.
                home = home_drive + home_path;
            }
            if (isUbuntu)
            {
                var home_path = Environment.GetEnvironmentVariable("HOME");
                home = home_path;
            }

            // Start with various Windows paths.
            if (isWindows)
            {
                for (int levels = 1; levels < 5; ++levels)
                {
                    var d = Enumerable.Repeat("../", levels)
                                .Aggregate(
                                    new StringBuilder(),
                                    (sb, s) => sb.Append(s))
                                .ToString() + "swigged.llvm.native/";
                    if (!Directory.Exists(d))
                        continue;

                    // Add in local build paths.
                    if (is64bitProcess)
                    {
                        if (isDebug) additional_paths.Add(d + "/x64-Debug/Debug");
                        else additional_paths.Add(d + "/x64-Release/Release");
                    }
                    else
                    {
                        if (isDebug) additional_paths.Add(d + "/x86-Debug/Debug");
                        else additional_paths.Add(d + "/x86-Release/Release");
                    }
                }
                // Package install.
                for (int levels = 1; levels < 5; ++levels)
                {
                    var d = Enumerable.Repeat("../", levels)
                                .Aggregate(
                                    new StringBuilder(),
                                    (sb, s) => sb.Append(s))
                                .ToString() + "packages/";
                    if (! Directory.Exists(d))
                        continue;
                    var e = Directory.EnumerateDirectories(d, "swigged.llvm.*");
                    var dd = e.FirstOrDefault();
                    if (dd == null) continue;
                    if (dd.Equals("")) continue;
                    d += "/win10/lib/" + (is64bitProcess ? "x64" : "x86");
                    additional_paths.Add(d);
                }

                // Try adding dotnet package cache.
                additional_paths.Add(home + "/.nuget/packages/swigged.llvm/" + Version + "/win10/lib/" + (is64bitProcess ? "x64" : "x86"));
            }

            if (isUbuntu)
            {
                // Nothing can be done. You must "dotnet restore -r ubuntu.16.04-x64",
                // "dotnet build -r ubuntu.16.04-x64"
                // "dotnet publish -r ubuntu.16.04-x64"
                // cp /home/{user}/.nuget/packages/swigged.llvm/{version}/ubuntu-16.04/lib/x64/swigged-llvm-native.so
                //     bin/Debug/netcoreapp1.1/ubuntu.16.04-x64/publish
                // cd !$
                // "dotnet {executable}.dll"
                return;
            }

            foreach (string dir in additional_paths)
            {
                System.Console.WriteLine("looking in " + dir);
                if (! Directory.Exists(dir))
                    continue;
                path = dir + ":" + path;
            }
            if (isWindows)
            {
                Environment.SetEnvironmentVariable("PATH", path);
            }
        }

        public static string Adjustment
        {
            get
            {
                var is64bitProcess = IntPtr.Size == 8;
                var os = Environment.GetEnvironmentVariable("OS");
                if (os != null && os.Contains("Windows_NT"))
                {
                    return "win10/lib/" + (is64bitProcess ? "x64" : "x86");
                }
                var hosttype = Environment.GetEnvironmentVariable("HOSTTYPE");
                if (hosttype != null && hosttype.Contains("x86_64"))
                {
                    return "ubuntu-16.04/lib/" + (is64bitProcess ? "x64" : "x86");
                }
                return "";
            }
        }
    }
}
