variable "vpc_cidr_block" {

  
}

variable "vpc_name" {
  
}
# variable "zones_for_public_subnets"{
#     type=list(string)
    
# }
# variable "cidr_for_public_subnets"{
#     type=list(string)
    
# }
# variable "name_for_public_subnets"{
#     type=list(string)
    
# }
# variable "zones_for_private_subnets"{
#     type=list(string)
    
# }
# variable "cidr_for_private_subnets"{
#     type=list(string)
    
# }
# variable "name_for_private_subnets"{
#     type=list(string)
    
# }
variable public_subnets {
    type= map(object({
        cidr=string
        zone=string
        Name=string

    }))
    
}

variable private_subnets {
    type= map(object({
        cidr=string
        zone=string
        Name=string

    }))
    
}

variable currency {
    type=map(string)
    default= {
        "Myanmar":"Kyat"
        "US":"Dollar"
        "Thailand":"Baht"
    }
}
