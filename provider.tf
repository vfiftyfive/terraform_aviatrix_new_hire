provider "aviatrix" {
  //get controller IP from remote state - contoller bootstrap plan
  controller_ip = data.terraform_remote_state.controller_data.outputs.cloudformation["AviatrixControllerEIP"]
  username      = "admin"
  //get updated password from remote state - controller bootstrap plan
  // password = data.terraform_remote_state.controller_data.outputs.cloudformation["AviatrixControllerPrivateIP"]
  password = "AV!@trix123"
  skip_version_validation = true
}