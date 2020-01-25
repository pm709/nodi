use admin
db.auth('$MONGO_ADMIN_USER', '$MONGO_ADMIN_PASWD' )

use $MONGO_DB
db.createUser(
{
    user: '$MONGO_USER', pwd: '$MONGO_PASWD',
    roles: [
        {
            role: "dbOwner",
            db: '$MONGO_DB'
        }
    ]
}
)
