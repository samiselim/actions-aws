## some instructions
1) Go to IAM in AWS account 
2) Create OpenID Connect identity Provider 
   * URL       : token.actions.githubusercontent.com
   * Audience  : sts.amazonaws.com
3) create S3 for tfstate file of terraform
4) create IAM role for github repo and this is json file of this role 
    {
        "Version": "2008-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Federated": "arn:aws:iam::767397735708:oidc-provider/token.actions.githubusercontent.com"
                },
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Condition": {
                    "StringLike": {
                        "token.actions.githubusercontent.com:sub": "repo:samiselim/gh-oidc-terraform:*"
                    }
                }
            }
        ]
    }
5) After that create policy for oidc role using this json and attach it to IAM role 
   {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::oidc-terraform-tfstate-file/*",
                "arn:aws:s3:::oidc-terraform-tfstate-file"
            ]
        }
    ]
}

6) for this use case : create ssm policy to allow evreything 
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:PutParameter",
                "ssm:LabelParameterVersion",
                "ssm:DeleteParameter",
                "ssm:UnlabelParameterVersion",
                "ssm:DescribeParameters",
                "ssm:GetParameterHistory",
                "ssm:ListTagsForResource",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter",
                "ssm:DeleteParameters"
            ],
            "Resource": "*"
        }
    ]
}


    