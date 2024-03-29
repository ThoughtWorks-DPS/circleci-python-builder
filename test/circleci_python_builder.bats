#!/usr/bin/env bats

@test "python3 version" {
  run bash -c "docker exec circleci-python-builder-edge python -V"
  [[ "${output}" =~ "3.11" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-python-builder-edge pip list --format json"
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"23.3.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"setuptools\", \"version\": \"69.0.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"wheel\", \"version\": \"0.42.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"build\", \"version\": \"1.0.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"twine\", \"version\": \"4.0.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"moto\", \"version\": \"4.2.13\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pylint\", \"version\": \"3.0.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest\", \"version\": \"7.4.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest-cov\", \"version\": \"4.1.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"coverage\", \"version\": \"7.4.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"invoke\", \"version\": \"2.2.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"requests\", \"version\": \"2.31.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"Jinja2\", \"version\": \"3.1.3\"}" ]]
}

@test "bats version" {
  run bash -c "docker exec circleci-python-builder-edge bats -v"
  [[ "${output}" =~ "1.10.0" ]]
}

@test "snyk version" {
  run bash -c "docker exec circleci-python-builder-edge snyk version"
  [[ "${output}" =~ "1.1274.0" ]]
}

@test "cosign version" {
  run bash -c "docker exec circleci-python-builder-edge cosign version"
  [[ "${output}" =~ "2.2" ]]
}

@test "syft version" {
  run bash -c "docker exec circleci-python-builder-edge syft version"
  [[ "${output}" =~ "0.100" ]]
}

@test "oras version" {
  run bash -c "docker exec circleci-python-builder-edge oras version"
  [[ "${output}" =~ "1.1" ]]
}
