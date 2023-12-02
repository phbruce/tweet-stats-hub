locals {
  dependencies_raw = file("${path.module}/requirements.txt")
  dependencies     = replace(local.dependencies_raw, "\n", ",")

  q1_memory_script = file("${path.module}/q1_memory.py")
  q2_memory_script = file("${path.module}/q2_memory.py")
  q3_memory_script = file("${path.module}/q3_memory.py")

  q1_time_script = file("${path.module}/q1_time.py")
  q2_time_script = file("${path.module}/q2_time.py")
  q3_time_script = file("${path.module}/q3_time.py")
}
