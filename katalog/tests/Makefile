setup:
	mkdir -p workspace
	vagrant up
test-1:
	docker run -w /test_dir -v `pwd`/../..:/test_dir sighup/katalog:v1.0.11 sh -c "flake8 --ignore=E501 katalog/tests/test.py; bash katalog/tests/pytest.sh; rm -rf .pytest_cache katalog/tests/__pycache__ ; "
test-2:
	docker run -w /test_dir -v `pwd`/../..:/test_dir sighup/prom-rules:v1.0.0 bash katalog/tests/promtool.sh
test-3:
	docker run -ti -w /test_dir -v `pwd`/../..:/test_dir -v `pwd`/workspace:/workspace -e CLUSTER_HOST=192.168.31.31 -e KUBECONFIG=/workspace/kubeconfig --network=host sighup/kind:v1.12.3-bats "bats katalog/tests/tests.bats"
test: test-1 test-2 test-3

destroy:
	yes | vagrant destry
	rm -rf workspace
