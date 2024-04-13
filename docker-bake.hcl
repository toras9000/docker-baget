variable "WITH_LATEST_TAG" {
  default = false
}

variable "BAGET_IMAGE_VER" {
  default = "0.3.0-preview1"
}

variable "BAGET_FLAVORS" {
  default = [""]
}

variable "flavor_tags" {
  default = [for f in BAGET_FLAVORS : f == "" ? BAGET_IMAGE_VER : "${BAGET_IMAGE_VER}-${f}"]
}

group "default" {
  targets = ["baget"]
}

target "baget" {
  context = "./build"
  args = {
    BAGET_VER = "v${BAGET_IMAGE_VER}"
  }
  platforms = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v7",
  ]
  tags = concat(
    formatlist("toras9000/baget-mp:%s",             flavor_tags),
    formatlist("ghcr.io/toras9000/docker-baget:%s", flavor_tags),
    WITH_LATEST_TAG ? ["toras9000/baget-mp:latest", "ghcr.io/toras9000/docker-baget:latest", ] : []
  )
}
