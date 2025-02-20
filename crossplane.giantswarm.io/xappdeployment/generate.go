package apis

//go:generate xrd-gen paths=./... xrd:allowDangerousTypes=true,crdVersions=v1 object:headerFile=../../hack/boilerplate.go.txt output:artifacts:config=../../apis/xappdeployment
