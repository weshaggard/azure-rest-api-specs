// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

// <auto-generated />

using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Microsoft.Cadl.ProviderHub.Controller;

namespace Microsoft.Impact.Service.Models
{
    /// <summary>
    /// Details about the connectivity issue. Applicable only for connectivity type of impacts.
    /// </summary>
    public partial class Connectivity : ISerializationTracker
    {

        /// <summary>
        /// Extensibility point - allows changing class properties during construction.
        /// </summary>
        partial void OnBeforeInitialize();

        /// <summary>
        /// Extensibility point - allows changing class properties during construction.
        /// </summary>
        partial void OnAfterInitialize();

        /// <summary>
        /// Initializes a new instance of the Connectivity class.
        /// </summary>
        public Connectivity()
        {
            OnBeforeInitialize();
            OnAfterInitialize();
        }

        /// <summary>
        /// The protocol used for the connection
        /// </summary>
        [JsonProperty("protocol")]
        public Protocol Protocol { get; set; }

        /// <summary>
        /// The port number for the connection
        /// </summary>
        [JsonProperty("port")]
        public int Port { get; set; }

        /// <summary>
        /// The direction of the connection
        /// </summary>
        [JsonProperty("direction")]
        public Direction Direction { get; set; }

        /// <summary>
        /// The source of the connection
        /// </summary>
        [JsonProperty("source")]
        public SourceOrDest Source { get; set; }

        /// <summary>
        /// The destination of the connection
        /// </summary>
        [JsonProperty("destination")]
        public SourceOrDest Destination { get; set; }


        /// <summary>
        /// Tracks deserialization of the resource.
        /// </summary>
        [JsonIgnore]
        public ResourceSerializationInfo SerializationInfo { get; set; } = new DefaultSerializationInfo();
    }
}
