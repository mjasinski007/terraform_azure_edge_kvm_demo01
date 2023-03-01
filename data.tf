


data "template_file" "initial_kvm_bootstrap" {
    template = file("${path.module}/initial_scripts/initial_kvm_bootstrap.sh")
    vars = {
        TF_VERSION="1.3.9"
        #password = var.bastion_password
    }
}


/* 
data "template_file" "intial_cloud_init" {
    template = file("${path.module}/scripts/cloud-init.tpl")
    vars = {
        #name     = "Spoke_WestUS_VM"
        #password = var.bastion_password
    }
}

data "template_cloudinit_config" "cloudinit_config" {
    gzip          = true
    base64_encode = true

    part {
        content_type = "text/cloud-config"
        content      = data.template_file.intial_cloud_init.rendered
    }
}

 */





