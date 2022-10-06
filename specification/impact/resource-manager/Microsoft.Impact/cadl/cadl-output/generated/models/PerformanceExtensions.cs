// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

// <auto-generated />

using System;
using System.ComponentModel;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using Microsoft.Cadl.ProviderHub.Controller;

namespace Microsoft.Impact.Service.Models
{
    /// <summary>
    /// Extensions for easy PUT and PATCH copying of a resource
    /// </summary>
    public static class PerformanceExtensions
    {
        /// <summary>
        /// Copy the properties of this Performance to another Performance
        /// </summary>
        /// <param name="source">The source Performance</param>
        /// <param name="target">The target Performance</param>
        /// <param name="copySettings">The kind of copy you would like to perform (using PUT or PATCH semantics)</param>
        public static void CopyTo(this Performance source, Performance target, CopySettings copySettings = CopySettings.UsePutSemantics)
        {
            var helper = new PerformanceCopyHelper();
            switch (copySettings)
            {
                case CopySettings.UsePatchSemantics:
                    helper.CopyForPatch(source, target);
                    break;
                case CopySettings.UsePutSemantics:
                    helper.CopyForPut(source, target);
                    break;
            }
        }
    }
}
