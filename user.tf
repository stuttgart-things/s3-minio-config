resource "minio_iam_user" "minio_user" {
  for_each = {
    for mount in var.users :
    mount.name => mount
  }

  name   = each.value["name"]
  secret = each.value["secret"]

  depends_on = [helm_release.minio, minio_iam_policy.new_policy]

}


resource "minio_iam_user_policy_attachment" "policy_attachment" {

  for_each = {
    for mount in var.users :
    mount.name => mount if mount.policy != null
  }

  user_name   = each.value["name"]
  policy_name = each.value["policy"]

  depends_on = [minio_iam_user.minio_user, minio_iam_policy.new_policy]
}
