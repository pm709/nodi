use admin
db.createUser(
  {
    user: '$MONGO_ADMIN_USER',
    pwd: '$MONGO_ADMIN_PASWD',
    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
  }
)
