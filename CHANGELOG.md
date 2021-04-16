## 0.6.1
* Pass keyword arguments correctly to helm-cli (#1, @rept)

## 0.6.0
* Wait for API resources to become available.
  - Krane queries k8s for API resources which causes kubectl to exit with a non-zero status code if KubeDB's operator isn't finished spinning up.

## 0.5.0
* Conform to new plugin architecture.
* Accept `environment` instead of `definition` instances.

## 0.4.0
* Downgrade to kubedb 0.12.0, the latest stable release.
  - For some reason, the API spec for 0.13.0.rc-0 was removed from the apimachinery repo.
  - Other rcs in the 0.13.0 line, eg. 0.13.0.rc-1 are not published as Helm charts.
* Upgrade to helm-cli 0.2.

## 0.3.0
* Upgrade to kube-dsl 0.3.

## 0.2.0
* Require version file in order to use the `VERSION` constant.

## 0.1.0
* Birthday!
