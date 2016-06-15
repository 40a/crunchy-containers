#!/bin/bash

# Copyright 2016 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# 
# this example creates the metrics backends with NFS volumes
# for storing their data
#
IPADDRESS=`hostname --ip-address`
cat $BUILDBASE/examples/kube/metrics/grafana-pv.json | sed -e "s/IPADDRESS/$IPADDRESS/g" | oc create -f -
cat $BUILDBASE/examples/kube/metrics/prometheus-pv.json | sed -e "s/IPADDRESS/$IPADDRESS/g" | kubectl create -f -

kubectl create -f $BUILDBASE/examples/kube/metrics/grafana-pvc.json
kubectl create -f $BUILDBASE/examples/kube/metrics/prometheus-pvc.json

kubectl.sh create -f $BUILDBASE/examples/kube/metrics/prometheus-nfs.json
kubectl.sh create -f $BUILDBASE/examples/kube/metrics/prometheus-service.json
kubectl.sh create -f $BUILDBASE/examples/kube/metrics/promgateway.json
kubectl.sh create -f $BUILDBASE/examples/kube/metrics/promgateway-service.json
kubectl.sh create -f $BUILDBASE/examples/kube/metrics/grafana-nfs.json
kubectl.sh create -f $BUILDBASE/examples/kube/metrics/grafana-service.json
