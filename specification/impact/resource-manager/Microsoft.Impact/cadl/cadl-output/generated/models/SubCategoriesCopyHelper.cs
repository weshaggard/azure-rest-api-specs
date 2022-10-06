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
    /// Helper for merging canonical SubCategories models as part of a PUT or PATCH operation
    /// </summary>
    public partial class SubCategoriesCopyHelper
    {
        /// <summary>
        /// Extensibility point: perform actions before data is copied
        /// </summary>
        /// <param name="source">The source SubCategories</param>
        /// <param name="target">The target SubCategories</param>
        partial void OnBeginCopyForPatch(SubCategories source, SubCategories target);

        /// <summary>
        /// Extensibility point: perform actions after data is copied
        /// </summary>
        /// <param name="source">The source SubCategories</param>
        /// <param name="target">The target SubCategories</param>
        partial void OnEndCopyForPatch(SubCategories source, SubCategories target);

        /// <summary>
        /// Copy the properties of a source SubCategories to a target SubCategories, using PATCH semantics
        /// </summary>
        /// <param name="source">The source SubCategories</param>
        /// <param name="target">The target SubCategories</param>
        public void CopyForPatch(SubCategories source, SubCategories target)
        {
            var serialization = source.SerializationInfo;
            OnBeginCopyForPatch(source, target);
            if (serialization.IsSerializedProperty(nameof(source.Name)))
                target.Name = source.Name;
            if (serialization.IsSerializedProperty(nameof(source.Description)))
                target.Description = source.Description;
            if (serialization.IsSerializedProperty(nameof(source.SubCategories)))
                target.SubCategories = source.SubCategories;
            if (serialization.IsSerializedProperty(nameof(source.CategoryId)))
                target.CategoryId = source.CategoryId;
            if (serialization.IsSerializedProperty(nameof(source.RequiredImpactFields)))
                target.RequiredImpactFields = source.RequiredImpactFields;
            OnEndCopyForPatch(source, target);
        }

        /// <summary>
        /// Extensibility point: perform actions before data is copied
        /// </summary>
        /// <param name="source">The source SubCategories</param>
        /// <param name="target">The target SubCategories</param>
        partial void OnBeginCopyForPut(SubCategories source, SubCategories target);

        /// <summary>
        /// Extensibility point: perform actions after data is copied
        /// </summary>
        /// <param name="source">The source SubCategories</param>
        /// <param name="target">The target SubCategories</param>
        partial void OnEndCopyForPut(SubCategories source, SubCategories target);

        /// <summary>
        /// Copy the properties of a source SubCategories to a target SubCategories, using PUT semantics
        /// </summary>
        /// <param name="source">The source SubCategories</param>
        /// <param name="target">The target SubCategories</param>
        public void CopyForPut(SubCategories source, SubCategories target)
        {
            var serialization = source.SerializationInfo;
            OnBeginCopyForPut(source, target);
            target.Name = source.Name;
            target.Description = source.Description;
            target.SubCategories = source.SubCategories;
            target.CategoryId = source.CategoryId;
            target.RequiredImpactFields = source.RequiredImpactFields;
            OnEndCopyForPut(source, target);
        }
    }
}
