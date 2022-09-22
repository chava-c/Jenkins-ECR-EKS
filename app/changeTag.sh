#!/bin/bash
sed "s/tagVersion/$1/g" eks-web-deployment.yaml > deployment.yaml