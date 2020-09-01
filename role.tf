resource "alicloud_ram_role" "role" {
  name = "POCtestRole"
  document = <<EOF
    {
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "apigateway.aliyuncs.com",
              "ecs.aliyuncs.com"
            ]
          }
        }
      ],
      "Version": "1"
    }
EOF
  description = "this is a role test."
  force       = true
}


resource "alicloud_ram_policy" "policy" {
  name = "POCtestPolicy"
  document = <<EOF
    {
      "Statement": [
        {
          "Action": [
            "oss:ListObjects",
            "oss:GetObject"
          ],
          "Effect": "Deny",
          "Resource": [
            "acs:oss:*:*:mybucket",
            "acs:oss:*:*:mybucket/*"
          ]
        }
      ],
        "Version": "1"
    }
EOF
  description = "this is a POC policy"
  force       = true
}


resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.name
  role_name   = alicloud_ram_role.role.name
  policy_type = alicloud_ram_policy.policy.type
}


