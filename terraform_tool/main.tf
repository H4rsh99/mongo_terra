module "vpc" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Vpc?ref=child_module"
  vpc_name = var.name_vpc
  vpc_cidr = var.vpc_cidr_blocks
}
module "subnet" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Subnet?ref=child_module"
  vpcid  = module.vpc.vpc-id
}
module "p_subnet" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/subnet_pvt?ref=child_module"
  vpcid  = module.vpc.vpc-id
}

module "pub_route-table" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Route_table?ref=child_module"
  vpcid  = module.vpc.vpc-id
  Igwid  = module.Igw.Igw-id
  #pub_subnet_id = module.subnet.sub-id[count.index]
  #route_table_id = module.
}

module "pvt_route-table" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Route_table_pvt?ref=child_module"
  vpcid  = module.vpc.vpc-id
  ngwid  = module.ngw.ngw-id
}

module "Igw" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Internet_gateway?ref=child_module"
  vpcid  = module.vpc.vpc-id
}

module "ngw" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Nat_gateway?ref=child_module"
  eip_id        = module.ngw.eip-id
  pub_subnet_id = module.subnet.sub-id[0]
  Igwid         = module.Igw.Igw-id
}


module "rt_associate_pub" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Rt_associate?ref=child_module"
  pub_subnet_id = module.subnet.sub-id
  rtid          = module.pub_route-table.rt-id-pub
}

module "rt_associate_pvt" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Rt_associate_pvt?ref=child_module"
  pvt_subnet_id = module.p_subnet.p_sub-id
  rtid          = module.pvt_route-table.rt-id-pvt
}

module "sg" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Security_group?ref=child_module"
  name-sg = var.sg_name
  vpcid   = module.vpc.vpc-id
}

module "nacl" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/NACL?ref=child_module"
  vpcid  = module.vpc.vpc-id
  cidr_blocks = var.vpc_cidr_blocks
  pvt_subnet_id = module.p_subnet.p_sub-id
}

module "ec2" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Instance?ref=child_module"
  pub_subnet_id   = module.subnet.sub-id
  inst_name       = var.inst_name1
  static           = var.static1
  sg_id            = module.sg.sg-id
}

module "ec2_pvt" {
  source = "git::https://github.com/dxjangra/terraform_tool.git//module/Intsance_pvt?ref=child_module"
  pvt_subnet_id = module.p_subnet.p_sub-id
  p_inst_name     = var.p_inst_name1
  static        = var.static2
  sg_id         = module.sg.sg-id
}

