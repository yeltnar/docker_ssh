For OpenShift:

Create Project with the `slb-brownfiled.project.yaml` file. You don't need to use this file, but do need the user and group IDs that are shown under `openshift.io/sa.scc.uid-range` and `openshift.io/sa.scc.supplemental-groups`

Within this project, create a new app with the source as this repo. When doing this, make sure to set a build environment variable containing the desired user id. ie: `USER_ID=246000`. This creates a user with the OpenShift approved range so sshd can run as non root, but ssh can access the known user. 

Do not create a route. Route ingress will not work with SSH. You will need to use `oc port-forward`, or expose a cluster port

When making the service, make sure to use the port defined in this repo: 8022 (changed to higher number so it can be created as non root)

After creating the deployment for the SSH server, set the user ID to be used inside the deployment's yaml. `securityContext` needs the key/value inside it of `runAsUser: 246000`, or whatever `USER_ID` you used above

You can access the remote ssh server with `oc port-forward svc/docker-ssh-git 9022:8022`


*TODO*

document creating/adding ssh key

document where persistant volumes need to be created 