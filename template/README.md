# API template

This folder contains the template structure required for creating a new API

Use the script `create.sh` to automatically create the skeleton structure used
by this repository

For example

```bash
./create.sh
[INFO] Enter the group name > xrepository
[INFO] Enter the composition name (lowercase, hyphenated) > github-pull-request
[INFO] Enter the group class (camel-cased struct name) > PullRequest
[INFO] creating directories
[INFO] templating generate.go
[INFO] templating main.go
[INFO] templating doc.go
[INFO] templating groupversion.go
[INFO] Enter a shortname for the XRD type > pr
[INFO] Enforce composition? (yes/no) > no
Building...
```

- `group name` defines a group of compositions that logically belong together
- `composition-name` is the name of the new composition to create
- `group class` is the name of the struct for your composition.
  This becomes the XRD structure. If it doesn't exist it will be created.
  You can create multiple APIs in the same group, or you can share multiple
  compositions behind a single API.

  When creating a new API you will also be asked for
  - `shortname` This is a shortname to give the CRD
  - `enforced` If the composition being created should be enforced by the XRD
