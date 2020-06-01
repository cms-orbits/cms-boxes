db.getSiblingDB('cmsdb').createUser(
  {
    user: "cmsuser",
    pwd: "notsecure",
    roles: [ { role: "readWrite", db: "cmsdb" } ]
  }
)
