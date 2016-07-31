﻿// Copyright (c) .NET Foundation and contributors. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System;
using System.IO;
using System.Runtime.InteropServices;
using Microsoft.DotNet.Cli.Utils;
using Microsoft.DotNet.InternalAbstractions;

namespace Microsoft.DotNet.Cli
{
    internal class MulticoreJitProfilePathCalculator
    {
        private string _multicoreJitProfilePath;

        public string MulticoreJitProfilePath
        {
            get
            {
                if (_multicoreJitProfilePath == null)
                {
                    CalculateProfileRootPath();
                }

                return _multicoreJitProfilePath;
            }
        }

        private void CalculateProfileRootPath()
        {
            var profileRoot = GetRuntimeDataRootPathString();

            var version = Product.Version;

            var rid = Microsoft.DotNet.InternalAbstractions.RuntimeEnvironment.GetRuntimeIdentifier();

            _multicoreJitProfilePath = Path.Combine(profileRoot, "optimizationdata", version, rid);
        }

        private string GetRuntimeDataRootPathString()
        {
            return System.Runtime.InteropServices.RuntimeInformation.IsOSPlatform(OSPlatform.Windows)
                ? GetWindowsRuntimeDataRoot()
                : GetNonWindowsRuntimeDataRoot();
        }

        private static string GetWindowsRuntimeDataRoot()
        {
            return $@"{(Environment.GetEnvironmentVariable("LocalAppData"))}\Microsoft\dotnet\";
        }

        private static string GetNonWindowsRuntimeDataRoot()
        {
            return $"{(Environment.GetEnvironmentVariable("HOME"))}/.dotnet/";
        }
    }
}