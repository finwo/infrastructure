id = "uc-controller-config"
name = "uc-controller-config"
type = "csi"
plugin_id = "ceph-csi"
capacity_max = "16G"
capacity_min = "2G"

capability {
  access_mode     = "single-node-writer"
  attachment_mode = "file-system"
}

secrets {
  userID  = "admin"
  userKey = "${CEPHCLIENT_ADMIN_KEY}"
}

parameters {
  clusterID = "31d500aa-d0b2-11ec-9158-87920b888671"
  pool = "nomad"
  imageFeatures = "layering"
}
