package taskmanager.backend.models.base

import org.bson.codecs.pojo.annotations.BsonId
import org.bson.types.ObjectId
import taskmanager.backend.models.interfaces.BaseEntity
import java.util.*

abstract class BaseEntityImpl(
    @BsonId override val _id: ObjectId = ObjectId(),

    override val createdAt: Date = Date(),
    override var updatedAt: Date? = null
) : BaseEntity