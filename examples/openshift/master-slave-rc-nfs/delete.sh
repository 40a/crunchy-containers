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

oc delete dc m-s-rc-nfs-slave
oc delete pod m-s-rc-nfs-master 
oc delete pod m-s-rc-nfs-slave
oc delete pod -l name=m-s-rc-nfs-master
../../waitforterm.sh m-s-rc-nfs-master oc
../../waitforterm.sh m-s-rc-nfs-slave oc
oc delete service m-s-rc-nfs-master
oc delete service m-s-rc-nfs-slave
oc delete pvc master-slave-rc-nfs-pvc
oc delete pv  master-slave-rc-nfs-pv
sudo rm -rf /nfsfileshare/m-s-rc-nfs*
