resource "alicloud_ram_user" "user" {
  name         = "ram_user_poc"
  display_name = "POC-TestAccount"
  mobile       = "86-18688888888"
  email        = "example@example.com"
  comments     = "POC"
  force        = true
}

resource "alicloud_ram_login_profile" "profile" {
  user_name = alicloud_ram_user.user.name
  password  = "#EDC6yhn"
}

#resource "alicloud_ram_access_key" "ak" {
#  user_name   = alicloud_ram_user.user.name
#  secret_file = "accesskey.txt"
#}

resource "alicloud_ram_group" "group" {
  name     = "ram_group_poc"
  comments = "this is a POC group "
  force    = true
}

resource "alicloud_ram_group_membership" "membership" {
  group_name = alicloud_ram_group.group.name
  user_names = [alicloud_ram_user.user.name]
}


resource "alicloud_ram_policy" "grp-policy" {
  name     = "GrppolicyName"
  document = <<EOF
    {
      "Statement": [
        {
          "Action": [
            "oss:ListObjects",
            "oss:GetObject"
          ],
          "Effect": "Allow",
          "Resource": [
            "acs:oss:*:*:mybucket",
            "acs:oss:*:*:mybucket/*"
          ]
        }
      ],
        "Version": "1"
    }
  EOF
  description = "this is a grp-policy test"
  force = true
}

resource "alicloud_ram_group_policy_attachment" "attach" {
  policy_name = "${alicloud_ram_policy.grp-policy.name}"
  policy_type = "${alicloud_ram_policy.grp-policy.type}"
  group_name = "${alicloud_ram_group.group.name}"
}



