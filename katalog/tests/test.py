import fileinput
import pytest
import yaml


stdin = ""


def read_stdin():
    global stdin
    with fileinput.input(files=("-")) as stream:
        for line in stream:
            stdin += line


def spec():
    if not stdin:
        read_stdin()

    data = []
    for d in yaml.load_all(stdin):
        data.append(d)
    return data


@pytest.mark.parametrize('doc', spec())
def test_api_version(doc):
    allowed_api_version = [
        "v1",
        "apps/v1",
        "batch/v1beta1",
        "monitoring.coreos.com/v1",
        "rbac.authorization.k8s.io/v1",
        "apiextensions.k8s.io/v1beta1"
    ]
    assert doc['apiVersion'] in allowed_api_version


def get_images():
    images = []

    for doc in spec():
        if doc["kind"] in ["DaemonSet", "Deployment", "Job", "StatefulSet"]:
            for init_container in doc["spec"]["template"]["spec"].get("initContainers", []):
                images.append(init_container["image"])

            for container in doc["spec"]["template"]["spec"]["containers"]:
                images.append(container["image"])

        if doc["kind"] == "Pod":
            for init_container in doc["spec"]["template"]["spec"].get("initContainers", []):
                images.append(init_container["image"])

            for container in doc["spec"]["containers"]:
                images.append(container["image"])

        if doc["kind"] == "CronJob":
            for init_container in doc["spec"]["jobTemplate"]["spec"]["template"]["spec"].get("initContainers", []):
                images.append(init_container["image"])

            for container in doc["spec"]["jobTemplate"]["spec"]["template"]["spec"]["containers"]:
                images.append(container["image"])

    return images


@pytest.mark.parametrize('image', get_images())
def test_image_latest_tag(image):
    image_split = image.split(":")
    if len(image_split) < 2:
        tag = "latest"
    else:
        tag = image_split[-1]
    assert tag != "latest"


@pytest.mark.parametrize('doc', spec())
def test_default_namespace(doc):
    not_namespaced = [
        "ComponentStatus",
        "Namespace",
        "Node",
        "PersistentVolume",
        "InitializerConfiguration",
        "MutatingWebhookConfiguration",
        "ValidatingWebhookConfiguration",
        "CustomResourceDefinition",
        "APIService",
        "TokenReview",
        "SelfSubjectAccessReview",
        "SelfSubjectRulesReview",
        "SubjectAccessReview",
        "CertificateSigningRequest",
        "PodSecurityPolicy",
        "NodeMetrics",
        "PodSecurityPolicy",
        "ClusterRoleBinding",
        "ClusterRole",
        "PriorityClass",
        "StorageClass",
        "VolumeAttachment"
    ]

    if doc["kind"] not in not_namespaced:
        assert doc["metadata"].get("namespace", "default") != "default"


@pytest.mark.parametrize('doc', spec())
def test_service_type(doc):
    allowed_service_type = ["ClusterIP", "NodePort"]
    if doc["kind"] == "Service":
        service_type = doc["spec"].get("type", "ClusterIP")
        assert service_type in allowed_service_type
