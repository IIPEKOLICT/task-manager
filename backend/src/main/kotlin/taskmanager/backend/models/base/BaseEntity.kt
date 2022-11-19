package taskmanager.backend.models.base

import org.bson.codecs.pojo.annotations.BsonId
import org.bson.types.ObjectId
import java.util.*

abstract class BaseEntity(
    @BsonId val _id: ObjectId = ObjectId(),

    val createdAt: Date = Date(),
    var updatedAt: Date? = null
)