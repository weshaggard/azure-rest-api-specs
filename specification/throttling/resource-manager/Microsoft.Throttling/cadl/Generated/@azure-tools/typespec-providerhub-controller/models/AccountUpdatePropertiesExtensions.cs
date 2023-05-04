// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

// <auto-generated />

using System;
using System.ComponentModel;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using Microsoft.TypeSpec.ProviderHub.Controller;

namespace Microsoft.Throttling.Service.Models
{
    /// <summary>
    /// Extensions for easy PUT and PATCH copying of a resource
    /// </summary>
    public static class AccountUpdatePropertiesExtensions
    {
        /// <summary>
        /// Copy the properties of this AccountUpdateProperties to another AccountUpdateProperties
        /// </summary>
        /// <param name="source">The source AccountUpdateProperties</param>
        /// <param name="target">The target AccountUpdateProperties</param>
        /// <param name="copySettings">The kind of copy you would like to perform (using PUT or PATCH semantics)</param>
        public static void CopyTo(this AccountUpdateProperties source, AccountUpdateProperties target, CopySettings copySettings = CopySettings.UsePutSemantics)
        {
            var helper = new AccountUpdatePropertiesCopyHelper();
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
