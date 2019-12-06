# Service warriors using Ballerina V 1.0.5

## Prerequisites

* [JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) or [OpenJDK 8](http://openjdk.java.net/install/)
* [Node (v8.9.x) + npm (v5.6.0 or later)](https://nodejs.org/en/download/)
* [Docker](https://www.docker.com/get-docker)
* [Kubernetes](https://kubernetes.io/) and [minikube](https://github.com/kubernetes/minikube) (or another)
* [Ballerina](https://ballerina.io/learn/getting-started/)
* [VSC](https://v1-0.ballerina.io/learn/tools-ides/vscode-plugin/) or [IntelliJ](https://v1-0.ballerina.io/learn/tools-ides/intellij-plugin/) Ballerina plugin

## Todo

Develop and deploy a service exposing a list of warriors using [Ballerina](https://v1-0.ballerina.io/).

## Validation tests (TDD:  [api-tests](api-tests.http))
When deploy the services on the cluster, verify that the following calls work:
```shell script
# Missing apikey ==> throw 401
curl GET http://localhost:8080/api/v1/warriors

# Invalid apikey ==> throw 401
curl GET http://localhost:8080/api/v1/warriors -H "apikey: G02TheBeach==" 

# Valid apikey ==>  get warriors (75%) & throw 500 (25%)
curl GET http://localhost:8080/api/v1/warriors -H "apikey: Z2FtZTpnYW1lMQ==" 
```
## See more

* [Examples](https://ballerina.io/learn/by-example/) 
* [Ballerina central](https://central.ballerina.io/)
* [Publishing config](https://central.ballerina.io/publish-module)
