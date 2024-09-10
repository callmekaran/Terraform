In this Code, we are utilizing modules, so it will first create the secret manager & we will get ARN , then it will have an output to a variable, and last we will establish an IAM as desired by the secret manager ARN.
- Source is Secret Manager,

  1) Take output of what you want in that modules/resouce/output.tf, **output "secret_arn"** and **value will be arn**, copy same in main modules output.tf
  2) Then Create One Variable to set that output value within variable so for that create varibale with name reference_secret_manager {}
  3) Same as task 2 But for now we will add that variable in destination (IAM Module), create varibale with name reference_secret_manager {}
  4) In main modules variable.tf also add this,create varibale with name reference_secret_manager {}
  5) Now in destiantion where you would like to use variable For example i wwanna use in iam policy for resource then put **var.reference_secret_manager** , **Not in ""**
  6) Now Lets Ride Modules main.tf, add values in both variable reference_secret_manager = module.secret_manager or module.secret_arn {i have used name of my module is secret-manager}
  7) Last add above value in terraform.tfvars too 
