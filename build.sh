podman build --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" --build-arg USER_ID=9999 -t rm .