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
    public static class SubCategoriesExtensions
    {
        /// <summary>
        /// Copy the properties of this SubCategories to another SubCategories
        /// </summary>
        /// <param name="source">The source SubCategories</param>
        /// <param name="target">The target SubCategories</param>
        /// <param name="copySettings">The kind of copy you would like to perform (using PUT or PATCH semantics)</param>
        public static void CopyTo(this SubCategories source, SubCategories target, CopySettings copySettings = CopySettings.UsePutSemantics)
        {
            var helper = new SubCategoriesCopyHelper();
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
