# Unit Tests — tf-atom-wafv2-ip-set-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:      terraform test -test-directory=tests/unit
# Run verbose:   terraform test -test-directory=tests/unit -verbose
#
# All assertions target values that are KNOWN at plan time under a mock
# provider (the tf-label id string, resource count, input pass-throughs).
# Computed attributes (arn, id) are unknown under a mock and are only
# asserted on in the disabled case, where they collapse to "" via try().

mock_provider "aws" {}

variables {
  # tf-label context (required for a deterministic module.this.id)
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module-specific required / sample inputs
  scope              = "REGIONAL"
  description        = "Allow-list for corporate egress IPs"
  ip_address_version = "IPV4"
  addresses          = ["203.0.113.0/24", "198.51.100.10/32"]
}

# ---------------------------------------------------------------------------
# Test: module creates the IP set when enabled (the default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = length(aws_wafv2_ip_set.default) == 1
    error_message = "exactly one aws_wafv2_ip_set should be planned when enabled"
  }

  assert {
    condition     = aws_wafv2_ip_set.default[0].name == "eg-test-thing"
    error_message = "IP set name should be the tf-label id 'eg-test-thing'"
  }

  assert {
    condition     = aws_wafv2_ip_set.default[0].scope == "REGIONAL"
    error_message = "scope input should pass through to the IP set resource"
  }

  assert {
    condition     = length(aws_wafv2_ip_set.default[0].addresses) == 2
    error_message = "addresses input should pass through to the IP set resource"
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output should be false when the module is disabled"
  }

  assert {
    condition     = length(aws_wafv2_ip_set.default) == 0
    error_message = "no aws_wafv2_ip_set should be planned when disabled"
  }

  assert {
    condition     = output.arn == ""
    error_message = "arn output should collapse to empty string when disabled"
  }

  assert {
    condition     = output.id == ""
    error_message = "id output should collapse to empty string when disabled"
  }
}
