The following is some terraform code to make/manage some infrastructure used to create an ubuntu mirror hosted inside the EC2 created with mirror_ec2.tf

The rest of the infrastructure is used as follows:

The ec2_on_and_off_schedule.tf creates a schedule to turn an EC2 on and off. This triggers an application which will download an update of the Ubuntu repoistory and push it to the "new mirror" s3 bucket (s3_new_mirror_bucket.tf). The code for this application is hosted entirely within the EC2 but has been included inside the "diff-scripts" folder here. 

The application will check the differences between the new, updated mirror and that of the old (s3_old_mirror_bucket.tf). These differences will be stored in a .txt file that can then be interpreted as the differences or "diffs" between the previous update and the newest. These diffs will be extracted from new mirror and placed into the "diffs bucket" (s3_diffs_mirror_bucket.tf) alongside a "rm" file, which lists all the files that have been removed (rather than simply updated or added) from the new to the old mirror. Finally, when given sufficient time, ec2_on_and_off_schedule.tf will ensure that the EC2 is turned off, so that it saves resources when they are not being used.

The above application is used to push the "diffs" files (the package additions for an Ubuntu repository + the removal list) to a repository that cannot (for security reasons) be connected to the internet. This ensures the offline repository can still be regluarly updated BUT remains airgapped.

To finish/reiterate our description:

    - diff-scripts folder = contains the application dictated above
    - iam_role_scheduler.tf = creates the policy + role for the schedule (to trigger the EC2 on and off)
    - main.tf = obvious usage
    - mirror_ec2.tf = creates + manages the EC2 itself
    - s3_diffs_mirror_bucket.tf = diffs bucket
    - s3_diffs_new_bucket.tf = new bucket
    - s3_diffs_old_bucket.tf - old bucket
    - security_group.tf = locks down EC2 use to only certain IP addresses
    - ssm_role.tf = provides policy + role for EC2 to modify itself, manage and control the s3 buckets and provide SSM access
    - var.tf = contains variables (including tags + bucket names)

Please note parts of this code have been replaced with "EXAMPLE" to remove any potentially sensitive information. 