locals {
  directories       = distinct([for f in fileset("${path.module}/root", "**") : dirname(f)])
  management_groups = { for d in local.directories : replace(d, "/", "-") => replace(dirname(d), "/", "-") }
  groups            = { for f in fileset("${path.module}/root", "**/groups.yaml") : replace(dirname(f), "/", "-") => { for s in split("---", file("${path.module}/root/${f}")) : yamldecode(s).name => yamldecode(s) } }
  roles             = { for f in fileset("${path.module}/root", "**/roles.yaml") : replace(dirname(f), "/", "-") => { for s in split("---", file("${path.module}/root/${f}")) : yamldecode(s).name => yamldecode(s) } }
}
