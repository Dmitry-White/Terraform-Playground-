config {
    # By default, TFLint inspects only the root module.
    # It can optionally also inspect module calls.
    # When this option is enabled, TFLint evaluates each call (i.e. module block) and
    # emits any issues that result from the specified input variables.
    # Issues must be associated with a variable that was passed to the module.
    # Otherwise they are discarded. 
    module = true

    # If `true` return zero exit status even if issues found.
    # TFLint returns the following exit statuses on exit by default:
    # 0: No issues found
    # 1: Errors occurred
    # 2: No errors occurred, but issues found
    force = false
    disabled_by_default = false
}

# No need to enable recommended TF settings,
#`plugin "terraform"` is built-in
# https://github.com/terraform-linters/tflint-ruleset-terraform/blob/main/docs/rules/README.md

plugin "aws" {
    enabled = true
    version = "0.21.1"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
