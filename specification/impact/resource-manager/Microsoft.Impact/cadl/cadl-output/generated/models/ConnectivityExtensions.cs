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
    public static class ConnectivityExtensions
    {
        /// <summary>
        /// Copy the properties of this Connectivity to another Connectivity
        /// </summary>
        /// <param name="source">The source Connectivity</param>
        /// <param name="target">The target Connectivity</param>
        /// <param name="copySettings">The kind of copy you would like to perform (using PUT or PATCH semantics)</param>
        public static void CopyTo(this Connectivity source, Connectivity target, CopySettings copySettings = CopySettings.UsePutSemantics)
        {
            var helper = new ConnectivityCopyHelper();
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
