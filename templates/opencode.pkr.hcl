packer {
  required_plugins {
    tart = {
      version = ">= 1.12.0"
      source  = "github.com/cirruslabs/tart"
    }
  }
}

source "tart-cli" "tart" {
  vm_base_name = "ghcr.io/cirruslabs/macos-tahoe-xcode:latest"
  vm_name      = "tahoe-opencode:latest"
  ssh_password = "admin"
  ssh_username = "admin"
  ssh_timeout  = "120s"
}

build {
  sources = ["source.tart-cli.tart"]

  provisioner "shell" {
    inline = [
      "source ~/.zprofile",
      "brew update",
      "brew install opencode",
      "opencode --version",
      "xcodebuild -downloadComponent MetalToolchain",
      "xcodebuild -downloadPlatform iOS",
      "xcrun simctl list runtimes"
    ]
  }
}
