pull:
test-1:
	vagrant ssh -c "docker pull sighup/katalog:v1.0.11" $(FURY_VM_ID)
	vagrant ssh -c "docker run -w /test_dir -v /workspace/sighup/fury-kubernetes-monitoring:/test_dir sighup/katalog:v1.0.11 sh -c \"pwd; ls ; flake8 --ignore=E501 katalog/tests/test.py; bash katalog/tests/pytest.sh; rm -rf .pytest_cache katalog/tests/__pycache__ ;\"" $(FURY_VM_ID)
test-2:
	vagrant ssh -c "docker pull sighup/prom-rules:v1.0.0" $(FURY_VM_ID)
	vagrant ssh -c "docker run -w /test_dir -v /workspace/sighup/fury-kubernetes-monitoring:/test_dir sighup/prom-rules:v1.0.0 bash katalog/tests/promtool.sh" $(FURY_VM_ID)
test-3:
	vagrant ssh -c "docker pull sighup/kind:v1.12.3-bats" $(FURY_VM_ID)
	vagrant ssh -c "docker run -ti -w /test_dir -v /workspace/sighup/fury-kubernetes-monitoring:/test_dir -v /workspace:/workspace -e LOCAL_DEV_ENV=true -e CLUSTER_HOST=localhost -e KUBECONFIG=/workspace/kubeconfig --network=host sighup/kind:v1.12.3-bats \"bats -p katalog/tests/tests.bats\"" $(FURY_VM_ID)

test: test-1 test-2 test-3
