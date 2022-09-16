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
    /// Helper for merging canonical WorkloadimpactsUpdateProperties models as part of a PUT or PATCH operation
    /// </summary>
    public partial class WorkloadimpactsUpdatePropertiesCopyHelper
    {
        /// <summary>
        /// Extensibility point: perform actions before data is copied
        /// </summary>
        /// <param name="source">The source WorkloadimpactsUpdateProperties</param>
        /// <param name="target">The target WorkloadimpactsUpdateProperties</param>
        partial void OnBeginCopyForPatch(WorkloadimpactsUpdateProperties source, WorkloadimpactsUpdateProperties target);

        /// <summary>
        /// Extensibility point: perform actions after data is copied
        /// </summary>
        /// <param name="source">The source WorkloadimpactsUpdateProperties</param>
        /// <param name="target">The target WorkloadimpactsUpdateProperties</param>
        partial void OnEndCopyForPatch(WorkloadimpactsUpdateProperties source, WorkloadimpactsUpdateProperties target);

        /// <summary>
        /// Copy the properties of a source WorkloadimpactsUpdateProperties to a target WorkloadimpactsUpdateProperties, using PATCH semantics
        /// </summary>
        /// <param name="source">The source WorkloadimpactsUpdateProperties</param>
        /// <param name="target">The target WorkloadimpactsUpdateProperties</param>
        public void CopyForPatch(WorkloadimpactsUpdateProperties source, WorkloadimpactsUpdateProperties target)
        {
            var serialization = source.SerializationInfo;
            OnBeginCopyForPatch(source, target);
            if (serialization.IsSerializedProperty(nameof(source.StartDateTimeUtc)))
                target.StartDateTimeUtc = source.StartDateTimeUtc;
            if (serialization.IsSerializedProperty(nameof(source.EndDateTimeUtc)))
                target.EndDateTimeUtc = source.EndDateTimeUtc;
            if (serialization.IsSerializedProperty(nameof(source.ImpactCategory)))
                target.ImpactCategory = source.ImpactCategory;
            if (serialization.IsSerializedProperty(nameof(source.ImpactDescription)))
                target.ImpactDescription = source.ImpactDescription;
            if (serialization.IsSerializedProperty(nameof(source.ArmCorrelationIds)))
                target.ArmCorrelationIds = source.ArmCorrelationIds;
            if (serialization.IsSerializedProperty(nameof(source.ImpactedResourceUri)))
                target.ImpactedResourceUri = source.ImpactedResourceUri;
            if (serialization.IsSerializedProperty(nameof(source.AdditionalProperties)))
                target.AdditionalProperties = source.AdditionalProperties;
            if (serialization.IsSerializedProperty(nameof(source.Connectivity)))
                target.Connectivity = source.Connectivity;
            if (serialization.IsSerializedProperty(nameof(source.Performance)))
                target.Performance = source.Performance;
            if (serialization.IsSerializedProperty(nameof(source.Workload)))
                target.Workload = source.Workload;
            if (serialization.IsSerializedProperty(nameof(source.ImpactGroupId)))
                target.ImpactGroupId = source.ImpactGroupId;
            OnEndCopyForPatch(source, target);
        }

        /// <summary>
        /// Extensibility point: perform actions before data is copied
        /// </summary>
        /// <param name="source">The source WorkloadimpactsUpdateProperties</param>
        /// <param name="target">The target WorkloadimpactsUpdateProperties</param>
        partial void OnBeginCopyForPut(WorkloadimpactsUpdateProperties source, WorkloadimpactsUpdateProperties target);

        /// <summary>
        /// Extensibility point: perform actions after data is copied
        /// </summary>
        /// <param name="source">The source WorkloadimpactsUpdateProperties</param>
        /// <param name="target">The target WorkloadimpactsUpdateProperties</param>
        partial void OnEndCopyForPut(WorkloadimpactsUpdateProperties source, WorkloadimpactsUpdateProperties target);

        /// <summary>
        /// Copy the properties of a source WorkloadimpactsUpdateProperties to a target WorkloadimpactsUpdateProperties, using PUT semantics
        /// </summary>
        /// <param name="source">The source WorkloadimpactsUpdateProperties</param>
        /// <param name="target">The target WorkloadimpactsUpdateProperties</param>
        public void CopyForPut(WorkloadimpactsUpdateProperties source, WorkloadimpactsUpdateProperties target)
        {
            var serialization = source.SerializationInfo;
            OnBeginCopyForPut(source, target);
            target.StartDateTimeUtc = source.StartDateTimeUtc;
            target.EndDateTimeUtc = source.EndDateTimeUtc;
            target.ImpactCategory = source.ImpactCategory;
            target.ImpactDescription = source.ImpactDescription;
            target.ArmCorrelationIds = source.ArmCorrelationIds;
            target.ImpactedResourceUri = source.ImpactedResourceUri;
            target.AdditionalProperties = source.AdditionalProperties;
            target.Connectivity = source.Connectivity;
            target.Performance = source.Performance;
            target.Workload = source.Workload;
            target.ImpactGroupId = source.ImpactGroupId;
            OnEndCopyForPut(source, target);
        }
    }
}
