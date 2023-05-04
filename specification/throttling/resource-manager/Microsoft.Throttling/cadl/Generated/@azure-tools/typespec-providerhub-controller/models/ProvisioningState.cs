// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

// <auto-generated />
using Newtonsoft.Json;
using Microsoft.TypeSpec.ProviderHub.Controller;

namespace Microsoft.Throttling.Service.Models
{
    [JsonConverter(typeof(EnumJsonConverter<ProvisioningState>))]
    public struct ProvisioningState
    {
        public static readonly ProvisioningState Succeeded = "Succeeded", Failed = "Failed", Canceled = "Canceled", Creating = "Creating", Updating = "Updating", Deleting = "Deleting"; 

        private readonly string _value;

        public ProvisioningState(string value) =>
            _value = value;

        public override string ToString() =>
            _value;

        public static implicit operator string(ProvisioningState obj) =>
            obj.ToString();

        public static implicit operator ProvisioningState(string str) =>
            new ProvisioningState(str);
    }
}
